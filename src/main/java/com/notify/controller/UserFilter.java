package com.notify.controller;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;

@Component
public class UserFilter implements Filter{
	private static final boolean debug = true;
    private FilterConfig filterConfig = null;
    
     public UserFilter() {
		// TODO Auto-generated constructor stub
	}
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		System.out.println("in filter");
		HttpServletRequest req = (HttpServletRequest) request;
		HttpSession session = req.getSession(false);
		Boolean byPassFilter = req.getServletPath().contains("signup")
				|| req.getServletPath().contains("saveUser") || req.getServletPath().contains("index")
				|| req.getServletPath().contains("login");
		System.out.println(byPassFilter);
		if (session != null && session.getAttribute("loginStatus") != null || byPassFilter) {
			chain.doFilter(request, response);
		} else {
			HttpServletResponse res = (HttpServletResponse) response;
			res.sendRedirect("index");
		}
	}
	@Override
	public void destroy() {
		
	}
}
