package cocoFarm.util.recptMaker;

public interface SaleOptSerializer extends Serializer {
	
	public Integer getIdx();
	public Integer getProAmount();
	
	@Override
	default String doSerialize(){
		
		if(getIdx()==null||getProAmount()==null) {
			return null;
		}
		
		String idxStr = getIdx().toString();
		String cntStr = getProAmount().toString();
		
		return "01" + String.format("%02d", idxStr.length()) + idxStr + String.format("%02d", cntStr.length()) + cntStr;
	}

}
