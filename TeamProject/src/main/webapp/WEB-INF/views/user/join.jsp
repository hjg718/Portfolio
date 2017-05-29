<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>회원가입하기</title>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<c:url var="url" value="/resources/jquery.bootpag.min.js" />
<script src="${url }"></script>
<link href="<c:url value='/resources/assets/css/bootstrap.css'/>" rel="stylesheet" />
<link href="<c:url value='/resources/assets/css/bootstrap-theme.css'/>" rel="stylesheet" />
<link href="<c:url value='/resources/assets/css/style.css'/>" rel="stylesheet" />
<link rel="stylesheet" href="<c:url value='/resources/assets/color/default.css'/>">
<script src="<c:url value='/resources/assets/js/bootstrap.js'/>"></script>
<script>
function check() {
	var ch = /.{2,}/;
	 var pass = ch.test($("input[name=keyword]").val());
	if(!pass){
		$('#input').modal('show');
	}
	return pass;
}
function idCheck(){
	var re_id = /^[a-zA-Z0-9]{5,16}$/; 
	$('#iddiv').removeClass("has-error");
	if($("#id").val()==""){
		$("#userFormBody").text("[ID 입력 오류] 아이디를 입력해주세요.");
		$('#userForm').modal('show');
		$('#iddiv').addClass("has-error");
		return;
	}
	else if(re_id.test($("#id").val()) != true){
		$("#userFormBody").text("[ID 입력 오류] 유효한 ID를 입력해 주세요.");
		$('#userForm').modal('show');
		$('#iddiv').addClass("has-error");
		uid.focus();
		return;
	}
	var param={};
	param.id= $("#id").val();
	param.${_csrf.parameterName}= '${_csrf.token }';
	$.ajax({
		url : "check",
		method : "post",
		data : param,
		dataType : "json",
		success : function(res){
			if(res.ok){
				$("#userFormBody").text("해당 아이디로 가입가능!");
				$('#userForm').modal('show');
			}
			else{
				$("#userFormBody").text("이미 사용중인 아이디입니다.");
				$('#userForm').modal('show');
				$('#iddiv').addClass("has-error");
			}
		},
		error : function(x,s,e){
			alert("오류!");
		}
		
	});
}
function re() {
	
	var re_id = /^[a-zA-Z0-9]{5,16}$/; 
	var re_pwd = /^[a-zA-Z0-9]{6,18}$/; 
	var re_mail = /^([\w\.-]+)@([a-z\d\.-]+)\.([a-z\.]{2,6})$/; 
	var re_tel = /^[0-9]{8,11}$/; 
	
	var
	uid = $('#id'), 
	upw = $('#pwd'),
	name = $("#name"),
	phone = $("#phone"),
	email = $('#email'),
	gender1 = $("#male"),
	gender2 = $("#female");
	
	$('#iddiv').removeClass("has-error");
	$('#pwddiv').removeClass("has-error");
	$('#namediv').removeClass("has-error");
	$('#phonediv').removeClass("has-error");
	$('#emaildiv').removeClass("has-error");
	$('#genderdiv').removeClass("has-error");
	
	if (re_id.test(uid.val()) != true) { 
		$("#userFormBody").text("[ID 입력 오류] 유효한 ID를 입력해 주세요.");
		$('#userForm').modal('show');
		$('#iddiv').addClass("has-error");
		return false;
	} else if(re_pwd.test(upw.val()) != true) { 
		$("#userFormBody").text("[Password 입력 오류] 유효한 Password를 입력해 주세요.");
		$('#userForm').modal('show');
		$('#pwddiv').addClass("has-error");
		return false;
	}else if(name.val()==""){
		$("#userFormBody").text("[이름 입력 오류] 이름을 입력해 주세요.");
		$('#userForm').modal('show');
		$('#namediv').addClass("has-error");
		return false;
	}else if(re_tel.test(phone.val()) != true) { // 전화번호 검사
		$("#userFormBody").text("[전화번호 입력 오류] 유효한 전화번호를 입력해 주세요.");
		$('#userForm').modal('show');
		$('#phonediv').addClass("has-error");
		return false;
	}else if(re_mail.test(email.val()) != true) { // 이메일 검사
		$("#userFormBody").text("[이메일 입력 오류] 유효한 이메일을 입력해 주세요.");
		$('#userForm').modal('show');
		$('#emaildiv').addClass("has-error");
		return false;
	}else if(!gender1[0].checked&&!gender2[0].checked){
		$("#userFormBody").text("[성별 입력 오류] 성별을 선택 해 주세요.");
		$('#userForm').modal('show');
		$('#genderdiv').addClass("has-error");
		return false;
	}
	return true;
}
function logout() {
	$("#logout").submit();
}
$(function() {
	var re_id = /^[a-zA-Z0-9]{5,16}$/; 
	var re_pwd = /^[a-zA-Z0-9]{6,18}$/; 
	$('#id').keyup( function() {
		if ($('#id').val().length == 0) {
			$("#idLength").text(''); 
		} 
		else if (!re_id.test($('#id').val())) { 
			$("#idLength").css("color","red");
			$("#idLength").text('영문, 숫자로 구성 된 5~16 문자를입력해주세요.'); 
			$('#iddiv').addClass("has-error");
		} 
		else if(re_id.test($('#id').val())) { 
			$("#idLength").css("color","green");
			$("#idLength").text('적당합니다.'); 
			$('#iddiv').removeClass("has-error");
		}
	});
	
	$('#pwd').keyup( function() {
		if ($('#pwd').val().length == 0) {
			$("#pwdLength").text(''); 
		} 
		else if (!re_pwd.test($('#pwd').val())) { 
			$("#pwdLength").css("color","red");
			$("#pwdLength").text('영문, 숫자으로 구성 된  6~18 문자를 입력해주세요.');
			$('#pwddiv').addClass("has-error");
		} 
		else if(re_pwd.test($('#pwd').val())) { 
			$("#pwdLength").css("color","green");
			$("#pwdLength").text('적당합니다.'); 
			$('#pwddiv').removeClass("has-error");
		}
	});
});
</script>
<style>
.red{
color: red;
}
</style>
</head>
<body>

	<header>
		<div id="navigation"class="navbar navbar-inverse navbar-fixed-top default"role="navigation">
			<div class="container">
				<!-- Brand and toggle get grouped for better mobile display -->
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse"
						data-target="#bs-example-navbar-collapse-1">
						<span class="icon-bar"></span> 
						<span class="icon-bar"></span> 
						<span class="icon-bar"></span>
					</button>
					<a class="navbar-brand" href="<c:url value="/"/>">RD Library</a>
				</div>
				<div>
					<div class="collapse navbar-collapse"
						id="bs-example-navbar-collapse-1">
						<nav>
						<ul class="nav navbar-nav navbar-left">
						<sec:authorize access="hasAuthority('ADMIN')">
						<li><a href="<c:url value="/book/add"/>">도서등록</a></li>
						</sec:authorize>
						</ul>
						<ul class="nav navbar-nav navbar-right" id="mynav">
						<sec:authorize access="hasAuthority('ADMIN')">
						<sec:authentication var="id" property="name" />
						<li><a href="javascript:logout();">로그아웃</a></li>
						<li><a href="<c:url value="/user/info"/>">내 서재 가기</a></li>
						</sec:authorize>
						<li><a href="<c:url value="/qna/list"/>">Q&amp;A게시판</a></li>
						<li><a href="<c:url value="/board/list"/>">자유게시판</a></li>
						</ul>
							<form action="<c:url value="/book/search"/>" method="post" onsubmit="return check();"
							class="navbar-form navbar-right" id="searchForm">
								<input type="hidden" name="${_csrf.parameterName }"
									value="${_csrf.token }"> 
									<select name="category" class="form-control input-lg">
									<option value="bname">제목</option>
									<option value="author">저자</option>
									<option value="publisher">출판사</option>
								</select> 
								<input type="text" name="keyword" id="key" class="form-control input-lg" placeholder="도서정보를 입력해주세요">
								<button type="submit" class="btn btn-theme" >검색</button>
							</form>
							
						</nav>
					</div>
				</div>
			</div>
		</div>
	</header>
<section id="join" class="section gray">
<div class="container">
<div class="row">
<div class="col-md-8 col-md-offset-2">
<div class="heading">
<h3>개인 정보 입력</h3>
</div>
<P></P>
<div id="inputCon">
<form:form action="join" commandName="userVo" method="post" class="form-horizontal" onsubmit="return re();">
 
<div class="form-group" id="iddiv">
    <label for="id" class="col-sm-2 control-label">ID</label>
    <div class="col-sm-10">
    <form:input path="userid" class="form-control" id="id" placeholder="영문, 숫자로 구성 된 5~16 문자를 입력해주세요." />
      <div class="help-block">
      <button type="button" class="btn btn-theme" onclick="idCheck();">중복검사</button>
      <c:if test="${overlap }"><span class="red">중복된아이디입니다.</span></c:if><br>
      <span id="idLength"></span> <form:errors path="userid" cssClass="red"/>
      </div>
    </div>
  </div>
  
<div class="form-group" id="pwddiv">
    <label for="Password" class="col-sm-2 control-label">Password</label>
    <div class="col-sm-10">
    <form:password path="upwd" class="form-control" id="pwd" placeholder="영문, 숫자으로 구성 된  6~18 문자를 입력해주세요." />
    <span class="help-block">
    <span id="pwdLength"></span>
    <form:errors path="upwd" cssClass="red"/>
    </span>
    </div>
  </div>
  
<div class="form-group" id="namediv">
    <label for="name" class="col-sm-2 control-label">이름</label>
    <div class="col-sm-10">
    <form:input path="uname" class="form-control" id="name" />
    </div>
  </div>
  
  <div class="form-group" id="phonediv">
    <label for="phone" class="col-sm-2 control-label">전화번호</label>
    <div class="col-sm-10">
    <form:input path="phone" class="form-control" id="phone" placeholder="\"-\"없이 입력해주세요." />
    <span class="help-block">
    "-"없이 입력해주세요.<br>
    </span>
    </div>
  </div>

     <div class="form-group" id="emaildiv">
    <label for="email" class="col-sm-2 control-label">이메일</label>
    <div class="col-sm-10">
    <form:input path="uemail" class="form-control" id="email"/>
    </div>
  </div>
  
   <div class="form-group" id="genderdiv">
    <label class="col-sm-2 control-label">성별</label>
    <div class="col-sm-10">
         
        <label class="radio-inline">
 			<form:radiobutton path="gender"  id="male" value="m"/> 남성
		</label>
		
		<label class="radio-inline">
 			 <form:radiobutton path="gender"  id="female" value="f"/> 여성
		</label>
    </div>
  </div>
 <sec:authorize access="hasAuthority('ADMIN')">
<input type="hidden" name="authority" value="MANAGER">
</sec:authorize>
<div id="bset">
 <button type="submit" class="btn btn-theme">작성 완료</button>
 <button type="reset" class="btn btn-theme">다시 작성</button>
</div>
</form:form>
</div>
</div>
</div>
</div>
</section>
<!--로그아웃  -->
<form action="<c:url value="/logout"/>" method="post" id="logout">
<input type="hidden" name="${_csrf.parameterName }"	value="${_csrf.token }">
</form>
	
<!--검색어 모달  -->
<div class="modal fade" id="input" tabindex="-1"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body">
					2자 이상 입력해주세요.
				</div>
				<div class="modal-footer">
					<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					확인
				</button>
				</div>
			</div>
		</div>
	</div>
	
<!--로그인  -->
	<div class="modal fade" id="myModal" tabindex="-1"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">로그인</h4>
				</div>
				<form  action='<c:url value="/user/login"/>' class="form-horizontal" method="post" id="loginForm"> 
		     	<div class="modal-body">
				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
				<div class="form-group">
			    <label for="id" class="col-sm-2 control-label">ID</label>
			    <div class="col-sm-10">
			    <input type="text" class="form-control" name="id" id="id">
			    </div>
			    </div>
			    
			    <div class="form-group">
			    <label for="pwd" class="col-sm-2 control-label">Password</label>
			    <div class="col-sm-10">
			    <input type="password" class="form-control" name="pwd" id="pwd">
			    </div>
			    </div>
		        </div>
		        <div class="modal-footer">
		     	<button type="submit"  class="btn btn-success">로그인</button>
		        <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
		        </div>
				</form>
			</div>
		</div>
	</div>
	
<!--입력폼 모달  -->
<div class="modal fade" id="userForm" tabindex="-1"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body" id="userFormBody">
				</div>
				<div class="modal-footer">
					<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					확인
				</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>