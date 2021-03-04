<%@page import="java.util.ArrayList"%>
<%@page import="com.notify.model.NoteBook"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>NotifyMe</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
  <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
<script src="https://kit.fontawesome.com/9265f309f0.js" crossorigin="anonymous"></script>
<style type="text/css">
	
	.sidebar {
  height: 100%;
  width: 0;
  position: fixed;
  z-index: 1;
  top: 0;
  left: 0;
  background-color: #111;
  overflow-x: hidden;
  transition: 0.5s;
  padding-top: 60px;
}

.sidebar a {
  padding: 8px 8px 8px 32px;
  text-decoration: none;
  font-size: 25px;
  color: #818181;
  display: block;
  transition: 0.3s;
}

.sidebar a:hover {
  color: #f1f1f1;
}

.sidebar .closebtn {
  position: absolute;
  top: 0;
  right: 25px;
  font-size: 36px;
  margin-left: 50px;
}

.openbtn {
  font-size: 20px;
  cursor: pointer;
  background-color: #111;
  color: white;
  padding: 10px 15px;
  border: none;
}

.openbtn:hover {
  background-color: #444;
}

#main {
  transition: margin-left .5s;
  padding: 16px;
}

/* On smaller screens, where height is less than 450px, change the style of the sidenav (less padding and a smaller font size) */
@media screen and (max-height: 450px) {
  .sidebar {padding-top: 15px;}
  .sidebar a {font-size: 18px;}
}
	
	#username{
		top:200px;
	}
	.badge{
    padding: 3px 2px;
    top: 100px;
    right: 80px;
    display: inline-block;
    min-width: 10px;
    font-size: 12px;
    font-weight: bold;
    color: #ffffff;
    line-height: 1;
    vertical-align: baseline;
    white-space: nowrap;
    border-radius: 10px;
}
.rightcard{
	margin-left: 320px;
}
.badge-danger {
    background-color: #db5565;
}
.reminder{
	float: left;
	height: 700px;
	width: 200px;
	margin-left: 5px;
	margin-top: 5px;
	margin-right: 5px;
	border-radius: 5px;
}
.dropdown-toggle::after {
    display: none;
}

#searchpage{
display:none;
}
a{
text-decoration: none; 
}
</style>

</head>
<body onload="notify();">

<script>
$(document).ready(function(){
$(".searchnb").click(function(){
	$("#mainpage").hide();
	$.get("/searchNB",{
		userId:${user.id},
		text:$("#inputPassword2").val()
		},function(data,status){
			console.log(data);
			var l=data;
			var content="";
			$.each(l,function(index,value){
					content+="<div class='card'><div class='card-body '><div class='row' >";
					content+="<div class='col-auto mr-auto'><a class='btn btn-light' href='listOfNotes?noteBookId="+l[index].id+"'>"+l[index].noteBookName+"</a></div>";
					content+="<div class='col-auto'><span><a data-pid='"+(l[index].id)+"' href='#' data-toggle='modal' class='edit-note2' ><img src='https://img.icons8.com/material-sharp/24/000000/edit--v3.png' /></a></span></div>";
					content+=" <div class='col-auto'><a data-id='"+l[index].id+"' href='#' data-toggle='modal' class='deletenote2'><img src='https://img.icons8.com/material-sharp/24/000000/delete-forever.png' /></a></div>";
					content+="</div></div></div><br>";
				});
			
			console.log(content);
			

			if($("#inputPassword2").val()!=="" && l.length===0){
				content="<div class='card'><div class='card-body '><div class='row' > <h3>no note book found </h3></div></div></div><br>";
				
				}
			else if($("#inputPassword2").val()===""){
				$("#searchpage").empty();
				$("#mainpage").show();
				}
			$("#spinner3").hide();
			$("#searchpage").html(content);
			
			$("#searchpage").show();
			
			});
});
});
</script>

<%
response.setHeader("Pragma", "no-cache");
response.setHeader("Cache-Control", "no-store");
response.setHeader("Expires", "0");
response.setDateHeader("Expires", -1);
%>
<% ArrayList<NoteBook> list2; %>
<div id="mySidebar" class="sidebar">
  <a href="javascript:void(0)" class="closebtn" onclick="closeNav()"><i class="fas fa-times fa-0.2x"></i></a>
    <a><i class="fas fa-spinner" id="spinner"></i></a>
    <div id="data"></div>
  
</div>

<div id="main">
<nav class="navbar navbar-expand-md navbar-dark bg-dark">
    <span class="navbar-brand mb-0 h1">NotifyMe</span>
    <button type="button" class="navbar-toggler" data-toggle="collapse" data-target="#navbarCollapse">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarCollapse">
        <div class="navbar-nav">
            <a href="#" class="nav-item nav-link active">NoteBooks</a>
             <a href="listAllUserNote?userId=${user.getId()}" class="nav-item nav-link">Notes</a>
            <a href="prof?userId=${user.getId() }" class="nav-item nav-link">Profile</a>

        </div>
        <div class="navbar-nav ml-auto">
          <a href="#addNotebook" data-toggle="modal" class=" nav-item nav-link ">+ New Note Book</a>
          <div class=" ">
          <a href="#" class="dropdown-toggle nav-item nav-link"  data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="far fa-bell"><span class="badge badge-danger">${count }</span></i></a>
          <div class="dropdown-menu dropdown-menu-right" id="data2" align="center">
          <i class="fas fa-spinner dropdown-item" id="spinner2"></i>
  			</div>
          </div>
            <a href="logout" class=" nav-item nav-link ">Logout</a>
        </div>
    </div>
</nav>
<br>
<button class="openbtn" onclick="openNav()"><i class="fas fa-bars fa-0.5x"></i> reminders</button>  
<br>
<div class="container rightcard" id="username">
	<div class="row"><div class="col order-first">
      <h2>Hello ${user.getUserName()}</h2>
      
    </div>
    <div class="col">
      <input type="text" class="form-control" id="inputPassword2" placeholder="Enter NoteBook name">
    </div>
    <div class="col order-last">
      <button type="button" class="btn btn-dark searchnb">search</button>
    </div>
</div>
</div>	
<br>
<br>

<div class="container" id="searchpage">
	<div class="card" align="center"id="spinner3">
	<div class="col-auto">
	<i class="fas fa-spinner" ></i>
	</div>
	</div>
<div id="searchdata"></div>
</div>

<div class="container" id="mainpage">
<c:forEach items= "${list }" var="i">
<div class="card">
  <div class="card-body ">
  	<div class="row" >
    <div class="col-auto mr-auto"><a class="btn btn-light" href="listOfNotes?noteBookId=${i.getId() }"><c:out value="${ i.getNoteBookName()}"/></a></div>
    <div class="col-auto"><span><a data-pid="${i.getId() }" href="#" data-toggle="modal"class="edit-note " ><img src="https://img.icons8.com/material-sharp/24/000000/edit--v3.png"/></a></span></div>
    <div class="col-auto"><a data-id="${i.getId() }" href="#" data-toggle="modal" class="deletenote"><img src="https://img.icons8.com/material-sharp/24/000000/delete-forever.png"/></a></div>
   </div>
  </div>
</div><br>
</c:forEach>
</div>
</div>




<div class="modal fade" id="addNotebook" tabindex="-1" role="dialog" aria-labelledby="addNotebooklabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="addNotebooklabel">Enter NoteBook name</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      
      <div class="modal-body">
        <input type="text" class="form-control" id="createNote" value="" placeholder="Enter NoteBook name" required>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="submit" class="btn btn-success" id="create-note-btn">create</button>
      </div>
    </div>
  </div>
</div>
<div class="modal fade" id="deleteNotebook" tabindex="-1" role="dialog" aria-labelledby="deleteNotebooklabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="deleteNotebooklabel">Are you sure.. ?</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
       you will lose all your notes.. !
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-danger" id="delete">delete</button>
      </div>
    </div>
  </div>
</div>
<div class="modal fade" id="editNotebook" tabindex="-1" role="dialog" aria-labelledby="editNotebooklabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="editNotebooklabel">Enter NoteBook name</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <input type="text" class="form-control" id="notebookname" value="" placeholder="Enter NoteBook name">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" id="edit">Edit</button>
      </div>
    </div>
  </div>
</div>

<br>
<br>
<script>
function notify(){
	if(${count}==='0' || ${count}===0){
		$(".badge-danger").hide();
		}
}


function openNav() {
  document.getElementById("mySidebar").style.width = "250px";
  document.getElementById("main").style.marginLeft = "250px";
}

function closeNav() {
  document.getElementById("mySidebar").style.width = "0";
  document.getElementById("main").style.marginLeft= "0";
}
$(document).ready(function(){
	$(".openbtn").click(function(){
		$(".openbtn").hide();

		$.get("/getReminders",{userId:${user.id}},function(data,status){
				console.log(data);
				var r=data;
				var content="";
				$.each(r,function(index,value){
					content+="<a href='showNote?noteId="+r[index].id+"'>"+r[index].noteName+"</a><div style='color:gray;'>Description :"+r[index].noteDescription+"<br> from :"+r[index].startDate+" to :"+r[index].endDate+"</div>";
					});
				
				$("#spinner").hide();
				$("#data").html(content);
				if(r.length===0){
					$("#data").html("<a href='#'>no reminders today</a>");
				}
				
			});
		
		
	});
	$(".far").click(function(){
		$.get("/getNotifications",{userId:${user.id}},function(data,status){
			console.log(data);
			var r=data;
			var content="";
			$.each(r,function(index,value){
				content+="<div style='padding-left:20px;padding-right:20px;'><a class='dropdown-item' href='showNote?noteId="+r[index].id+"'>"+r[index].noteName+"</a><p>from :"+r[index].startDate+" to :"+r[index].endDate+"</p><div class='dropdown-divider'></div></div>";
				});
			$("#spinner2").hide();
			$("#data2").html(content);
			$(".badge-danger").hide();
			
		});
		});


	$(".closebtn").click(function(){
		$(".openbtn").show();
	});
	$("#create-note-btn").click(function(){
		$.post("/saveNoteBook",{
			noteBookName : $("#createNote").val()
			},function(data,status){
					alert(status);
					if(status==="success"){
						window.location.reload();
					}else{
							
						}
				});
	});
	var a;

	$("body").delegate("[data-id]","click",function(){
		a = $(this).data("id");
		console.log(a+" in edit");
		$("#deleteNotebook").modal();
		});
$("#delete").click(function(){
	$.post("/deleteNoteBook",{
		bookid : a
		
		},function(data,status){
		alert(status);
		if(status==="success"){
			window.location.reload();	
		}else{
				
			}
	});
	});
$("body").delegate("[data-pid]","click",function(){
	 a = $(this).data("pid");
	console.log(a+" in edit");
	$("#editNotebook").modal();
});


$("#edit").click(function(){
$.post("/updateNoteBook",{
	noteBookName : $("#notebookname").val(),
	id : a,
	email:"${user.getEmail()}"
	},function(data,status){
	alert(status);
	window.location.reload();
	});
});


});
</script>
</body>
</html>