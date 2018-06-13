package cocoFarm.service;

import java.util.List;

import cocoFarm.dto.RecptCallParamHolder;
import cocoFarm.util.recptMaker.Serializer;

public interface ReceiptService {
	
	public RecptCallParamHolder makeTempReceipt(Integer accountIdx, String paid_name, Serializer target);
	public RecptCallParamHolder makeTempReceipt(Integer accountIdx, String paid_name, List<? extends Serializer> targetList);
	public RecptCallParamHolder makeTempReceipt(Integer accountIdx, String paid_name, List<? extends Serializer> targetList, List<? extends Serializer> targetList2);
	public Integer refundRecptMkr(String in_recpt_idx, String in_pay_code);
	public void cancelPayment (String target);
	
	public void test ();
	public Integer recptCheck(RecptCallParamHolder paramHolder);
}
