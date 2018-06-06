package cocoFarm.dao;

import cocoFarm.dto.OptReceiptMkr;
import cocoFarm.dto.RecptCallParamHolder;

public interface ReceiptDao {
	
	public OptReceiptMkr tempRecpt(OptReceiptMkr paramHolder);
	public RecptCallParamHolder callTempRecptMkr(RecptCallParamHolder paramHolder);
}
