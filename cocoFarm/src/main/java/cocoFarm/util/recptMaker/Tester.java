package cocoFarm.util.recptMaker;

public class Tester implements SaleOptSerializer{
	
	int a =0;
	
	public Tester(int i) {
		a=i;
	}

	@Override
	public Integer getIdx() {
		return a;
	}

	@Override
	public Integer getProAmount() {
		return a*10;
	}

}
