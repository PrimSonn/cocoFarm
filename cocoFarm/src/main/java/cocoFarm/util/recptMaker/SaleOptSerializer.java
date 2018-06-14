package cocoFarm.util.recptMaker;

public interface SaleOptSerializer extends Serializer {
	
	public Integer getIdx();
	public Integer getProAmount();
	
	// 커스텀 Exception 클래스를 만들 시간이 없어서 예외상황은 그냥 다 null 을 내보내고 처리를 맡김.
	@Override
	default String doSerialize(){
		
		if(getIdx()==null||getProAmount()==null||getIdx()==0||getProAmount()==0) return null;
		
		String idxStr = getIdx().toString();
		String amtStr = getProAmount().toString();
		
		StringBuffer buffer = new StringBuffer();
		
		return buffer.append("01")
			.append(String.format("%02d", idxStr.length()))
			.append(idxStr)
			.append(String.format("%02d", amtStr.length()))
			.append(amtStr).toString();
//		return "01" + String.format("%02d", idxStr.length()) + idxStr + String.format("%02d", amtStr.length()) + amtStr;
	}

}
