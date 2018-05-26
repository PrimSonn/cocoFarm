package cocoFarm.listener;

import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;

public class ContextStartListener implements ApplicationListener<ContextRefreshedEvent>{

	@Override
	public void onApplicationEvent(ContextRefreshedEvent event) {
		System.out.println("-----------------    WebApplication Started!!!!      -----------------");
		System.out.println("ID: "+event.getApplicationContext().getId());
		System.out.println("-----------------    WebApplication Started!!!!      -----------------");
	}
}