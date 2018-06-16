package cocoFarm.listener;

import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextClosedEvent;

import cocoFarm.util.runners.RunnerManager;


public class ContextCloseListener implements ApplicationListener<ContextClosedEvent>{

	static boolean hasDone = false;

	@Override
	public void onApplicationEvent(ContextClosedEvent event) {
		if(!hasDone) {
			RunnerManager.finish();
			hasDone = true;
		}
	}

}
