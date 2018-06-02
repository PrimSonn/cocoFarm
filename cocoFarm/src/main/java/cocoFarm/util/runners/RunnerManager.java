package cocoFarm.util.runners;

import java.util.ArrayList;
import java.util.function.Supplier;

import cocoFarm.dao.TimerDao;
import cocoFarm.dto.TimerDto;

public final class RunnerManager {

	static TimerDao timerDao;
	static volatile boolean SHOULDRUN = true;
	private static ArrayList<Thread> member = new ArrayList<Thread>();
	
	public static synchronized void init(TimerDao timerDao) {
		
		RunnerManager.timerDao = timerDao;
		putThread( () -> RunnerManager.timerDao.auctionExpire(new TimerDto()) , "auctionExpire");
		putThread( () -> RunnerManager.timerDao.bidContractExpire(new TimerDto()) , "bidContractExpire");

		member.stream()
			.filter(runner -> !runner.isAlive())
			.forEach(runner -> runner.start());
	}
	
	private static boolean putThread(Supplier<TimerDto> timerSupplier, String name) {
		return RunnerManager.member.add(new Thread(new CocoRunner(timerSupplier, name)));
	}
	
	public static boolean isRunning() {
		return member.stream().allMatch(runner -> runner.isAlive());
	}

	public static void finish() {
		SHOULDRUN = false;
		killAll(); //------ 테스트 환경에서 타이머가 몇분이고 몇날이고 잠들어있는 것을 방지
	}
	
	@SuppressWarnings("deprecation")
	private static void killAll() {
		member.stream()
			.filter(runner -> runner.isAlive())
			.forEach(runner -> runner.stop())
		;
	}
	
}
