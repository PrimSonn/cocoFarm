package cocoFarm.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;


public class typeInterceptor extends HandlerInterceptorAdapter {
	private static final Logger logger = LoggerFactory.getLogger(typeInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
//		logger.info("+ + LOGININTERCEPTOR + +");
//		logger.info("Request URI : " + request.getRequestURI());
		
//		System.out.println("캐치함?");
		HttpSession session = request.getSession();
		System.out.println(session.getAttribute("type"));
		if(!session.getAttribute("type").equals(2)) {
			// 비로그인
			logger.info("올바르지 않은 접근입니다.");
//			response.setContentType("charset=utf-8");
			PrintWriter printwriter = response.getWriter();
			printwriter.print("<script>alert('Type Miss Match!!!');history.go(-1);</script>");
			printwriter.flush();
			printwriter.close();
//			response.sendRedirect("/main/cocomain.do");
			return false; // 컨트롤러 접근 금지
		}
		
		return super.preHandle(request, response, handler);
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {

//		logger.info("INTERCEPTOR END");
		
		super.postHandle(request, response, handler, modelAndView);
	}
	
}
