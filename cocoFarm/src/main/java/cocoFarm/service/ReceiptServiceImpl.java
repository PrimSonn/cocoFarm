package cocoFarm.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cocoFarm.dao.ReceiptDao;
import cocoFarm.dto.ReceiptDto;
//import cocoFarm.dto.OptReceiptMkr;
import cocoFarm.dto.RecptCallParamHolder;
import cocoFarm.util.recptMaker.DataResolver;
//import cocoFarm.util.recptMaker.DataResolver;
import cocoFarm.util.recptMaker.SaleOptSerializer;
import cocoFarm.util.recptMaker.Serializer;
//import cocoFarm.util.recptMaker.Serializer;
import cocoFarm.util.recptMaker.Tester;

@Service
public class ReceiptServiceImpl implements ReceiptService{

	@Autowired ReceiptDao recptDao;

	@Override
	public RecptCallParamHolder makeTempReceipt(Integer accountIdx, String paid_name, Serializer target) {

		RecptCallParamHolder holder = new RecptCallParamHolder(accountIdx, paid_name, target.doSerialize());
		recptDao.callTempRecptMkr(holder);
		return holder;
	};
	
	@Override
	public RecptCallParamHolder makeTempReceipt(Integer accountIdx, String paid_name, List<? extends Serializer> targetList) {
		
		RecptCallParamHolder holder = new RecptCallParamHolder(accountIdx, paid_name, DataResolver.resolve(targetList));
		recptDao.callTempRecptMkr(holder);
		return holder;
	}
	
	@Override
	public RecptCallParamHolder makeTempReceipt(Integer accountIdx, String paid_name, List<? extends Serializer> targetList, List<? extends Serializer> targetList2) {
		
		RecptCallParamHolder holder = new RecptCallParamHolder(accountIdx, paid_name, DataResolver.resolve(targetList, targetList2));
		recptDao.callTempRecptMkr(holder);
		return holder;
	}
	
	@Override
	public Integer recptCheck(RecptCallParamHolder paramHolder) {
		
		recptDao.checkRecpt(paramHolder);
		
		return paramHolder.getIsDone();
	}

	@Override
	public Integer refundRecptMkr(String in_recpt_idx, String in_pay_code) {
		
		RecptCallParamHolder holder = new RecptCallParamHolder(in_recpt_idx, in_pay_code);
		recptDao.refundRecptMkr(holder);
		
		return holder.getIsDone();
	}

	@Override
	public void test() {
		
		List<SaleOptSerializer> list = new ArrayList<SaleOptSerializer>();
		list.add(new Tester(1));
		list.add(new Tester(2));
		list.add(new Tester(4));
		
		RecptCallParamHolder param = new RecptCallParamHolder(0,"test",DataResolver.resolve(list));
		recptDao.callTempRecptMkr(param);
	}

	@Override
	public void cancelPayment(String target) {
		recptDao.cancelRecpt(target);
	}
	
	//2018년 6월 14일 상원이형 작업
	@Override
	public List<ReceiptDto> paynee(int accIdx) {
		
		return recptDao.paynee(accIdx);
	}
	
	
	
}
