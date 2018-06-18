package cocoFarm.util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class TestRunner implements Runnable{

	@Override
	public void run() {
		
		int i =0;
//		System.out.println(new SimpleDateFormat("YYYY/MM/dd HH:mm:ss").format(new Date().getTime()));
		while (i<5) {
			try {
				wait(5000L);
//				System.out.println(new SimpleDateFormat("YYYY/MM/dd HH:mm:ss").format(new Date().getTime()));
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			i++;
		}
		
	}

}
