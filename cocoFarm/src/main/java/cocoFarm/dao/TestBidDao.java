package cocoFarm.dao;

import java.util.List;

import cocoFarm.dto.BidDto;

public interface TestBidDao {

	public List<BidDto> getBidList();
	public void putBid(BidDto bid);
}
