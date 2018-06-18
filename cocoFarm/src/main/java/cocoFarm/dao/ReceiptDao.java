package cocoFarm.dao;

import java.util.List;

import cocoFarm.dto.OptReceiptMkr;
import cocoFarm.dto.ReceiptDto;
import cocoFarm.dto.RecptCallParamHolder;

public interface ReceiptDao {
	
	public void tempRecpt(OptReceiptMkr paramHolder);
	public void checkRecpt(RecptCallParamHolder paramHolder);
	public void refundRecptMkr(RecptCallParamHolder paramHolder);
	public void callTempRecptMkr(RecptCallParamHolder paramHolder);
	public void cancelRecpt(String target);
	
	public void tester (OptReceiptMkr paramHolder);
	
//	2018년 6월 14일 상원이형 작업 - 일반 결제내역조회
	public List<ReceiptDto> paynee(int accIdx);
}
