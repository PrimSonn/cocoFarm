package cocoFarm.util.recptMaker;

public interface BidSerializer extends Serializer{
	
	public Integer getAuction_idx();
	public Integer getAmount();
	
	// 커스텀 Exception 클래스를 만들 시간이 없어서 예외상황은 그냥 다 null 을 내보내고 처리를 맡김.
	@Override
	default String doSerialize(){
		
		if(getAuction_idx()==null||getAmount()==null||getAmount()==0) return null;
		
		String auctStr = getAuction_idx().toString();
		String amountStr = getAmount().toString();
		
		StringBuffer buffer = new StringBuffer();
		return buffer.append("02")
			.append(String.format("%02d", auctStr.length()))
			.append(auctStr)
			.append(String.format("%02d", amountStr.length()))
			.append(amountStr).toString();
//		return "02" + String.format("%02d", auctStr.length()) + auctStr + String.format("%02d", amountStr.length()) + amountStr;
	}
}
