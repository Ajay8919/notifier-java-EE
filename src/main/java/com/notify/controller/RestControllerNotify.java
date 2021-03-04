package com.notify.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import com.notify.model.User;
import com.notify.service.NoteBookService;
import com.notify.service.UserService;

@Controller
@SessionAttributes("user")
public class RestControllerNotify {
	
	@Autowired
	NoteBookService noteBookService;
	@Autowired
	UserService userService;
	@PostMapping("/saveUser")
	public ModelAndView createUser(@RequestParam("userName") String name, @RequestParam("password") String password,
			@RequestParam("email") String email, @RequestParam("mobileNumber") String mobileNumber) {
		User user = new User(name, password, email, mobileNumber);
		User userObj=userService.getUserByMail(email);
		if(userObj!=null) {
			return new ModelAndView("index", "error", "Email Id is already existed!!");
		}
		else {
		userService.saveUser(user);
		}
		return new ModelAndView("index");
	}
	@PostMapping("/updateUser")
	public ModelAndView updateUser(@RequestParam("userId") String id,@RequestParam("userName") String name, @RequestParam("password") String password,
			@RequestParam("email") String email, @RequestParam("mobileNumber") String mobileNumber, HttpServletRequest request) {
		User user1=null;
		user1=userService.getUserById(Integer.parseInt(id)).get();
		User user = new User(Integer.parseInt(id),name, password, email, mobileNumber);
		if(user1!=null) {
		
		userService.saveUser(user);
		HttpSession session=request.getSession();
		session.removeAttribute("user");
		session.setAttribute("user", user);
		}
		return new ModelAndView("redirect:prof?userId="+user.getId());
	}
	@PostMapping("/login")
	public ModelAndView loginSuccess(@RequestParam("email") String email, @RequestParam("password") String password,
			ModelMap modelMap, Model model, HttpServletRequest request) {
		User user = userService.getUserByMail(email);
		if (user == null) {
			return new ModelAndView("index", "error", "UserName or Password may be wrong!!");
		} else {
			HttpSession session = request.getSession();
			session.setAttribute("loginStatus", "true");
			modelMap.put("user", user);
			model.addAttribute("user", user);
			return new ModelAndView("redirect:getNoteBooks?userId="+user.getId(), "user", user);
		}
	}
	@RequestMapping("/logout")
	public String invalid(@ModelAttribute User user, HttpSession session, SessionStatus status) {
		
		session.invalidate();
		return "index";

	}
	@RequestMapping("/prof")
	public ModelAndView viewProfile(@RequestParam("userId") int id,HttpServletRequest request) {
		int count=0;
		count=noteBookService.getNotificationCount(id);
		ModelAndView mv=new ModelAndView();
		User user=new User();
		user=userService.getUserById(id).get();
		HttpSession session=request.getSession();
		session.removeAttribute("user");
		session.setAttribute("user", user);
		User user1=(User) session.getAttribute("user");
		System.out.println(user1.getMobileNumber());
		mv.addObject("user",user);
		mv.addObject("count", count);
		mv.setViewName("profile");
		return mv;
	}
}
