package cocoFarm.listener;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;

import cocoFarm.dao.TimerDao;
import cocoFarm.util.runners.RunnerManager;


public class ContextStartListener implements ApplicationListener<ContextRefreshedEvent>{

	@Autowired TimerDao timerDao;
	static boolean hasDone = false;
	
	@Override
	public void onApplicationEvent(ContextRefreshedEvent event) {

		if(!hasDone) {// 왜인지 모르게 자꾸 두 번씩 실행되서 한번만 실행되게 만듦
			
			RunnerManager.init(timerDao);
			hasDone=true;
		}//if hasDone ends
		
	}//context started listener ends
	
}