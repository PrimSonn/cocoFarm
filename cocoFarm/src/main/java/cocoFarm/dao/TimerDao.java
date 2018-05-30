package cocoFarm.dao;

import cocoFarm.dto.UniversalTimerDto;

public interface TimerDao {
	public UniversalTimerDto doExpire(UniversalTimerDto timer);
}
