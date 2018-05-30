package cocoFarm.dto;

public class OrderItem {
	private Integer itemId;
    private Integer number;
    private String remark;

    public Integer getItemId() {
          return itemId;
    }
    public void setItemId(Integer itemId) {
          this.itemId = itemId;
    }
    public Integer getNumber() {
          return number;
    }
    public void setNumber(Integer number) {
          this.number = number;
    }
    public String getRemark() {
          return remark;
    }
    public void setRemark(String remark) {
          this.remark = remark;
    }
}
