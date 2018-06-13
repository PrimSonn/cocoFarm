package cocoFarm.dao;

import cocoFarm.dto.OptReceiptMkr;
import cocoFarm.dto.RecptCallParamHolder;

public interface ReceiptDao {
	
	public void tempRecpt(OptReceiptMkr paramHolder);
	public void checkRecpt(RecptCallParamHolder paramHolder);
	public void refundRecptMkr(RecptCallParamHolder paramHolder);
	public void callTempRecptMkr(RecptCallParamHolder paramHolder);
	public void cancelRecpt(String target);
	
	public void tester (OptReceiptMkr paramHolder);
}
