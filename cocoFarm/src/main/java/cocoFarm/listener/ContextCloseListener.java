package cocoFarm.listener;

import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextClosedEvent;

import cocoFarm.util.AuctionManager;

public class ContextCloseListener implements ApplicationListener<ContextClosedEvent>{

	static boolean hasDone = false;

	@Override
	public void onApplicationEvent(ContextClosedEvent event) {
		if(!hasDone) {
			System.out.println("\r\n\r\n===================== application close listener fired =====================\r\n");
			AuctionManager.finish();
			hasDone = true;
		}
	}

}
