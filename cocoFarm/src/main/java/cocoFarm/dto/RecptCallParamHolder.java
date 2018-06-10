package cocoFarm.dto;

public class RecptCallParamHolder {

	public Integer accIdx;
	public String arg;
	public String arg2;
	public Integer intArg;
	public Integer intArg2;
	public Integer isDone;


	public RecptCallParamHolder() {
	}
	
	public RecptCallParamHolder(Integer accIdx, String arg, Integer isDone) {
		this.accIdx=accIdx;
		this.arg=arg;
		this.isDone=isDone;
	}
	
	public RecptCallParamHolder(Integer accIdx, String arg,String arg2, Integer isDone) {
		this.accIdx=accIdx;
		this.arg=arg;
		this.arg2=arg2;
		this.isDone=isDone;
	}
	
	public RecptCallParamHolder(Integer accIdx, Integer intArg, Integer intArg2, Integer isDone) {
		this.accIdx=accIdx;
		this.intArg=intArg;
		this.intArg2=intArg2;
		this.isDone=isDone;
	}
	
	public RecptCallParamHolder(Integer accIdx, String arg, Integer intArg, Integer isDone) {
		this.accIdx=accIdx;
		this.arg=arg;
		this.intArg=intArg;
		this.isDone=isDone;
	}
	
	public RecptCallParamHolder(String arg, Integer accIdx, String arg2, Integer intArg, Integer isDone) {
		this.arg=arg;
		this.accIdx=accIdx;
		this.arg2=arg2;
		this.intArg=intArg;
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
	public String getArg2() {
		return arg2;
	}
	public void setArg2(String arg2) {
		this.arg2 = arg2;
	}
	public Integer getIntArg() {
		return intArg;
	}
	public Integer getIntArg2() {
		return intArg2;
	}
	public void setIntArg(Integer intArg) {
		this.intArg = intArg;
	}
	public void setIntArg2(Integer intArg2) {
		this.intArg2 = intArg2;
	}
	public Integer getIsDone() {
		return isDone;
	}
	public void setIsDone(Integer isDone) {
		this.isDone = isDone;
	}
}
