<%@page import="com.notify.model.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script type="text/javascript" src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
	<script src="https://kit.fontawesome.com/9265f309f0.js" crossorigin="anonymous"></script>

	<style type="text/css">
		body {
    background: white;
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

.form-control:focus {
    box-shadow: none;
    border-color: #BA68C8
}

.profile-button {
    background: #111;
    box-shadow: none;
    border: none
}

.profile-button:hover {
    background: #682773
}

.profile-button:focus {
    background: #682773;
    box-shadow: none
}

.profile-button:active {
    background: #682773;
    box-shadow: none
}

.back:hover {
    color: #682773;
    cursor: pointer
}
.dropdown-toggle::after {
    display: none;
}
	</style>
</head>
<body onload="notify();">
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
            <a href="listAllUserNote?userId=${user.getId()}" class="nav-item nav-link">Notes</a>
            <a href="#" class="nav-item nav-link active">Profile</a>

        </div>
        <div class="navbar-nav ml-auto">
          
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
<div class="modal fade" id="editprofile" tabindex="-1" role="dialog" aria-labelledby="editProfile" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="editProfile">Edit Profile</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <script>
      
      function notify(){
    		if(${count}==='0' || ${count}===0){
    			$(".badge-danger").hide();
    			}
    	}
      
		function val(){
			var a=document.getElementById("password1").value;
			var b=document.getElementById("password2").value;
			if(a!=b){
				document.getElementById("message").innerHTML="two fields of password must be same";
				return false;
				}
			else{
				document.getElementById("message").innerHTML="";
				$.post("/updateUser",{
					userId: ${user.getId()},
					userName : $("#username").val(),
					password : a,
					email  : $("#email").val(),
					mobileNumber : $("#mobile").val()
				},function(data,status){
					alert("updated "+ status);
					if(status=="success"){
							location.reload();
							$("#closeedit").click();
							
						}
					});
				return false;
			}
			
			
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
						content+="<div style='padding-left:20px;padding-right:20px;'><a class='dropdown-item' href='showNote?noteId="+r[index].id+"'>"+r[index].noteName+"</a><p>start date :"+r[index].startDate+" end date :"+r[index].endDate+"</p><div class='dropdown-divider'></div></div>";
						});
					$("#spinner2").hide();
					$("#data2").html(content);
					$(".badge-danger").hide();
					
				});
				});
			
			$(".closebtn").click(function(){
				$(".openbtn").fadeIn(500);
			});

			
		});
		
		
      </script>
      <div class="modal-body">
        <label for="notename">Enter Email :</label>
        <input type="email" class="form-control" id="email" name="email" value="${user.getEmail() }" placeholder="Enter email id" required><br>
        <label for="startdate">Enter Phone :</label>
        <input type="text" class="form-control"id="mobile"name="phone" value="${user.getMobileNumber() }" required>
        <label for="email">User name</label>
        <input type="text" class="form-control" id="username" name="username" value="${user.getUserName() }" required>
        <label for="password1">Password</label>
        <input type="password" class="form-control" id="password1" name="password" value="${user.getPassword() }">
        <label for="password2">confirm Password</label>
        <input type="password" class="form-control" id="password2" name="password" value="${user.getPassword()}">
        <span id="message" style="color:red;"></span>
      </div>
      <div class="modal-footer">
        <button type="button" id="closeedit"class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="submit" class="btn btn-success" onclick="return val()">save</button>
      </div>
    </div>
  </div>
</div>
<br>
<button class="openbtn" onclick="openNav()"><span><i class="fas fa-bars fa-0.5x"></i> reminders</span></button>
<div class="container rounded bg-white mt-5">
    <div class="row">
        <div class="col-md-4 border-right">
            <div class="d-flex flex-column align-items-center text-center p-3 py-5"><i class="fas fa-user-circle fa-9x"></i><span class="font-weight-bold">${user.getUserName() }</span><span class="text-black-50">${user.getEmail() }</span></div>
        </div>
        <div class="col-md-8">
            <div class="p-3 py-5">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <div class="d-flex flex-row align-items-center back"><i class="fa fa-long-arrow-left mr-1 mb-1"></i>
                        <a href="getNoteBooks?userId=${user.getId()}"><h6>Back to home</h6></a>
                    </div>
                    <h6 class="text-right">Edit Profile</h6>
                </div>
                <div class="row mt-2">
                    <div class="col-md-6"><input type="text" class="form-control" placeholder="first name" value="${user.getUserName() }" disabled="true"></div>
                    
                </div>
                <div class="row mt-3">
                    <div class="col-md-6"><input type="text" class="form-control" placeholder="Email" value="${user.getEmail() }" disabled="true"></div>
                    <div class="col-md-6"><input type="text" class="form-control" value="${user.getMobileNumber() }" placeholder="Phone number" disabled="true"></div>
                </div>
           
                <div class="mt-5 text-right"><a href="#editprofile" data-toggle="modal" class="btn btn-success">Edit Profile</a></div>
            </div>
        </div>
    </div>
</div>
</div>
<script>
function openNav() {
  document.getElementById("mySidebar").style.width = "250px";
  document.getElementById("main").style.marginLeft = "250px";
}

function closeNav() {
  document.getElementById("mySidebar").style.width = "0";
  document.getElementById("main").style.marginLeft= "0";
}
</script>
</body>
</html>