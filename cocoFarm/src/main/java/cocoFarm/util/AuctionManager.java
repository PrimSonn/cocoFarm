package cocoFarm.util;


import java.sql.Timestamp;
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
					Timestamp sleepLength = null;
					LocalDateTime wakeTime = null;
					
					while (AuctExpCheckerLife) {
						System.out.println("\r\n\r\n-------Start Running!--------\r\n\r\n");//----------------testcode
						timerDto = timerDao.doExpire();
						sleepLength = timerDto == null ? null : timerDto.getTimeHolder();
						
						if(sleepLength == null) {
							sleepLength = new Timestamp(60000);
						} else if (sleepLength.after(new Timestamp(21600000))) {
							sleepLength = new Timestamp(21600000);
						} else if (sleepLength.before(new Timestamp(60000))) {
							sleepLength = new Timestamp(60000);
						}
						
						wakeTime = LocalDateTime.now().plusNanos(sleepLength.getTime()*1000L);
						if(wakeTime ==null) {
							System.out.println("\r\n\r\n========================= wakeTime Null ===================== \r\n");
							break;
						}
						
						try {
							Thread.sleep(sleepLength.getTime());
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
	
	public static boolean isAlive() {
		return AuctionExpChecker.isAlive();
	}

	public static void finish() {
		if (AuctionExpChecker !=null && AuctionExpChecker.isAlive()) AuctExpCheckerLife = false;
	}
	
}
