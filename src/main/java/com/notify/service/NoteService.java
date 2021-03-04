package com.notify.service;

import java.util.ArrayList;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.notify.model.Note;
import com.notify.repository.NoteRepository;

@Service
public class NoteService {
	@Autowired
	NoteRepository noteRepository;
	public Note getNote(int id) {
		Optional<Note> note=null;
		note=noteRepository.findById(id);
		return note.get();
	}
	public Note saveNote(Note obj) {
		return noteRepository.save(obj);
	}
	
	public void delete(Note obj) {
		noteRepository.delete(obj);
	}
	
	public ArrayList<Note> listAll(int notebookid){
		ArrayList<Note> arr=new ArrayList<>();
		arr=noteRepository.findAllByNotebookId(notebookid);
		return arr;
	}
}
