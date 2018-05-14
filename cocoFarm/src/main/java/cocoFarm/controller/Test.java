package cocoFarm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class Test {

	@RequestMapping(value="/",method=RequestMethod.GET)
	public ModelAndView helloWorld(ModelAndView mv) {
		
		mv.setViewName("helloWorld");
		return mv;
	}
}
