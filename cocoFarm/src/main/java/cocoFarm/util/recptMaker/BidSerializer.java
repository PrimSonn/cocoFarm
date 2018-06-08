package cocoFarm.util.recptMaker;

public interface BidSerializer extends Serializer{
	
	public Integer getAuction_Idx();
	public Integer getAmount();
	
	@Override
	default String doSerialize(){
		
		if(getAuction_Idx()==null||getAmount()==null) {
			return null;
		}
		
		String actStr = getAuction_Idx().toString();
		String amtStr = getAmount().toString();
	
		return "02" + String.format("%02d", actStr.length()) + actStr + String.format("%02d", amtStr.length()) + amtStr;
		
	}
}
