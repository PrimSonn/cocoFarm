package cocoFarm.listener;


import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;

import cocoFarm.dao.TimerDao;
import cocoFarm.util.recptMaker.DataResolver;
import cocoFarm.util.recptMaker.Serializer;
import cocoFarm.util.recptMaker.Tester;
import cocoFarm.util.runners.RunnerManager;


public class ContextStartListener implements ApplicationListener<ContextRefreshedEvent>{

	@Autowired TimerDao timerDao;
	static boolean hasDone = false;
	
	@Override
	public void onApplicationEvent(ContextRefreshedEvent event) {

		if(!hasDone) {// 왜인지 모르게 자꾸 두 번씩 실행되서 한번만 실행되게 만듦
			
			System.out.println("\r\n\r\n===========================contextStartListener Fired!!===========================\r\n");
			RunnerManager.init(timerDao);
			hasDone=true;
			
			/*//------------------------------------- Serializer Test ---------------------------
			
			List<Serializer> target = new ArrayList<Serializer>();
			target.add(new Tester(123));
			target.add(new Tester(234));
			target.add(new Tester(345));
			target.add(new Tester(456));
			
			System.out.println("======================================================");
			System.out.println("serialized : "+ DataResolver.resolve(target) );
			
			//----------------------------------------------------------------------------------*/
			
			
		}//if hasDone ends
		
	}//context started listener ends
	
}