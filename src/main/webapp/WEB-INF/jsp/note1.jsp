<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>NotifyMe</title>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
  <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script>
  <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="Stylesheet"type="text/css"/>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
<script src="https://kit.fontawesome.com/9265f309f0.js" crossorigin="anonymous"></script>
<style type="text/css">

  body {
  font-family: "Lato", sans-serif;
}

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

.badge-danger {
    background-color: #db5565;
}

.dropdown-toggle::after {
    display: none;
}
#spinner3{
	display:none;
}
</style>
</head>
<body onload="notify();">
<div class="modal fade" id="addNotebook" tabindex="-1" role="dialog" aria-labelledby="addNotebooklabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="addNotebooklabel">Enter NoteBook</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
     
      <div class="modal-body">
        <label for="notename">Note Name :</label>
        <input type="text" class="form-control" id="notename" placeholder="Enter Note Name" value="" required><br>
        <label for="startdate">Start Date :</label>
        <input type="date" class="form-control"id="startdate" name="" value="" required>
        <label for="enddate">End date :</label>
        <input type="date" class="form-control"id="enddate" name="" value="" required>
        <label for="rdate">reminder date :</label>
        <input type="date" class="form-control"id="rdate" name="" value="" required>
        <label for="visible">visibility :</label>
         <select class="form-control" id="visible">
        <option>private</option>
        <option>public</option>
        </select>
        <label for="desc">Description :</label>
        <textarea class="form-control" id="desc" placeholder="Enter Note Description" required></textarea><br>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="submit" id="create-note" class="btn btn-success">create</button>
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
<div class="modal fade" id="editNote" tabindex="-1" role="dialog" aria-labelledby="editNotelabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="editNotelabel">Enter NoteBook</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      
      <div class="modal-body">
        <label for="notename">Note Name :</label>
        <input type="text" class="form-control" id="notename1" placeholder="Enter Note Name" value=""required><br>
        <label for="startdate">Start Date :</label>
        <input type="date" class="form-control"id="startdate1"name="" value=""required>
        <label for="enddate">End date :</label>
        <input type="date" class="form-control"id="enddate1"name="" value=""required>
        <label for="rdate">reminder date :</label>
        <input type="date" class="form-control"id="rdate1"name="" value=""required>
        <label for="visible">visibility :</label>
         <select class="form-control" id="visible1">
        <option>private</option>
        <option>public</option>
        </select>
        <label for="des">Description :</label>
        <textarea  class="form-control" id="desc1" placeholder="Enter Note Description" required></textarea><br>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="submit" class="btn btn-primary" id="edit">confirm</button>
      </div>
     
    </div>
  </div>
</div>

<div id="mySidebar" class="sidebar">
  <a href="javascript:void(0)" class="closebtn" onclick="closeNav()"><i class="fas fa-times fa-0.2x"></i></a>
    <a href="#">  <i class="fas fa-spinner" id="spinner"></i></a>
    <div id="data"></div>
  
</div>

<div id="main">
  <nav class="navbar navbar-expand-md navbar-dark bg-dark" >
    <span class="navbar-brand mb-0 h1">NotifyMe</span>
    
    <button type="button" class="navbar-toggler" data-toggle="collapse" data-target="#navbarCollapse">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarCollapse">
        <div class="navbar-nav">
            <a href="getNoteBooks?userId=${user.getId()}" class="nav-item nav-link ">NoteBooks</a>
            <a href="#" class="nav-item nav-link active">Notes</a>
            <a href="prof?userId=${user.getId() }" class="nav-item nav-link">Profile</a>

        </div>
        <div class="navbar-nav ml-auto">
          <a href="#addNotebook" data-toggle="modal" class=" nav-item nav-link newnote">+ New Note</a>
          <div class=" ">
          <a href="#" class="dropdown-toggle nav-item nav-link"  data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="far fa-bell"><span class="badge badge-danger">${count}</span></i></a>
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
<br>
<div class="container">
  <div class="row"><div class="col order-first">
      <h2>Hello ${user.userName }</h2>
    </div>
    <div class="col">
      <input type="text" class="form-control" id="inputPassword2" placeholder="Enter Note name">
    </div>
    <div class="col order-last">
      <button type="button" class="btn btn-dark searchN">search</button>
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
</div>
<div class="container" id="mainpage">
<c:forEach items= "${notes }" var="i">
<div class="card">
  <div class="card-body " >
    
    <div class="row" >
      <div class="col-auto mr-auto">
    <button class="btn dropdown-toggle btn-light" data-toggle="dropdown"><span>+</span> Description</button>
    <div class="dropdown-menu" >
      <a class="dropdown-item" href="#">${i.noteDescription }</a>
    </div>
    </div>
    <div class="col-auto mr-auto"><a href="showNote?noteId=${i.id }" style="text-decoration:none;">${ i.noteName}</a></div>
    
    <div class="col-auto"><span><a data-pid="${i.id }"  href="#" data-toggle="modal"class="" ><img src="https://img.icons8.com/material-sharp/24/000000/edit--v3.png"/></a></span></div>
    <div class="col-auto"><a data-id="${i.id }"href="#" data-toggle="modal" class=""><img src="https://img.icons8.com/material-sharp/24/000000/delete-forever.png"/></a></div>
   </div>
  </div>
</div>
</c:forEach>
</div>
</div>

<script>

function notify(){ 
	if(${count}==='0' || ${count}===0){
		$(".badge-danger").hide();
		}
}


var notelist = {
		<c:forEach items="${notes }" var="i">
		"${i.id}":{
			name: "${i.noteName}",
			desc:"${i.noteDescription}",
			startdate:"${i.startDate}",
			enddate:"${i.endDate}",
			rdate:"${i.remainderDate}",
			tag:"${i.tag}"
		},
		</c:forEach>
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
	$(".searchN").click(function(){
		$(".newnote").hide();
		$("#spinner3").show();
		$("#mainpage").hide();
		$.get("/searchN",{
			userId : ${user.id},
			text : $("#inputPassword2").val()
			},function(data,status){
					var li=data;
					console.log(li);
					var content="";
					if($("#inputPassword2").val()===""){
						$("#spinner3").hide();
						$("#mainpage").show();
						$(".newnote").show();
						$("#searchpage").empty();
					}
					else{
						if($("#inputPassword2").val()!=="" && li.length===0){
							$("#spinner3").hide();
							content="<div class='card'><div class='card-body '><div class='row' > <h3>no note found </h3></div></div></div><br>";
							$("#searchpage").html(content);
							
						}else{
							$.each(li,function(index,value){
								
									if(!notelist[value.id]){
										notelist[value.id]={
												name: value.noteName,
												desc: value.noteDescription,
												startdate: value.startDate,
												enddate: value.endDate,
												rdate: value.remainderDate,
												tag: value.tag
												}
										}
									console.log(value.id);
									content+="<div class='card'>"+
												"<div class='card-body ' >"+
													"<div class='row' >"+
														"<div class='col-auto mr-auto'>"+
															"<button class='btn dropdown-toggle btn-light' data-toggle='dropdown'>"+
																"<span>+</span> Description"+
															"</button>"+
															"<div class='dropdown-menu' >"+
																"<a class='dropdown-item' href='#'>"+value.noteDescription +"</a>"+
															"</div>"+
														"</div>"+
														"<div class='col-auto mr-auto'>"+
															"<a href='showNote?noteId="+ value.id +"' style='text-decoration:none;'>"+value.noteName+"</a>"+
														"</div><div class='col-auto'><span><a data-pid="+value.id+"  href='#' data-toggle='modal'  >"+
															"<img src='https://img.icons8.com/material-sharp/24/000000/edit--v3.png'/></a></span>"+
														"</div>"+
														"<div class='col-auto'><a data-id="+value.id+" href='#' data-toggle='modal' >"+
															"<img src='https://img.icons8.com/material-sharp/24/000000/delete-forever.png'/></a>"+
														"</div></div></div></div>";
								});
							$("#spinner3").hide();
							$("#searchpage").html(content);
							$("#searchpage").show();
						}		
					}
					
			});
	});
	
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
	$(".closebtn").click(function(){
		$(".openbtn").show();
	});
	$("#create-note").click(function(){
		$.post("/createNote",{
			noteName : $("#notename").val(),
			noteDescription : $("textarea#desc").val(),
			startDate : $("#startdate").val(),
			endDate : $("#enddate").val(),
			remainderDate : $("#rdate").val(),
			statusName : "started",
			tagName : $("#visible").find(":selected").text()
			},function(data,status){
					alert(status);
					window.location.reload();
				});
		});

	$(".far").click(function(){
		$.get("/getNotifications",{userId:${user.id}},function(data,status){
			console.log(data);
			var r= data;
			var content="";
			$.each(r,function(index,value){
				content+="<div style='padding-left:20px;padding-right:20px;'><a class='dropdown-item' href='showNote?noteId="+r[index].id+"'>"+r[index].noteName+"</a><p>start date :"+r[index].startDate+" end date :"+r[index].endDate+"</p><div class='dropdown-divider'></div></div>";
				});
			$("#spinner2").hide();
			$("#data2").html(content);
			$(".badge-danger").hide();
			
			
		});
		});
	
	let a ;
	$("body").delegate("[data-id]","click",function(){
			a= $(this).data("id");
			console.log(a+" in delete");
			$("#deleteNotebook").modal();
		});
	$("#delete").click(function(){
		$.post("/deleteNote",{
			noteId : a
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
		
		$("#notename1").attr("value",notelist[$(this).data("pid")].name);
		$("textarea#desc1").val(notelist[$(this).data("pid")].desc);
		
		$("#startdate1").val(notelist[$(this).data("pid")].startdate);
		$("#enddate1").val(notelist[$(this).data("pid")].enddate);
		$("#rdate1").val(notelist[$(this).data("pid")].rdate);
		
		$("#editNote").modal();
	});
	$("#edit").click(function(){
		$.post("/updateNote",{
			noteId: a,
			noteName : $("#notename1").val(),
			noteDescription : $("textarea#desc1").val(),
			startDate : $("#startdate1").val(),
			endDate : $("#enddate1").val(),
			remainderDate : $("#rdate1").val(),
			statusName : "started",
			tagName : $("#visible1").find(":selected").text()
			},function(data,status){
					alert(status);
					window.location.reload();
				});
		});
	
});
</script>
</body>
</html>