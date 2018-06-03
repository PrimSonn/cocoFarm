package cocoFarm.dao;

import cocoFarm.dto.TimerDto;
import cocoFarm.util.runners.Run;

public interface TimerDao {
	@Run(runTest =1) public TimerDto auctionExpire(TimerDto timer);
	@Run(runTest =1) public TimerDto bidContractExpire(TimerDto timer);
}
