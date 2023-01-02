package com.group.sharegram.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.group.sharegram.user.domain.EmployeesDTO;

@Component
public class adminControllInterceptor implements HandlerInterceptor {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		EmployeesDTO emp = (EmployeesDTO) request.getSession().getAttribute("loginEmp");

		
		if(emp == null) {
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('해당 기능은 관리자만 사용할 수 있습니다.');");
			out.println("location.href='" + request.getContextPath() + "';");
			out.println("</script>");
			out.close();
			
			return false; 
			
		} else {
			if((emp.getDeptNo()==10 && emp.getJobNo() == 2) || emp.getJobNo() == 1) {
				return true; 
				
			} else{
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				
				out.println("<script>");
				out.println("alert('해당 기능은 관리자만 사용할 수 있습니다.');");
				out.println("location.href='" + request.getContextPath() + "';");
				out.println("</script>");
				out.close();
				
				return false; 
				
			}
			
		}

	}
	
}