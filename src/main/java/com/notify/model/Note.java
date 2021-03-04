package com.notify.model;
import javax.persistence.CascadeType;
import javax.persistence.Column;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import java.io.Serializable;
import java.sql.Date;
import java.text.*;


import org.hibernate.annotations.ForeignKey;
import org.springframework.beans.factory.annotation.Autowired;
@SuppressWarnings("serial")
@Entity
@Table(name = "note")
public class Note implements Serializable {
    @Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private Integer id; 
	@Column(name = "notename")
	  private String noteName;
	@Column(name = "notedescription")
	  private String noteDescription;
	@Column(name="startdate")
	private Date startDate;
	@Column(name="enddate")
	private Date endDate;
	@Column(name="remainderdate")
	private Date remainderDate;
	
	@OneToOne(cascade = CascadeType.ALL)
	@ForeignKey(name="status")
	private Status status;
	
	@OneToOne(cascade = CascadeType.ALL)
	@ForeignKey(name="tag")
	private Tag tag;
	
	@ManyToOne
	@ForeignKey(name="notebook")
	@Autowired
	  private NoteBook notebook;
	
	public Note(){
		
	}
	
	public Note(Integer id, String noteName, String noteDescription, Date startDate, Date endDate, Date remainderDate,
			Status status, Tag tag, NoteBook noteBook) {
		this.id = id;
		this.noteName = noteName;
		this.noteDescription = noteDescription;
		this.startDate = startDate;
		this.endDate = endDate;
		this.remainderDate = remainderDate;
		this.status = status;
		this.tag = tag;
		this.notebook = noteBook;
	}
	public Note (String noteName, String noteDescription,Date startDate2,Date endDate2, Date remainderDate2,
			Status status, Tag tag, NoteBook noteBook) {
		this.noteName = noteName;
		this.noteDescription =noteDescription;
		this.startDate =startDate2;
		this.endDate = endDate2;
		this.remainderDate = remainderDate2;
		this.status = status;
		this.tag = tag;
		this.notebook = noteBook;
	}


	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getNoteName() {
		return noteName;
	}

	public void setNoteName(String noteName) {
		this.noteName = noteName;
	}

	public String getNoteDescription() {
		return noteDescription;
	}

	public void setNoteDescription(String noteDescription) {
		this.noteDescription = noteDescription;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public Date getRemainderDate() {
		return remainderDate;
	}

	public void setRemainderDate(Date remainderDate) {
		this.remainderDate = remainderDate;
	}

	public Status getStatus() {
		return status;
	}

	public void setStatus(Status status) {
		this.status = status;
	}

	public Tag getTag() {
		return tag;
	}

	public void setTag(Tag tag) {
		this.tag = tag;
	}

	public NoteBook getNoteBook() {
		return notebook;
	}

	public void setNoteBook(NoteBook noteBook) {
		this.notebook = noteBook;
	}	
	
}
