package com.notify.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;


import com.notify.model.Note;
import com.notify.model.NoteBook;
import com.notify.model.Status;
import com.notify.model.Tag;
import com.notify.model.User;
import com.notify.service.NoteBookService;
import com.notify.service.NoteService;




@RestController
@SessionAttributes("user")
public class NoteController {
	@Autowired
	NoteBookService noteBookService;
	@Autowired
	NoteService noteService;
	
	@RequestMapping(value = "/showNote",method = RequestMethod.GET)
	public ModelAndView showNote(@RequestParam String noteId,HttpServletRequest request) {
		ModelAndView mv=new ModelAndView();
		HttpSession session=request.getSession();
		User user=(User)session.getAttribute("user");
		mv.addObject("user", user);
		Note note=new Note();
		note=noteService.getNote(Integer.parseInt(noteId));
		mv.addObject("note", note);
		mv.setViewName("shownote");
		return mv;
	}
	
	@RequestMapping(value="/getNotifications",method = RequestMethod.GET)
	public ArrayList<Note> getNotifications(@RequestParam String userId) throws ParseException{
		
		
		ArrayList<Note> notelist=null;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		notelist=noteBookService.getAllNoteByUserId(Integer.parseInt(userId));
		ArrayList<Note> notifications=new ArrayList<>(); 
		for(Note note : notelist) {
			Date d=new Date();
			d=sdf.parse(sdf.format(d));
			Date noteDate=note.getStartDate();
			if(d.compareTo(noteDate)>=0) {
				notifications.add(note);
				if(note.getStatus().getStatusName().equals("started")) {
				note.setStatus(new Status("completed"));			
				noteService.saveNote(note);}
			}
			
		}
		Collections.reverse(notifications);
		return notifications;
	}
	
	@RequestMapping(value = "/getReminders",method = RequestMethod.GET)
	public ArrayList<Note> getTodayReminders(@RequestParam String userId ) throws ParseException{
		ArrayList<Note> notelist=null;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		notelist=noteBookService.getAllNoteByUserId(Integer.parseInt(userId));
		ArrayList<Note> notifications=new ArrayList<>(); 
		for(Note note : notelist) {
			Date d=new Date();
			d=sdf.parse(sdf.format(d));
			Date noteDate=note.getRemainderDate();
			if(d.compareTo(noteDate)==0) {
				notifications.add(note);
			}
		}
		Collections.reverse(notifications);
		return notifications;
	}
	
	@RequestMapping(value = "/searchN",method = RequestMethod.GET)
	public ArrayList<Note> searchNote(@RequestParam String userId,@RequestParam String text){
		text=text.trim().toLowerCase();
		ArrayList<Note> arr=null;
		ArrayList<Note> result=new ArrayList<>();
		arr=noteBookService.getAllNoteByUserId(Integer.parseInt(userId));
		for(Note note : arr) {
			if(text.equals(note.getNoteName())  || note.getNoteName().toLowerCase().contains(text))
				result.add(note);
		}
		return result;
	}
	
	@RequestMapping(value="/listAllUserNote",method=RequestMethod.GET)
	public ModelAndView getAllNoteByUserId(@RequestParam("userId") String userId,HttpServletRequest request) {
		
		int count=0;
		count=noteBookService.getNotificationCount(Integer.parseInt(userId));
		
		ArrayList<Note> notelist=null;
		notelist=noteBookService.getAllNoteByUserId(Integer.parseInt(userId));
		ModelAndView mv=new ModelAndView();
		HttpSession session=request.getSession();
		User user=(User) session.getAttribute("user");
		mv.addObject("notes",notelist);
		mv.addObject("count", count);
		mv.setViewName("notes");
		mv.addObject("user", user);
		return mv;
	}
	@RequestMapping(value="/createNote" ,method=RequestMethod.POST)
	public ModelAndView createNote(@RequestParam("noteName") String noteName,
			@RequestParam("noteDescription") String noteDescription, @RequestParam("startDate") String startDate,
			@RequestParam("endDate") String endDate, @RequestParam("remainderDate") String remainderDate,
			@RequestParam("statusName") String statusName, @RequestParam("tagName") String tagName ,HttpServletRequest request ) throws ParseException {
			ModelAndView mv=new ModelAndView();
			NoteBook nb=new NoteBook();
			HttpSession session=request.getSession();
			nb= (NoteBook)session.getAttribute("notebook");
			session.removeAttribute("notebook");
			Status status = new Status(statusName);
			Tag tag = new Tag(tagName);
			NoteBook noteBook = new NoteBook();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			java.util.Date start_Date = sdf.parse(startDate);
			java.sql.Date start_date = new java.sql.Date(start_Date.getTime());

			java.util.Date end_Date = sdf.parse(endDate);
			java.sql.Date end_date = new java.sql.Date(end_Date.getTime());

			java.util.Date remainder_Date = sdf.parse(remainderDate);
			java.sql.Date remainder_date = new java.sql.Date(remainder_Date.getTime());
			Note note = new Note(noteName, noteDescription, start_date, end_date, remainder_date, status, tag, nb);
			noteService.saveNote(note);
			System.out.println("noteBookId="+nb.getId());
			mv.setViewName("redirect:listOfNotes?noteBookId="+nb.getId());
			return mv;
	}
	@RequestMapping(value="/updateNote" ,method=RequestMethod.POST)
	public ModelAndView updateNote(@RequestParam("noteId") String noteId,@RequestParam("noteName") String noteName,
			@RequestParam("noteDescription") String noteDescription, @RequestParam("startDate") String startDate,
			@RequestParam("endDate") String endDate, @RequestParam("remainderDate") String remainderDate,
			@RequestParam("statusName") String statusName, @RequestParam("tagName") String tagName ,HttpServletRequest request ) throws ParseException {
			ModelAndView mv=new ModelAndView();
			NoteBook nb=new NoteBook();
			HttpSession session=request.getSession();
			
			nb= (NoteBook)session.getAttribute("notebook");
			Status status = new Status(statusName);
			Tag tag = new Tag(tagName);
			NoteBook noteBook = new NoteBook();
			
			Note tnote=new Note();
			tnote=noteService.getNote(Integer.parseInt(noteId));
			noteBook=tnote.getNoteBook();
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			java.util.Date start_Date = sdf.parse(startDate);
			java.sql.Date start_date = new java.sql.Date(start_Date.getTime());

			java.util.Date end_Date = sdf.parse(endDate);
			java.sql.Date end_date = new java.sql.Date(end_Date.getTime());

			java.util.Date remainder_Date = sdf.parse(remainderDate);
			java.sql.Date remainder_date = new java.sql.Date(remainder_Date.getTime());
			Note note = new Note(Integer.parseInt(noteId),noteName, noteDescription, start_date, end_date, remainder_date, status, tag, noteBook);
			noteService.delete(note);
			noteService.saveNote(note);
			mv.setViewName("redirect:listOfNotes?noteBookId="+noteBook.getId());
			return mv;
	}
	@RequestMapping(value="/deleteNote",method=RequestMethod.POST)
	public ModelAndView deleteNoteById(@RequestParam("noteId") String noteId) {
		Note note=null;
		note = noteService.getNote(Integer.parseInt(noteId));
		noteService.delete(note);
		NoteBook noteBook2=null;
		noteBook2=note.getNoteBook();
		return new ModelAndView("redirect:listOfNotes?noteBookId="+noteBook2.getId());
	}
	@RequestMapping(value="/listOfNotes")
	public ModelAndView getNotes(@RequestParam("noteBookId") String noteBookId,HttpServletRequest request ) {
		ModelAndView mv=new ModelAndView();
		HttpSession session=request.getSession();
		Optional<NoteBook> nb=null;
		nb=noteBookService.getNoteBook(Integer.parseInt(noteBookId));
		User user=(User) session.getAttribute("user");
		int count=0;
		count=noteBookService.getNotificationCount(user.getId());
		System.out.println(user.getId());
		ArrayList<Note> note=new ArrayList<>();
		note=noteService.listAll(nb.get().getId());
		if(note.size()!=0)
		System.out.println("note book name "+ note.get(0).getNoteName());
		mv.addObject("notebook",nb.get());
		mv.addObject("notes",note);
		mv.addObject("count", count);
		session.setAttribute("notebook", nb.get());
		mv.setViewName("note1");
		return mv;
	}
	
}
