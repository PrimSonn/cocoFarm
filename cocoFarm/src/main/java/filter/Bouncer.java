package filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

public class Bouncer implements Filter{

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)  throws IOException, ServletException {
		
		HttpServletRequest request = (HttpServletRequest)req;
		
		int parser = request.getContextPath().length();
		System.out.println( request.getRequestURI().toString().substring(parser,parser+5) );
		if(request.getRequestURI().toString().substring(parser,parser+5).matches("/Sign")) {
			System.out.println("match!");
		} else {
			
		}
//		System.out.println("contextPath: "+request.getContextPath());
//		String path = request.getRequestURI().toString().substring(30);
//		System.out.println(path);
		
//		request.setAttribute("", "");
		chain.doFilter(req, res);
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub
		
	}

}
