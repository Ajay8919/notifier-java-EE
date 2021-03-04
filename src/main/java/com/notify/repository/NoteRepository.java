package com.notify.repository;

import java.util.ArrayList;

import org.springframework.data.repository.CrudRepository;

import com.notify.model.Note;
import com.notify.model.NoteBook;

public interface NoteRepository extends CrudRepository<Note, Integer>{
	public void deleteAllByNotebook(NoteBook notebook);
	public ArrayList<Note> findAllByNotebookId(int id);
}
