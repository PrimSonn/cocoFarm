package cocoFarm.dao;

import java.util.List;

import cocoFarm.dto.CheckerDto;
import cocoFarm.dto.TestBidDto;

public interface TestBidDao {

	public List<TestBidDto> getBidList();
	public void putBid(TestBidDto bid);
	public TestBidDto getWakeTime();
	public CheckerDto auctionProc_1 ();
}
