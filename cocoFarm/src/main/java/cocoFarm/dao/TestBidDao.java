package cocoFarm.dao;

import java.util.List;

import cocoFarm.dto.TestBidDto;

public interface TestBidDao {

	public List<TestBidDto> getBidList();
	public void putBid(TestBidDto bid);
	public TestBidDto getWakeTime();
	public Integer auctionProc_1();
}
