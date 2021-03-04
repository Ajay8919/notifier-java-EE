package com.notify.controller;

import java.util.ArrayList;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.notify.model.Note;
import com.notify.model.NoteBook;
import com.notify.model.User;
import com.notify.service.NoteBookService;
import com.notify.service.NoteService;
import com.notify.service.UserService;

@RestController
@SessionAttributes("user")
public class NotifyController {

	@Autowired
	UserService userService;
	@Autowired
	NoteBookService noteBookService;
	
	
	@RequestMapping("/index")
	public ModelAndView hello() {
		return new ModelAndView("index");
	}
	@RequestMapping("signup")
	public ModelAndView signUp() {
		return new ModelAndView("signup");
	}
	
	@PostMapping("/saveNoteBook")
	public ModelAndView saveNoteBook(@RequestParam("noteBookName") String noteBookName, @ModelAttribute User user) {
		System.out.println(user.getId()+"user id in note book");
		NoteBook notebook = new NoteBook(noteBookName, user);
		noteBookService.saveNoteBook(notebook);
		System.out.println(user.getId());
		return new ModelAndView("redirect:getNoteBooks?userId="+user.getId(), "user", user);
	}
	
	@RequestMapping(value="/searchNB",method = RequestMethod.GET)
	public ArrayList<NoteBook> searchNoteBook(@RequestParam String userId,@RequestParam String text){
		text=text.trim().toLowerCase();
		ArrayList<NoteBook> arr=null;
		arr=noteBookService.getAllNoteBooks(Integer.parseInt(userId));
		ArrayList<NoteBook> result=new ArrayList<>();
		for(NoteBook nb : arr) {
			if(nb.getNoteBookName().equalsIgnoreCase(text) || nb.getNoteBookName().toLowerCase().contains(text))
				result.add(nb);
		}
		if(text=="")
			return new ArrayList<>();
		return result;
	}
	@RequestMapping("/getNoteBooks")
	public ModelAndView getUserNoteBooks(@RequestParam("userId") int id) {
		
		int count=0;
		count=noteBookService.getNotificationCount(id);
		
		ArrayList<NoteBook> list=new ArrayList<NoteBook>();
		list=noteBookService.getAllNoteBooks(id);
		Optional<User> user=userService.getUserById(id);
		ModelAndView mv=new ModelAndView();
		mv.addObject("user", user.get());
		mv.addObject("list", list);
		mv.addObject("count",count);
		mv.setViewName("notebook");
		return mv;
	}
	@RequestMapping(value="/updateNoteBook", method = RequestMethod.POST )
	public ModelAndView updateNoteBook(@RequestParam("noteBookName") String name, @RequestParam("id") String id,@RequestParam("email") String email) {
		User user=new User();
		user=userService.getUserByMail(email);
		NoteBook n=new NoteBook();
		n.setId(Integer.parseInt(id));
		n.setNoteBookName(name);
		n.setUser(user);
		noteBookService.saveNoteBook(n);
		return new ModelAndView("redirect:getNoteBooks?userId="+user.getId());
	}
	@RequestMapping(value="/deleteNoteBook", method = RequestMethod.POST)
	public ModelAndView deleteNoteBook(@RequestParam("bookid") String bookid, @ModelAttribute User user) {
		Optional<NoteBook> n=noteBookService.getNoteBook(Integer.parseInt(bookid));
		
		noteBookService.deleteNoteBook(n.get());
		System.out.println(user.getId()+" "+user.getUserName());
		
		return new ModelAndView("redirect:getNoteBooks?userId="+user.getId(),"user", user);
	}
}
