package com.notify.repository;

import java.util.ArrayList;

import org.springframework.data.repository.CrudRepository;

import com.notify.model.NoteBook;

public interface NoteBookRepository extends CrudRepository<NoteBook, Integer>{

	ArrayList<NoteBook> findAllByUserId(int id);

}
