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
import java.util.function.BiFunction;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cocoFarm.dto.RecptCallParamHolder;


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

	/*============================================================
	
	결제정보 조회시 아임포트 응답 중 쓸 부분.
	"response":
	{"amount":15000
		,"cancel_amount":0
		,"cancel_history":[]
		,"cancel_reason":null
		,"cancel_receipt_urls":[]
		,"cancelled_at":0
		,"imp_uid":"imp_796796903542"
		,"merchant_uid":"63"
		,"status":"paid",}
		
	*============================================================*/

	/*============================================================================================================================
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
	 *	서비스 안에서 환불 시도까지 하고 있음. (환불 영수증을 추가로 작성하고, 상태값 변화하는 부분 아직 미완성)
	 *  결제 취소가 일어났을 때(사용자가 아임포트 결제를 하다가 취소했을 때) 임시 영수증을 삭제하기 위해 추가 로직이 필요.
	 *  
	 =============================================================================================================================*/
	@Override
	public Integer checkPayment(String imp_uid, Integer accIdx){

		try {
			
			BiFunction<String,String,String> post= ( req, url )-> {
				String body = null;
				HttpURLConnection conn;
				try {
					conn = (HttpURLConnection)new URL(url).openConnection();
					conn.setRequestMethod("POST");
					conn.setDoOutput(true);
					conn.setRequestProperty("Accept-Charset", CHARSET);
					conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded;charset=" + CHARSET);
					
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
			
			
			String req = String.format("imp_key=%s&imp_secret=%s"
										, URLEncoder.encode(IMP_KEY, CHARSET)
										,URLEncoder.encode(IMP_SECRET, CHARSET));
			String accToken = tokenParser(post.apply(req, GET_TOKEN), "access_token");
			if(accToken ==null || accToken == "") return -106;
			//-------------여기까지 접속용 토큰을 받아옴, 아래 부터는 토큰을 이용해 결제 정보를 받아옴.
			
			HttpURLConnection conn = (HttpURLConnection)new URL(GET_PAYCHECK+imp_uid).openConnection();
			conn.setRequestProperty("Authorization", accToken);
			conn.setRequestProperty("Accept-Charset", CHARSET);
			Integer respCode = conn.getResponseCode();
			if (respCode!=200) return -107;
			String body = getRespBody(conn, conn.getInputStream());
			
			if(!tokenParser(body,"status").equals("paid")) return -20;
			
			String merchant_uid;
			merchant_uid = tokenParser(body,"merchant_uid");
			Integer moneyAmount;
			try {
				moneyAmount = Integer.parseInt(tokenParser(body, "amount"));
				
			}catch(NumberFormatException e) {
				e.printStackTrace();
				return 108;
			}
			if(merchant_uid ==null || moneyAmount ==null) return 109;
			
			//--------- 받아온 결제 정보를 DB의 정보와 비교
			Integer resultCode = recptSvc.recptCheck(new RecptCallParamHolder(imp_uid,accIdx, merchant_uid, moneyAmount, 0));
			
			if(resultCode==null) {
				return 110;
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
						reason = "해당 결제와 요청 계정이 다름";
						break;
					case -4:
						reason = "임시 처리한 영수증의 금액과 결제 정보의 금액이 다름.";
						break;
					case -5:
						reason = "대상 옵션이 활성화 상태가 아님 (삭제되었거나, 그 외 비활성 상태)";
						break;
					case -6:
						reason = "구매를 요청한 옵션 중 최소 하나의 옵션이 남은 재고가 부족함";
						break;
					case -7:
						reason = "처리 과정 중, 무언가 매우 잘못됨";
						break;
					default:
						reason = "error";
						break;
				}
				accToken = tokenParser(post.apply(req, GET_TOKEN), "access_token");
				if(accToken ==null || accToken == "") return -111;
				
				req = String.format("imp_uid=%s&reason=%s, args)"
									,URLEncoder.encode(imp_uid, CHARSET)
									,URLEncoder.encode(reason, CHARSET));
				body = post.apply(req, CANCEL_PAYMENT);
				if (body==null||body.equals("")) return 112;
				
				/*
				 * 
				 * 환불 요청을 한 후의 로직? 
				 * 
				 * 
				 * 
				 * */
				
			}
			
			return resultCode;
			
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return -100;
		} catch (MalformedURLException e) {
			e.printStackTrace();
			return -101;
		} catch (IOException e) {
			e.printStackTrace();
			return -102;
		} catch(IndexOutOfBoundsException e) {
			e.printStackTrace();
			return -103;
		}
	}
	
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
		        for (String line; (line = reader.readLine()) != null;) {
//		        	respLine.concat(line); //---- Dosn't work!!
		            respLine += line;
		        }
		    }
		} else {return null;}
		
		resp.close();
		
		return respLine;
	}
	
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
