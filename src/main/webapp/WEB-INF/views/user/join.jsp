<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AdminLTE 2 | Log in</title>
<meta
	content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no'
	name='viewport'>
<!-- Bootstrap 3.3.4 -->
<link href="/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet"
	type="text/css" />
<!-- Font Awesome Icons -->
<link
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css"
	rel="stylesheet" type="text/css" />
<!-- Theme style -->
<link href="/resources/dist/css/AdminLTE.min.css" rel="stylesheet"
	type="text/css" />
<!-- iCheck -->
<link href="/resources/plugins/iCheck/square/blue.css" rel="stylesheet"
	type="text/css" />

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body class="login-page">
	<div class="login-box">
		<div class="login-logo">
			<a href="/resources/index2.html"><b>Spring</b>Project</a>
		</div>
		<!-- /.login-logo -->
		<div class="login-box-body">
			<p class="login-box-msg">Sign in to start your session</p>
			<c:if test='${ msg != null }'>
				<p>${ msg }</p>
			</c:if>
			
			<!-- <form id="loginForm" action="join.sinc" method="post" enctype="multipart/form-data"> -->
			<form id="loginForm" action="join.sinc" method="post">
				<div class="form-group has-feedback">
					<input type="text" id="id" name="id" class="form-control"
						placeholder="USER ID" /> <span
						class="glyphicon glyphicon-envelope form-control-feedback"></span>
				</div>
				<div class="form-group has-feedback">
					<input type="password" id="pwd" name="pwd" class="form-control"
						placeholder="Password" /> <span
						class="glyphicon glyphicon-lock form-control-feedback"></span>
				</div>
				<div class="form-group has-feedback">
					<input type="password" id="pwd2" class="form-control"
						placeholder="Password" /> <span
						class="glyphicon glyphicon-lock form-control-feedback"></span>
				</div>
				<div class="form-group has-feedback">
					<input type="text" name="name" class="form-control"
						placeholder="Name" /> 
					<span class="glyphicon glyphicon-user form-control-feedback"></span>
				</div>
				
				<!-- <div class="form-group has-feedback">
					<input type="file" name="file" class="form-control" /> 
					<span class="glyphicon glyphicon-picture form-control-feedback"></span>
				</div> -->
				<div class="row">
			    <div class="col-xs-12">
			      <button id="submitBtn" type="button" class="btn btn-primary btn-block">Sign In</button>
			    </div><!-- /.col -->
			  </div>
			</form>
			
		</div>
		<!-- /.login-box-body -->
	</div>
	<!-- /.login-box -->

	<!-- jQuery 2.1.4 -->
	<script src="/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
	<!-- Bootstrap 3.3.2 JS -->
	<script src="/resources/bootstrap/js/bootstrap.min.js"
		type="text/javascript"></script>
	<!-- iCheck -->
	<script src="/resources/plugins/iCheck/icheck.min.js"
		type="text/javascript"></script>
	<script>
	
	
      $(function () {
    	  
    	$('#submitBtn').click(function(){
    		
    		id = $("#id");
    		id.val(id.val().replace(/\s/g,''));
    		console.log(id);
    		
    		let pwd = $('#pwd').val();
    		let pwd2 = $('#pwd2').val();
    		if(pwd != pwd2) {
    			alert("비밀번호를 확인하세요;");
    		} else {
    			$('#loginForm').submit();	
    		}
    		
    		
    	});
    	  
        $('input').iCheck({
          checkboxClass: 'icheckbox_square-blue',
          radioClass: 'iradio_square-blue',
          increaseArea: '20%' // optional
        });
      });
    </script>
</body>
</html>