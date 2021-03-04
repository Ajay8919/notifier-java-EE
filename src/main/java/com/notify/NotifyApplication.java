package com.notify;

import javax.servlet.Filter;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

import com.notify.controller.UserFilter;

@SpringBootApplication
@ComponentScan(basePackages={"com.notify, com.notify.controller"})
@Configuration
public class NotifyApplication {

	 @Bean
	    public FilterRegistrationBean dawsonApiFilter() {
	        FilterRegistrationBean registration = new FilterRegistrationBean();
	        registration.setFilter(new UserFilter());
	        registration.addUrlPatterns("/*");
	        return registration;
	    }
	public static void main(String[] args) {
		SpringApplication.run(NotifyApplication.class, args);
		
	}

}
