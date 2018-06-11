package cocoFarm.dto;

import java.util.List;

import cocoFarm.util.recptMaker.SaleOptSerializer;

public class OptReceiptMkr {

	public Integer accIdx;
	public String paid_name;
	public List<SaleOptSerializer> optList;
	public String mainRcpt;
	public Integer isDone;
	
	public OptReceiptMkr() {}
	
	public OptReceiptMkr(Integer accIdx, String paid_name, List<SaleOptSerializer> optList) {
		this.accIdx = accIdx;
		this.paid_name = paid_name;
		this.optList = (List<SaleOptSerializer>) optList;
		this.isDone = 0;
	}
	
	@Override
	public String toString() {
		String it = "accIdx: "+accIdx+", paid_name: "+paid_name+", mainRcpt: "+mainRcpt+", isDone: "+isDone;
		it += ", list [";
		for(SaleOptSerializer o : optList) {
			it+= "o.Idx: " +o.getIdx() +", amount: " +o.getProAmount()+" || ";
		}
		it +="]";
		return it;
	}
	
	public Integer getAccIdx() {
		return accIdx;
	}
	public void setAccIdx(Integer accIdx) {
		this.accIdx = accIdx;
	}
	public List<SaleOptSerializer> getOptList() {
		return optList;
	}
	public void setOptList(List<SaleOptSerializer> optList) {
		this.optList = optList;
	}
	public Integer getIsDone() {
		return isDone;
	}
	public void setIsDone(Integer isDone) {
		this.isDone = isDone;
	}
	public String getPaid_name() {
		return paid_name;
	}
	public void setPaid_name(String paid_name) {
		this.paid_name = paid_name;
	}public String getMainRcpt() {
		return mainRcpt;
	}public void setMainRcpt(String mainRcpt) {
		this.mainRcpt = mainRcpt;
	}
}
