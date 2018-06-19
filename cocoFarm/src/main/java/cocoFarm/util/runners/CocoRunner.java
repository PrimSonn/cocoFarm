package cocoFarm.util.runners;

import java.time.DateTimeException;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.function.Supplier;

import cocoFarm.dto.TimerDto;


public class CocoRunner implements Runnable{
	
	Supplier<TimerDto> timerSupplier;
	String name;
	
	@SuppressWarnings("unused")
	private CocoRunner() {}
	
	public CocoRunner(Supplier<TimerDto> timerSupplier, String name) {
		this.timerSupplier = timerSupplier;
		this.name = name;
	}
	
	@Override
	public void run() {
		
		long sleepLength = 60000L;
		LocalDateTime wakeTime = null;
		
		while (RunnerManager.SHOULDRUN) {
			TimerDto timer = timerSupplier.get();
			
			sleepLength = timer == null ? sleepLength : (ChronoUnit.MILLIS.between(timer.getDbTime().toLocalDateTime(), timer.getNextCheck().toLocalDateTime()));
			timer = null;//Mybatis 특성상 새 인스턴스를 계속해서 넣어야 하기 때문에 매번 생성하고 다시 없애야 함.
			
			if (sleepLength > 21600000L) {
				sleepLength = 21600000L;
			} else if (sleepLength < 60000L ) {
				sleepLength = 60000L;
			}
			
			try {
				wakeTime = LocalDateTime.now().plusNanos(sleepLength*1000000L);// 나노초 -> 밀리초
			} catch(DateTimeException e) {
				break;
			}
			
			try {
				Thread.sleep(sleepLength);
				while(LocalDateTime.now().compareTo(wakeTime)<=0) {
					LocalDateTime now = LocalDateTime.now();// 한순간 깰 시간보다 이전이었다가, 다시 기다리는 시간을 계산하고 나면 시간이 지나서 결과값이 음수가 나오는 상황을 처리하는 코드.
					sleepLength =  ChronoUnit.MILLIS.between(now, wakeTime) > 0 ? ChronoUnit.MILLIS.between(now, wakeTime) : 0;
					Thread.sleep(sleepLength);
				}
			} catch (InterruptedException e) {
				e.printStackTrace();
			}// sleep try ends
		}//run while ends
	}
	
}
