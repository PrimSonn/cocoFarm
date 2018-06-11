package cocoFarm.util.recptMaker;

import java.util.List;

public class DataResolver {

	public static String resolve(List<? extends Serializer> target) {
		
//		String serial ="";
//		for(int i=0; i<target.size();i++) {
//			String temp =target.get(i).doSerialize();
//			if(temp==null) {
//				return null;
//			}
//			serial += temp;
//			System.out.println("serial: "+ serial);//-----------testCode
//		}
		
		String serial = null;
		if( target.stream().allMatch(t -> t.doSerialize()!=null) ) {
			serial = target.stream()
				.filter( t -> t!=null)
				.map(t -> t.doSerialize())
				.collect(StringBuilder::new, StringBuilder::append, StringBuilder::append)
				.toString();
		}
		
		return serial;
	}
}
