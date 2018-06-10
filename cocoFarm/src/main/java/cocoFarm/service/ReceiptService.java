package cocoFarm.service;

import java.util.List;

import cocoFarm.dto.OptReceiptMkr;
import cocoFarm.dto.RecptCallParamHolder;
import cocoFarm.util.recptMaker.SaleOptSerializer;
import cocoFarm.util.recptMaker.Serializer;

public interface ReceiptService {
	
//	public boolean MakeTempReceipt(Integer accountIdx, List<Serializer> targetList);
	public OptReceiptMkr makeTempReceipt(Integer accountIdx, String paid_name, List<SaleOptSerializer> targetList);
	public void test ();
	public Integer recptCheck(RecptCallParamHolder paramHolder);
}
