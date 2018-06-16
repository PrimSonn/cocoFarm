package cocoFarm.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cocoFarm.dto.RecptCallParamHolder;

interface TriFunc<T,U,V,R> {
	R apply(T arg,U arg2,V arg3);
}

@Service
public class RestSvcImpl implements RestSvc{
	
	@Autowired ReceiptService recptSvc;
	
	private static final String IMP_URL = "https://api.iamport.kr";
	private static final String IMP_TOKEN = "/users/getToken";
	private static final String IMP_PAYCHECK = "/payments/";
	private static final String IMP_CANCEL = "cancel";

	private static final String IMP_KEY = "8794812589992014";
	private static final String IMP_SECRET = "we9JVddJUadLlumbrk6Eqd9nXPxUaY8Hcir8vERqP5baAxm1SsGiFPFDFcxQbGyoZZwvEoVut7E3F15x";
	private static final String CHARSET = java.nio.charset.StandardCharsets.UTF_8.name();
	
	private static final String GET_TOKEN = IMP_URL + IMP_TOKEN;
	private static final String GET_PAYCHECK = IMP_URL + IMP_PAYCHECK;
	private static final String CANCEL_PAYMENT = GET_PAYCHECK + IMP_CANCEL;

	/*==============================================================================================================================
	 * 
	 * 결과를 문자열 배열 ["결과 코드", "결과 설명"] 으로 내보냄.
	 * 
	 * 	merchant_uid:	아임포트에서 받아올 주 영수증 구분번호
	 *	imp_uid:		아임포트 결제번호
	 *	accToken:		아임포트 REST 서비스를 이용하기 위해 받아오는 접속 토큰(지속시간 짧음, 매번 받아야 함.)
	 *	accIdx:			결제정보 인증용 계정번호, 세션에서 가져오기
	 *	post:			POST 요청 후 응답을 문자열로 가져옴.
	 *	
	 *	결제정보 조회시 아임포트 응답 중 쓸 만한 부분.
	 *	"response":
	 *	{"amount":15000
	 *		,"cancel_amount":0
	 *		,"cancel_history":[]
	 *		,"cancel_reason":null
	 *		,"cancel_receipt_urls":[]
	 *		,"cancelled_at":0
	 *		,"imp_uid":"imp_796796903542"
	 *		,"merchant_uid":"63"
	 *		,"status":"paid",}
	 *
	 * 결과값 설명
	 * 		-100 이하: 코드상의 오류 혹은 각종 예외상황
	 * 		-20: 결제상태가 "paid" 가 아님
	 * 	아래는 DB 접속 결과 코드 (위의 경우가 아닌 경우 결과값으로 반환해옴)
	 * 	   -결제 정보 확인 후 코드:
	 * 		2: 해당 영수증이 임시 대기 상태가 아니며 같은 결제번호로 요청이 들어옴 (누군가 의도적으로 중복값을 보냄. 환불 대상이 아님)
	 *		1: 성공
	 *		0: 에러
	 *  	-1: 해당 번호의 임시 영수증이 없음.
	 *		-2: 해당 영수증이 처리 불가능한 상태임 ('임시 대기' 상태가 아님.)
	 *		-3: 해당 번호의 영수증이 있고, 임시 영수증인데 요청 계정이 다름(뭔가 잘못됨, 환불해야 함!!)
	 *		-4: 임시 처리한 영수증의 금액과 결제 정보의 금액이 다름. (임시 영수증 삭제함, 환불해야됨!!)
	 *		-5: 임시 영수증에 저장된 옵션이 활성화 상태가 아님 (삭제되었거나, 그 외 비활성 상태, 역시 환불해야 함!!)
	 *		-6: 구매한 옵션 중 최소 하나의 옵션이 남은 재고가 부족함 ( 환불해야 함!!!)
	 *		-7: 뭔가 매우 잘못됨 (환불해야 함!!)
	 *		-8: 대상 입찰중 하나 이상의 입찰이 낙찰 대기중이 아님.
	 *		-9: 영수증의 대상 목록이 없음.
	 *	서비스 안에서 환불 시도까지 하고 있음. (환불 영수증을 추가로 작성하고, 상태값 변화하는 부분 아직 미완성)
	 *  결제 취소가 일어났을 때(사용자가 아임포트 결제를 하다가 취소했을 때) 임시 영수증을 삭제하기 위해 추가 로직이 필요.
	 *  
	 =============================================================================================================================*/
	@Override
	public String[] checkPayment(String imp_uid, Integer accIdx){

		String[] resultArr = new String[2];
		
		try {
			TriFunc<String,String,String,String> post= ( req, url, accToken)-> {
				String body = null;
				HttpURLConnection conn;
				try {
					conn = (HttpURLConnection)new URL(url).openConnection();
					conn.setRequestMethod("POST");
					conn.setDoOutput(true);
					conn.setRequestProperty("Accept-Charset", CHARSET);
					conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded;charset=" + CHARSET);
					if(accToken !=null && !accToken.equals("")) {
						conn.setRequestProperty("Authorization", accToken);
					}
					try (OutputStream output = conn.getOutputStream()) {
					    output.write(req.getBytes(CHARSET));
					}
					Integer respCode = conn.getResponseCode();
					if (respCode!=200) return null;
					body = getRespBody(conn, conn.getInputStream());
					
				} catch (IOException e) {
					e.printStackTrace();
					return null;
				}
				return body;
			};
			
			final String tokenReq = String.format("imp_key=%s&imp_secret=%s"
										, URLEncoder.encode(IMP_KEY, CHARSET)
										,URLEncoder.encode(IMP_SECRET, CHARSET));
			
			String accToken = tokenParser(post.apply(tokenReq, GET_TOKEN, null), "access_token");
			if(accToken ==null || accToken == "") {
				resultArr[0]="-105";
				resultArr[1]="거래 정보 조회 중 접속 이상. 관리자에게 문의하세요.";
				return resultArr;
			}
			//-------------여기까지 접속용 토큰을 받아옴, 아래 부터는 토큰을 이용해 결제 정보를 받아옴.
			
			HttpURLConnection conn = (HttpURLConnection)new URL(GET_PAYCHECK+imp_uid).openConnection();
			conn.setRequestProperty("Authorization", accToken);
			conn.setRequestProperty("Accept-Charset", CHARSET);
			Integer respCode = conn.getResponseCode();
			
			if (respCode!=200) {
				resultArr[0]="-106";
				resultArr[1]="거래 정보 조회 중 접속 이상. 관리자에게 문의하세요.";
				return resultArr;
			}
			String body = getRespBody(conn, conn.getInputStream());
			
			if(!tokenParser(body,"status").equals("paid")) {
				resultArr[0] = "-20";
				resultArr[1] = "이미 지불한 거래입니다.";
				return resultArr;
			}
			
			String merchant_uid;
			merchant_uid = tokenParser(body,"merchant_uid");
			Integer moneyAmount;
			
			try {
				moneyAmount = Integer.parseInt(tokenParser(body, "amount"));
				
			}catch(NumberFormatException e) {
				e.printStackTrace();
				resultArr[0]="-107";
				resultArr[1] = "결제정보 조회 실패. 관리자에게 문의하세요";
				return resultArr;
			}
			if(merchant_uid ==null || moneyAmount ==null) {
				resultArr[0] = "-108";
				resultArr[1] = "결제정보 조회 실패. 관리자에게 문의하세요";
				return resultArr;
			}
			
			//--------- 받아온 결제 정보를 DB의 정보와 비교
			Integer resultCode = recptSvc.recptCheck(new RecptCallParamHolder(accIdx, imp_uid, merchant_uid, moneyAmount, 0));
			
			if(resultCode==null) {
				resultArr[0] = "-109";
				resultArr[1] = "결제정보 확인 실패. 관리자에게 문의하세요";
				return resultArr;
			}else if(resultCode==0){
				resultArr[0] = "-116";
				resultArr[1] = "에러 발생. 관리자에게 문의하세요.";
			}else if (resultCode>-100 && resultCode <0) {//0인 경우의 환불은 해야할 지 말아야 할 지 모름(서버 측 에러상황) -100 이하도 마찬가지..
				String reason = null;
				switch (resultCode) {
					case -1:
						reason = "해당 번호의 임시 영수증이 없음.";
						break;
					case -2:
						reason = "해당 영수증이 처리 불가능한 상태임 ('임시 대기' 상태가 아님.)";
						break;
					case -3:
						reason = "해당 결제와 요청 계정이 다름.";
						break;
					case -4:
						reason = "임시 처리한 영수증의 금액과 결제 정보의 금액이 다름.";
						break;
					case -5:
						reason = "대상 옵션이 활성화 상태가 아님 (삭제되었거나, 그 외 비활성 상태).";
						break;
					case -6:
						reason = "구매를 요청한 옵션 중 최소 하나의 옵션이 남은 재고가 부족함.";
						break;
					case -7:
						reason = "처리 과정 중, 무언가 매우 잘못됨.";
						break;
					case -8:
						reason = "대상 입찰중 하나 이상의 입찰이 낙찰 대기중이 아님.";
						break;
					case -9:
						reason = "영수증의 대상 목록이 없음.";
						break;
					default:
						reason = "error. resultCode: "+resultCode;
						break;
				}
				
				accToken = tokenParser( post.apply(tokenReq, GET_TOKEN, null), "access_token");
				if(accToken ==null || accToken == "") {
					resultArr[0] = "-110";
					resultArr[1] = reason + " ,환불 요청 중 접속 문제 발생. 관리자에게 문의하세요.";
					return resultArr;
				}
				
				String refundReq = String.format("imp_uid=%s&reason=%s"
									,URLEncoder.encode(imp_uid, CHARSET)
									,URLEncoder.encode(reason, CHARSET));
				body = post.apply(refundReq, CANCEL_PAYMENT,accToken);
				if (body==null||body.equals("")) {
					resultArr[0] = "-111";
					resultArr[1] = reason + "환불 요청 중 접속 문제 발생. 관리자에게 문의하세요." ;
					return resultArr;
				}
				
				/*=======================================================================
				 * 
				 *	환불 요청 결과 코드값
				 *	"code"
				 *		1 이미 취소됨 "message": "이미 전액취소된 주문입니다.",
				 *		0 성공
				 *		-1 결제취소 실패, 
				 *	"message" : "환불결과 메세지"
				 *
				 *=======================================================================*/
				String refundCode = tokenParser(body,"code");
				
				if(refundCode.equals("0")) {
					if(recptSvc.refundRecptMkr(merchant_uid, imp_uid) ==1 ) {
						resultArr[0] = resultCode.toString();
						resultArr[1] = reason + ". 환불되었습니다.";
						return resultArr; //환불 영수증을 만든 후, 결과 성공(1)
					}else {
						resultArr[0] = resultCode.toString();
						resultArr[1] = reason + ". 환불 후 영수증 작성 실패. 관리자에게 문의하세요";
						return resultArr; //환불 영수증 만들기 실패
					}
				}else if(refundCode.equals("1")) {
					//이미 취소된 영수증?
					resultArr[0] = "-113";
					resultArr[1] = "이미 취소된 영수증 입니다.";
					return resultArr;
				}else {
					resultArr[0] = "-114";
					resultArr[1] = reason+ ", 환불 요청 에러 발생. 관리자에게 문의하세요.";
					return resultArr;
				}
				
			}else if(resultCode ==0) {
				resultArr[0] = resultCode.toString();
				resultArr[1] = "에러발생. 관리자에게 문의하세요.";
			}else if(resultCode ==2) {
				resultArr[0] = resultCode.toString();
				resultArr[1] = "잘못된 요청.";
			}
			
			if(resultCode==1) {
				resultArr[0] = resultCode.toString();
				resultArr[1] = "거래를 정상적으로 완료했습니다.";
				return resultArr;
			} else {
				resultArr[0] = resultCode.toString();
				resultArr[1] = "에러. 관리자에게 문의하세요.";
			}
			
			
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			resultArr[0] = "-101";
			resultArr[1] = "에러 발생. 관리자에게 문의하세요.";
			return resultArr;
		} catch (MalformedURLException e) {
			e.printStackTrace();
			resultArr[0] = "-102";
			resultArr[1] = "에러 발생. 관리자에게 문의하세요.";
			return resultArr;
		} catch (IOException e) {
			e.printStackTrace();
			resultArr[0] = "-103";
			resultArr[1] = "에러 발생. 관리자에게 문의하세요.";
			return resultArr;
		} catch(IndexOutOfBoundsException e) {
			e.printStackTrace();
			resultArr[0] = "-104";
			resultArr[1] = "에러 발생. 관리자에게 문의하세요.";
			return resultArr;
		}
		
		resultArr[0]="-115";
		resultArr[1]="에러 발생. 관리자에게 문의하세요.";
		return resultArr;
	}
	
	
	/*
	 *	아임포트와의 통신으로 받은 정보를 한 줄의 문자로 정리하기.
	 */
	private String getRespBody(HttpURLConnection conn, InputStream resp) throws UnsupportedEncodingException, IOException{
		
		if (resp ==null) return null;
		String contentType = conn.getHeaderField("Content-Type");
		String resCharset = null;
		String respLine = "";
		
		for (String param : contentType.replace(" ", "").split(";")) {
		    if (param.startsWith("charset=")) {
		    	resCharset = param.split("=", 2)[1];
		        break;
		    }
		}
		
		if (resCharset != null) {
		    try (BufferedReader reader = new BufferedReader(new InputStreamReader(resp, resCharset))) {
		    	StringBuilder sb = new StringBuilder(respLine);
		        for (String line; (line = reader.readLine()) != null;) {
		        	sb.append(line);
		        }
		        respLine = sb.toString();
		    }
		} else {return null;}
		
		resp.close();
		return respLine;
	}
	
	/*
	 *	GSon 쓰는거 배우기 귀찮아서 만듦 
	 *  targe: 찾을 JSon의 키 값 (따음표 떼고 입력)
	 *  target 에 해당하는 value 를 따음표까지 제거하고 문자열로 반환. 
	 */
	public static String tokenParser(String body, String target) throws IndexOutOfBoundsException{
		
		if(target==null||target.equals(""))return null;
		int cutter  = body.indexOf(target);
		if (cutter == -1) return null;
		body = body.substring(cutter+target.length());
		body = body.substring(body.indexOf(58)+1);// :까지 제거
		if(body.contains(",")) {
			body = body.substring(0, body.indexOf(44)).trim();// , 까지 선택후 공백제거
		}
		if(body.contains("\"")) {
			body = body.substring(body.indexOf(34)+1).trim();// " 까지 제거후 공백제거
			body = body.substring(0, body.indexOf(34)).trim();// " 전까지 선택후 공백제거 
		}
		
		return body;
	}
	
}
