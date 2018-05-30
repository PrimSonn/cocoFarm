package cocoFarm.util;

import java.time.DateTimeException;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;


import cocoFarm.dao.TimerDao;
import cocoFarm.dto.UniversalTimerDto;

public final class AuctionManager {
	
	private static Thread AuctionExpChecker = null;
	private static boolean AuctExpCheckerLife = true;
	private static TimerDao timerDao;
	
	public static void init(TimerDao dao) {
		
		timerDao = dao;
		
		if(AuctionExpChecker==null) {
			AuctionExpChecker = new Thread(new Runnable() {
				@Override
				public void run() {
					
					UniversalTimerDto timerDto = null;
					long sleepLength = 0L;
					LocalDateTime wakeTime = null;
					
					while (AuctExpCheckerLife) {
						System.out.println("\r\n\r\n-------Start Running!--------\r\n\r\n");//----------------testcode
						timerDto = timerDao.doExpire(new UniversalTimerDto());
						sleepLength = timerDto == null ? sleepLength : (ChronoUnit.MILLIS.between(timerDto.getDbTime().toLocalDateTime(), timerDto.getNextCheck().toLocalDateTime()));
						
						if(sleepLength == 0L) {
							sleepLength = 60000L;
						} else if (sleepLength > 21600000L) {
							sleepLength = 21600000L;
						} else if (sleepLength < 60000L ) {
							sleepLength = 60000L;
						}
						
						try {
							wakeTime = LocalDateTime.now().plusNanos(sleepLength*1000000L);
						} catch(DateTimeException e) {
							System.out.println("\r\n\r\n========================= wakeTime plus failed ===================== \r\n");
							break;
						}
						
						System.out.println("sleepLength: "+sleepLength+", wakeTime: "+wakeTime);
						
						try {
							Thread.sleep(sleepLength);
							while(LocalDateTime.now().compareTo(wakeTime)<=0) {
								Thread.sleep(ChronoUnit.MILLIS.between(LocalDateTime.now(), wakeTime));
							}
							System.out.println("Thread Awake!" + LocalDateTime.now());
						} catch (InterruptedException e) {
							e.printStackTrace();
						}// sleep try ends
						
					}//while true ends
				}//run override ends
			});//new thread ends
		}
		
		if(!AuctionExpChecker.isAlive()) {
			AuctionExpChecker.start();
		}
		
		
	}//init() ends
	
	public static boolean isOk() {
		return AuctionExpChecker.isAlive();
	}

	public static void finish() {
		AuctExpCheckerLife = false;
	}
	
}
