package cocoFarm.util.runners;

import java.lang.annotation.Annotation;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.function.Supplier;

import org.springframework.core.annotation.AnnotationUtils;

import cocoFarm.dao.TimerDao;
import cocoFarm.dto.TimerDto;

public final class RunnerManager {

	static TimerDao timerDao;
	static volatile boolean SHOULDRUN = true;
	private static ArrayList<Thread> member = new ArrayList<Thread>();
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public static synchronized void init(TimerDao timerDao) {
		
		RunnerManager.timerDao = timerDao;
//		putThread( () -> RunnerManager.timerDao.auctionExpire(new TimerDto()) , "auctionExpire");
//		putThread( () -> RunnerManager.timerDao.bidContractExpire(new TimerDto()) , "bidContractExpire");
		
		
		for(Class interfc : timerDao.getClass().getInterfaces()) {
			System.out.println(interfc.toString());
			if(interfc.isAssignableFrom(TimerDao.class)) {
				for(Method method: interfc.getMethods()) {
					if(method.isAnnotationPresent(Run.class)) {
						
						try {
							putThread( () -> {
								try {
									return (TimerDto)method.invoke(timerDao, new TimerDto());
								} catch (IllegalAccessException | IllegalArgumentException | InvocationTargetException e) {
									e.printStackTrace();
								}
								return null;
								}
							, method.getName());
							
						} catch (IllegalArgumentException e) {
							e.printStackTrace();
						}//try catch ends
						
					}//annotation check : is @Run
					
				}//foreach TimerDao methods..
				
			}//timerDao interface check
			
		}//timerDao interface foreach
		
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
