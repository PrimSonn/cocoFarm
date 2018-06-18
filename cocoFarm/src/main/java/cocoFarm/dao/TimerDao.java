package cocoFarm.dao;

import cocoFarm.dto.TimerDto;
import cocoFarm.util.runners.Run;

public interface TimerDao {
	@Run(maxSleep = 10800000L, minSleep = 10000L) public void auctionExpire(TimerDto timer);
	@Run(maxSleep = 10800000L, minSleep = 10000L) public void bidContractExpire(TimerDto timer);
	@Run(maxSleep = 21600000L, minSleep = 300000L) public void tempRcptClear(TimerDto timer);
}
