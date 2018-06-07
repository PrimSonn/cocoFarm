package cocoFarm.util.recptMaker;

import java.util.List;

public class DataResolver {

	public static String resolve(List<Serializer> target) {
		
		String serial ="";
		for(int i=0; i<target.size();i++) {
			String temp =target.get(i).doSerialize();
			if(temp==null) {
				return null;
			}
			serial += temp;
			System.out.println("serial: "+ serial);//-----------testCode
		}
		
		return serial;
	}
}
