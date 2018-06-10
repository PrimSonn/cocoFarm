package cocoFarm.dao;

import cocoFarm.dto.OptReceiptMkr;
import cocoFarm.dto.RecptCallParamHolder;

public interface ReceiptDao {
	
	public void tempRecpt(OptReceiptMkr paramHolder);
	public void checkRecpt(RecptCallParamHolder paramHolder);
	
	public RecptCallParamHolder callTempRecptMkr(RecptCallParamHolder paramHolder);
	public void tester (OptReceiptMkr paramHolder);
}
