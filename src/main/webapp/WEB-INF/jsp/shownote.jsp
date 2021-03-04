<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
<title>NotifyMe</title>
</head>
<body>
<div class="container rounded bg-white mt-5">
    <div class="row">
        
        <div class="col-md-8">
            <div class="p-3 py-5">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <div class="d-flex flex-row align-items-center back"><i class="fa fa-long-arrow-left mr-1 mb-1"></i>
                        <h3>Note Information</h3>
                    </div>
                    
                </div>
                <div class="row mt-2">
                    <div class="col-md-6"><input style="font-weight:bold;" type="text" class="form-control" placeholder="note description" value="Note Name" disabled="true"></div>
                    <div class="col-md-6"><input type="text" class="form-control" value="${note.noteName }" disabled="true"></div>
                </div>
                <div class="row mt-3">
                    <div class="col-md-6"><input style="font-weight:bold;" type="text" class="form-control" placeholder="note description" value="Note Description" disabled="true"></div>
                    <div class="col-md-6"><input type="text" class="form-control" value="${note.noteDescription }" placeholder="" disabled="true"></div>
                </div>
                <div class="row mt-3">
                    <div class="col-md-6"><input style="font-weight:bold;" type="text" class="form-control" placeholder="address" value="Start Date" disabled="true"></div>
                    <div class="col-md-6"><input type="text" class="form-control" value="${note.startDate }" placeholder="" disabled="true"></div>
                </div>
                <div class="row mt-3">
                    <div class="col-md-6"><input style="font-weight:bold;" type="text" class="form-control" placeholder="Bank Name" value="Reminder Date" disabled="true"></div>
                    <div class="col-md-6"><input type="text" class="form-control" value="${note.remainderDate }" placeholder="" disabled="true"></div>
                </div>
                <div class="row mt-3">
                    <div class="col-md-6"><input style="font-weight:bold;" type="text" class="form-control" placeholder="Bank Name" value="End Date" disabled="true"></div>
                    <div class="col-md-6"><input type="text" class="form-control" value="${note.endDate }" placeholder="" disabled="true"></div>
                </div>
                <div class="row mt-3">
                    <div class="col-md-6"><input style="font-weight:bold;" type="text" class="form-control" placeholder="Bank Name" value="visibility" disabled="true"></div>
                    <div class="col-md-6"><input type="text" class="form-control" value="${note.getTag().tagName }" placeholder="" disabled="true"></div>
                </div>
                <br><br>
                <a href="getNoteBooks?userId=${user.getId()}" style="text-decoration:none;"><h6>Back to home</h6></a>
            </div>
        </div>
    </div>
</div>
</body>
</html>