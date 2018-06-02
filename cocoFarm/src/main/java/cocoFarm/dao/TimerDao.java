package cocoFarm.dao;

import cocoFarm.dto.TimerDto;

public interface TimerDao {
	public TimerDto auctionExpire(TimerDto timer);
	public TimerDto bidContractExpire(TimerDto timer);
}
