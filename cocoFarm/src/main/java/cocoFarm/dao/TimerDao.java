package cocoFarm.dao;

import cocoFarm.dto.TimerDto;
import cocoFarm.util.runners.Run;

public interface TimerDao {
	@Run() public TimerDto auctionExpire(TimerDto timer);
	@Run() public TimerDto bidContractExpire(TimerDto timer);
}
