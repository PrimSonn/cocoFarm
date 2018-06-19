package cocoFarm.util.runners;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Hashtable;

import cocoFarm.dao.TimerDao;
import cocoFarm.dto.TimerDto;

public final class RunnerManager {

	public static volatile boolean SHOULDRUN = true;
	private static Hashtable<Method,Thread> member = new Hashtable<Method,Thread>();
	private static TimerDao timerDao;
	
	private RunnerManager() {}

	@SuppressWarnings({ "unchecked", "rawtypes", "deprecation" })
	public static synchronized void init(TimerDao timerDao) {
		
		RunnerManager.timerDao = timerDao;

		for(Class interfc : timerDao.getClass().getInterfaces()) {//--- TimerDao 의 메소드를 동적으로 불러와서 CocoRunner 에 넣고 쓰레드를 만듦.
			if(interfc.isAssignableFrom(TimerDao.class)) {
				for(Method method: interfc.getMethods()) {
					if(method.isAnnotationPresent(Run.class)) {
						try {
							Thread wasThere = 
								member.put(method, new Thread( new CocoRunner( () ->{
												try {
													TimerDto timer = new TimerDto();
													method.invoke(timerDao, timer);
													return timer;
												} catch (IllegalAccessException | IllegalArgumentException | InvocationTargetException e) {
													e.printStackTrace();
												}
												return null;
												}
											, method.getName() )
										)
									);
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
	
	public static void restart() {
		RunnerManager.SHOULDRUN =true;
		init(timerDao);
	}
	
	private static void startRun() {//---------------등록한 쓰레드들 중 시작하지 않은 쓰레드들을 시작.
		member.values().stream()
		.filter(runner -> !runner.isAlive())
		.forEach(runner -> runner.start());
	}
	
	public static boolean isAllRunning() {
		return member.values().stream().allMatch(runner -> runner.isAlive());
	}
	
	public static HashMap<String,String> getStatus(){
		return member.keySet().stream()
			.collect(HashMap<String,String>::new
					, (res,ele)->{ res.put(ele.toString(), String.valueOf(member.get(ele).isAlive()) ); }
					, (r1,r2)->{r1.putAll(r2);}
					);
	}
	
	public static void finish() {
		SHOULDRUN = false;
		killAll(); //------ 테스트 환경에서 타이머가 몇분이고 몇날이고 잠들어있는 것을 방지. 개발이 끝나면 삭제해야 함.
	}
	
	@SuppressWarnings("deprecation")
	private static void killAll() {
		member.values().stream()
			.filter(runner -> runner.isAlive())
			.forEach(runner -> runner.stop())
		;
	}
	
}
