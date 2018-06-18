package cocoFarm.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;


public class loginInterceptor extends HandlerInterceptorAdapter {
//	private static final Logger logger = LoggerFactory.getLogger(loginInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
//		logger.info("+ + LOGININTERCEPTOR + +");
//		logger.info("Request URI : " + request.getRequestURI());
		
		HttpSession session = request.getSession();
		if(session.getAttribute("idx") == null) {
			response.sendRedirect("/login/login.do");
			return false; // 컨트롤러 접근 금지
		}
		
		return super.preHandle(request, response, handler);
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {

		super.postHandle(request, response, handler, modelAndView);
	}
	
}
