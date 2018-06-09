package cocoFarm.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cocoFarm.dao.ReceiptDao;
import cocoFarm.dto.OptReceiptMkr;
import cocoFarm.dto.RecptCallParamHolder;
import cocoFarm.util.recptMaker.DataResolver;
import cocoFarm.util.recptMaker.SaleOptSerializer;
import cocoFarm.util.recptMaker.Serializer;
import cocoFarm.util.recptMaker.Tester;


@Service
public class ReceiptServiceImpl implements ReceiptService{

	@Autowired ReceiptDao recptDao;

	@Override
	public OptReceiptMkr makeTempReceipt(Integer accountIdx, String paid_name, List<SaleOptSerializer> targetList) {
		
		OptReceiptMkr holder = new OptReceiptMkr(accountIdx,paid_name, targetList);
		recptDao.tempRecpt(holder);
		
		System.out.println("holder: "+holder);
		return holder;
	}

	@Override
	public void test() {
		List<SaleOptSerializer> list = new ArrayList<SaleOptSerializer>();
		list.add(new Tester(1));
		list.add(new Tester(2));
		list.add(new Tester(4));
		OptReceiptMkr holder = new OptReceiptMkr(2,"name",list);
		System.out.println(holder);
		
		recptDao.tempRecpt(holder);
//		recptDao.tester(holder);
		
		System.out.println("isNull? " +(holder==null));
		System.out.println(holder);
		System.out.println("--------------------------------------");
//		holder.getMainRcpt();
	}

	@Override
	public Integer recptCheck(RecptCallParamHolder paramHolder) {
		
		recptDao.checkRecpt(paramHolder);
		
		return paramHolder.getIsDone();
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
