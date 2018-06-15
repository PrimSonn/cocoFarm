package cocoFarm.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cocoFarm.dao.ReceiptDao;
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
		
		System.out.println("=================service=============");
		System.out.println(target.doSerialize());
		RecptCallParamHolder holder = new RecptCallParamHolder(accountIdx, paid_name, target.doSerialize());
		recptDao.callTempRecptMkr(holder);
		return holder;
	};
	
	@Override
	public RecptCallParamHolder makeTempReceipt(Integer accountIdx, String paid_name, List<? extends Serializer> targetList) {
		
//		OptReceiptMkr holder = new OptReceiptMkr(accountIdx,paid_name, targetList);
//		recptDao.tempRecpt(holder);
//		System.out.println("holder: "+holder);
		
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
//		OptReceiptMkr holder = new OptReceiptMkr(2,"name",list);
//		System.out.println(holder);
		
		/*
		recptDao.tempRecpt(holder);
//		recptDao.tester(holder);
		System.out.println("isNull? " +(holder==null));
		System.out.println(holder);
		*/
		
		System.out.println("--------------------------------------");
		System.out.println("DataSerialization Test: ");
		System.out.println("Serialized Data: "+DataResolver.resolve(list));
		System.out.println("--------------------------------------");
		RecptCallParamHolder param = new RecptCallParamHolder(0,"test",DataResolver.resolve(list));
		recptDao.callTempRecptMkr(param);
		System.out.println("main_recpt: "+param.getArg3()+", isDone: "+param.getIsDone());
		
//		System.out.println(DataResolver.);
//		holder.getMainRcpt();
	}

	@Override
	public void cancelPayment(String target) {
		recptDao.cancelRecpt(target);
	}
	
	
//	@Override
//	public boolean MakeTempReceipt(Integer accountIdx, List<Serializer> targetList) {
//	
//		RecptCallParamHolder holder = new RecptCallParamHolder( accountIdx, DataResolver.resolve(targetList), Integer.valueOf(0));
//		recptDao.callTempRecptMkr(holder);
//		
//		if(holder.getIsDone()==1) {
//			return true;
//		}
//		
//		return false;
//	}

}
