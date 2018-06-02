package cocoFarm.dto;

import java.sql.Timestamp;

public class TimerDto {
	
	private Timestamp dbTime;
	private Timestamp nextCheck;
	
	public Timestamp getDbTime() {
		return dbTime;
	}public Timestamp getNextCheck() {
		return nextCheck;
	}public void setDbTime(Timestamp dbTime) {
		this.dbTime = dbTime;
	}public void setNextCheck(Timestamp nextCheck) {
		this.nextCheck = nextCheck;
	}
}
