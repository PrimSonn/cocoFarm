package cocoFarm.util.recptMaker;

public interface SaleOptSerializer extends Serializer {
	
	public Integer getIdx();
	public Integer getProAmount();
	
	@Override
	default String doSerialize(){
		
		if(getIdx()==null||getProAmount()==null||getIdx()==0||getProAmount()==0) return null;
		
		String idxStr = getIdx().toString();
		String cntStr = getProAmount().toString();
		
		StringBuffer buffer = new StringBuffer();
		return buffer.append("01")
			.append(String.format("%02d", idxStr.length()))
			.append(idxStr)
			.append(String.format("%02d", cntStr.length()))
			.append(cntStr).toString();
//		return "01" + String.format("%02d", idxStr.length()) + idxStr + String.format("%02d", cntStr.length()) + cntStr;
	}

}
