package cocoFarm.listener;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;

import cocoFarm.dao.TestBidDao;
import cocoFarm.dao.TimerDao;
import cocoFarm.util.AuctionManager;


public class ContextStartListener implements ApplicationListener<ContextRefreshedEvent>{

	static boolean hasDone = false;
	@Autowired TestBidDao bidDao;//autowired 되어있기 때문에 서버가 종료되면(스프링 컨텍스트가 종료되면) 쓰레드 또한 문제가 생김(결과적으로는 같이 종료됨)
	@Autowired TimerDao timerDao;
	
	@Override
	public void onApplicationEvent(ContextRefreshedEvent event) {

		if(!hasDone) {// 왜인지 모르게 자꾸 두 번씩 실행되서 한번만 실행되게 만듦
			
			
			
			/*-------------------TestVersion

			new Thread(new Runnable() {
				
				@Override
				public void run() {
					
					TestBidDto bidDto = null;
					Timestamp wakeTime = null;
//					TestDto testDto = null;
//					Integer isDone =null;
					
					System.out.println("====================================================================");
					while (true) {
						
						bidDto = bidDao.getWakeTime();
						wakeTime =  bidDto==null ? null : bidDto.getWakeTime();
//						testDto = bidDao.auctionProc_1(testDto);
//						isDone = testDto==null? null: testDto.getIsDone();
						
						if(wakeTime !=null) {
							System.out.println("wakeTime: "+new SimpleDateFormat("YYYY/MM/dd HH:mm:ss.SSS").format(wakeTime));
							System.out.println("now: "+ LocalDateTime.now().format(DateTimeFormatter.ofPattern("YYY/MM/dd HH:mm:ss.SSS")));
							System.out.print("now-wakeTime: ");
							System.out.println( LocalDateTime.now().compareTo(wakeTime.toLocalDateTime()) >=0);
							System.out.println(ChronoUnit.MILLIS.between(LocalDateTime.now(), wakeTime.toLocalDateTime()));
							System.out.println(LocalDateTime.now().plusNanos( ChronoUnit.NANOS.between(LocalDateTime.now(), wakeTime.toLocalDateTime()) ));
							bidDao.auctionProc_1();
//							System.out.println(isDone);
						} else {
							System.out.println("no wake time found!");
						}
						System.out.println("====================================================================");
						
						try {
							Thread.sleep(5000L);
						} catch (InterruptedException e) {
							e.printStackTrace();
						}
						
					}//while true ends
				}//run() ends

			}).start();
			
			hasDone=true;
			
			System.out.println("\r\n\r\n-----------------    WebApplication Started!!!!      -----------------\r\n");
			
			*///-------------------------testVersion ends
			System.out.println("\r\n\r\n===========================contextStartListener Fired!!===========================\r\n");
			AuctionManager.init(timerDao);
			
			hasDone=true;
		}//if hasDone ends
		
		
	}//context started listener ends
	
	
	
	
}