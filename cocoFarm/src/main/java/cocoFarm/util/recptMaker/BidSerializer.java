package cocoFarm.util.recptMaker;

public interface BidSerializer extends Serializer{
	
	public Integer getAuction_Idx();
	public Integer getAmount();
	
	@Override
	default String doSerialize(){
		
		if(getAuction_Idx()==null||getAmount()==null||getAuction_Idx()==0||getAmount()==0) return null;
		
		String auctStr = getAuction_Idx().toString();
		String amountStr = getAmount().toString();
		
		StringBuffer buffer = new StringBuffer();
		return buffer.append("02")
			.append(String.format("%02d", auctStr.length()))
			.append(auctStr)
			.append(String.format("%02d", amountStr.length()))
			.append(auctStr).toString();
//		return "02" + String.format("%02d", auctStr.length()) + auctStr + String.format("%02d", amountStr.length()) + amountStr;
		
	}
}
