package cocoFarm.util.runners;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Hashtable;
import java.util.function.Supplier;

import cocoFarm.dao.TimerDao;
import cocoFarm.dto.TimerDto;

public final class RunnerManager {

	static TimerDao timerDao;
	static volatile boolean SHOULDRUN = true;
	private static Hashtable<Method,Thread> member = new Hashtable<Method,Thread>();
	
	@SuppressWarnings({ "unchecked", "rawtypes", "deprecation" })
	public static synchronized void init(TimerDao timerDao) {
		
		RunnerManager.timerDao = timerDao;
				
		for(Class interfc : timerDao.getClass().getInterfaces()) {//--- TimerDao 의 메소드를 동적으로 불러와서 CocoRunner 에 넣고 쓰레드를 만들음.
			System.out.println(interfc.toString());
			if(interfc.isAssignableFrom(TimerDao.class)) {
				for(Method method: interfc.getMethods()) {
					if(method.isAnnotationPresent(Run.class)) {
						
						try {
							Thread wasThere = 
								putThread( method ,() -> {
									try {
										return (TimerDto)method.invoke(timerDao, new TimerDto());
									} catch (IllegalAccessException | IllegalArgumentException | InvocationTargetException e) {
										e.printStackTrace();
									}
									return null;
									}// supplier functional interface declaration ends.
								, method.getName());
							if(wasThere!=null&&wasThere.isAlive()) wasThere.stop();//--만약 쓰레드가 등록이 미리 되어있는 것이 있었다면 정지시킴.(나중에 없애야 할 코드)
						} catch (IllegalArgumentException e) {
							e.printStackTrace();
						}//try catch ends
						
					}//annotation check : is @Run
				}//foreach TimerDao methods..
			}//timerDao interface check ends
		}//timerDao interface foreach ends
		
		startRun();
	}//method declaration ends;
	
	
	public static void startRun() {//---------------등록한 쓰레드들 중 작동중이 아닌 모든 쓰레드들을 시작.
		member.values().stream()
		.filter(runner -> !runner.isAlive())
		.forEach(runner -> runner.start());
	}
	
	
	private static Thread putThread(Method method, Supplier<TimerDto> timerSupplier, String name) {
		return member.put( method, new Thread(new CocoRunner(timerSupplier, name)) );
	}
	
	
	public static boolean isAllRunning() {
		return member.values().stream().allMatch(runner -> runner.isAlive());
	}
	
	
	public static void finish() {
		SHOULDRUN = false;
		killAll(); //------ 테스트 환경에서 타이머가 몇분이고 몇날이고 잠들어있는 것을 방지
	}
	
	
	@SuppressWarnings("deprecation")
	private static void killAll() {
		member.values().stream()
			.filter(runner -> runner.isAlive())
			.forEach(runner -> runner.stop())
		;
	}
	
}
