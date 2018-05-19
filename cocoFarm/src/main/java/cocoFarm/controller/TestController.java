package cocoFarm.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import cocoFarm.dto.TestDto;

@Controller
public class TestController {

	@RequestMapping(value="/",method=RequestMethod.GET)
	public ModelAndView helloWorld(ModelAndView mv) {
		
		mv.setViewName("helloWorld");
		return mv;
	}
	
	
	@RequestMapping (value="test1",method=RequestMethod.POST)
	public ModelAndView test1(ModelAndView mv, TestDto tester) {
		
		if(tester==null) {
			System.out.println(tester==null);
		}else {
			System.out.println(tester.getAttr());
		}
		
		mv.setViewName("helloWorld");
		return mv;
	}
	
	@RequestMapping (value="test2",method=RequestMethod.POST)
	public ModelAndView test2(ModelAndView mv, List<TestDto> testerList) {
		
		if(testerList==null) {
			System.out.println(testerList==null);
		}else {
			for(TestDto tester: testerList) {
				System.out.println(tester.getAttr());
			}
		}
		
		mv.setViewName("helloWorld");
		return mv;
	}
	
	@RequestMapping(value="test3",method=RequestMethod.POST)
	public ModelAndView test3(ModelAndView mv, HttpServletRequest request) {
		
		String attr[] = request.getParameterValues("attr");
		
		if (attr !=null) {
			
			System.out.println("attr: "+attr);
			
			TestDto[] dtoList = new TestDto[attr.length];
			System.out.println("attr length: "+ attr.length);
			
			for(int i=0; i<attr.length; i++) {
				dtoList[i] = new TestDto();
				dtoList[i].setAttr(attr[i]);
			}
			System.out.println("===========================");
			
			int i=0;
			for(TestDto oneDto:dtoList) {
				i++;
				System.out.println(i+"th dto attr: "+oneDto.getAttr());
			}
			
		}else {
			System.out.println("attr[] is null!");
		}
		
		mv.setViewName("helloWorld");
		return mv;
	}
	
	@RequestMapping (value="test4",method=RequestMethod.POST)
	public ModelAndView test4(ModelAndView mv, TestDto[] testerArr) {
		
		if(testerArr==null) {
			System.out.println(testerArr==null);
		}else {
			System.out.println(testerArr.length);
			int i=0;
			for(TestDto dto: testerArr) {
				
				System.out.println(++i + "th dto attr: "+ dto.getAttr());
			}
		}
		
		mv.setViewName("helloWorld");
		return mv;
	}
	
	@RequestMapping	(value="test1",method=RequestMethod.GET)
	public ModelAndView testGet1(ModelAndView mv) {
		mv.setViewName("redirect:/");
		return mv;
	}
	@RequestMapping	(value="test2",method=RequestMethod.GET)
	public ModelAndView testGet2(ModelAndView mv) {
		mv.setViewName("redirect:/");
		return mv;
	}@RequestMapping(value="test3",method=RequestMethod.GET)
	public ModelAndView testGet3(ModelAndView mv, HttpServletRequest request) {
		mv.setViewName("redirect:/");
		return mv;
	}@RequestMapping(value="test4",method=RequestMethod.GET)
	public ModelAndView testGet4(ModelAndView mv, HttpServletRequest request) {
		mv.setViewName("redirect:/");
		return mv;
	}
}
