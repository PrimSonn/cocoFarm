package cocoFarm.dao;

import cocoFarm.dto.TimerDto;
import cocoFarm.util.runners.Run;

public interface TimerDao {
	@Run() public void auctionExpire(TimerDto timer);
	@Run() public void bidContractExpire(TimerDto timer);
	@Run() public void tempRcptClear(TimerDto timer);
}
