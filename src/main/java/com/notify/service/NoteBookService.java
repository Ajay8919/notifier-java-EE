package com.notify.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.notify.model.Note;
import com.notify.model.NoteBook;
import com.notify.repository.NoteBookRepository;
import com.notify.repository.NoteRepository;

@Service
public class NoteBookService {
	@Autowired
	NoteRepository noteRepository;
	
	@Autowired
	NoteBookRepository noteBookRepository;
	public NoteBook saveNoteBook(NoteBook noteBook) {
		NoteBook n=null;
		n=noteBookRepository.save(noteBook);
		return n;
	}
	
	public NoteBook editNoteBook(NoteBook noteBook) {
		NoteBook n=null;
		n=noteBookRepository.save(noteBook);
		return n;
	}
	
	public String deleteNoteBook(NoteBook noteBook) {
		ArrayList<Note> notes=new ArrayList<>();
		notes=noteRepository.findAllByNotebookId(noteBook.getId());
		for(Note i : notes) {
			noteRepository.delete(i);
		}
		System.out.println("in delete notebook " + noteBook.getId());
		
		noteBookRepository.delete(noteBook);
		return "deleted";
	}
	
	public Optional<NoteBook> getNoteBook(int id) {
		return noteBookRepository.findById(id);
	}
	public ArrayList<NoteBook> getAllNoteBooks(int id){
		return noteBookRepository.findAllByUserId(id);
	}
	
	public ArrayList<Note> getAllNoteByUserId(int id){
		ArrayList<Note> notelist=new ArrayList<>();
		ArrayList<NoteBook> notebooklist=new ArrayList<>();
		notebooklist=getAllNoteBooks(id);
		for(NoteBook i : notebooklist) {
			notelist.addAll(noteRepository.findAllByNotebookId(i.getId()));
		}
		return notelist;
	}
	
	public int getNotificationCount(int id) {
		ArrayList<Note> allnotes=getAllNoteByUserId(id);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date today=new Date();
		sdf.format(today);
		
		int count=0;
		for(Note note : allnotes) {
			if(note.getStatus().getStatusName().equalsIgnoreCase("started") && today.compareTo(note.getStartDate())>=0)
				count+=1;
		}
		return count;
	}
}
