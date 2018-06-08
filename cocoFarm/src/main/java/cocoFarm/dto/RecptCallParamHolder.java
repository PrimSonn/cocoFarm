package cocoFarm.dto;

public class RecptCallParamHolder {

	public Integer accIdx;
	public String arg;
	public Integer isDone;


	public RecptCallParamHolder() {
	}
	
	public RecptCallParamHolder(Integer accIdx, String arg, Integer isDone) {
		this.accIdx=accIdx;
		this.arg=arg;
		this.isDone=isDone;
	}
	
	public Integer getAccIdx() {
		return accIdx;
	}
	public void setAccIdx(Integer accIdx) {
		this.accIdx = accIdx;
	}
	public String getArg() {
		return arg;
	}
	public void setArg(String arg) {
		this.arg = arg;
	}
	public Integer getIsDone() {
		return isDone;
	}
	public void setIsDone(Integer isDone) {
		this.isDone = isDone;
	}
}
