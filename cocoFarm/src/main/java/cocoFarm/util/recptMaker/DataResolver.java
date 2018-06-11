package cocoFarm.util.recptMaker;

import java.util.List;

public class DataResolver {
	
	// 커스텀 Exception 클래스를 만들 시간이 없어서 예외상황은 그냥 다 null 을 내보내고 처리를 맡김.
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
		if(serial.length() >2000) return null;
		
		return serial;
	}
}
