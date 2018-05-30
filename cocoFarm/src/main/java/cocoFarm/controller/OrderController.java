package cocoFarm.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import cocoFarm.dto.OrderCommand;
import cocoFarm.dto.OrderItem;

@Controller
@RequestMapping("/order/order.do")
public class OrderController {
	
   @RequestMapping(method = RequestMethod.GET)
   public String form() {
      return "orderForm";
   }

   @RequestMapping(method = RequestMethod.POST)
   public String submit(OrderCommand orderCommand) {
	  List<OrderItem> itemList = orderCommand.getOrderItems();
	  System.out.print("첫번째 itemId: " + itemList.get(0).getItemId());
	  System.out.println("  첫번째 number: " + itemList.get(0).getNumber());
	  System.out.print("두번째 itemId: " + itemList.get(1).getItemId());
	  System.out.println("  두번째 number: " + itemList.get(1).getNumber());
	  System.out.print("세번째 itemId: " + itemList.get(2).getItemId());
	  System.out.println("  세번째 number: " + itemList.get(2).getNumber());
      return "orderCompletion";
   }

}
