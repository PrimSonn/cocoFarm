package cocoFarm.util.recptMaker;

import java.util.List;

public class DataResolver {
	
	// 커스텀 Exception 클래스를 만들 시간이 없어서 예외상황은 그냥 다 null 을 내보내고 처리를 맡김.
	public static String resolve(List<? extends Serializer> target) {
		
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
	
	public static String resolve(List<? extends Serializer> target1, List<? extends Serializer> target2) {
		
		String st = resolve(target1) + resolve(target2);
		
		if (st.length()>2000) {
			return null;
		}else {
			return resolve(target1) + resolve(target2);
		}
	}
	
	public static String resolve (String st, List<? extends Serializer> target1, List<? extends Serializer> target2) {
		
		st = st+resolve(target1, target2);
		
		if (st.length()>2000) {
			return null;
		}else {
			return st+resolve(target1, target2);
		}
	}
	
}
