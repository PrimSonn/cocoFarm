package cocoFarm.dao;

import java.util.List;

import cocoFarm.dto.TestBidDto;
import cocoFarm.dto.TestDto;

public interface TestBidDao {

	public List<TestBidDto> getBidList();
	public void putBid(TestBidDto bid);
	public TestBidDto getWakeTime();
	public void auctionProc_1();
}
