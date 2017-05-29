<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>개인 정보 수정</title>
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
function re() {
	var re_pwd = /^[a-zA-Z0-9]{6,18}$/; 
	var re_mail = /^([\w\.-]+)@([a-z\d\.-]+)\.([a-z\.]{2,6})$/; 
	var re_tel = /^[0-9]{8,11}$/; 
	
	var
	newPwd = $("#newPwd"),
	name = $("#name"),
	phone = $("#phone"),
	email = $('#email'),
	gender1 = $("#male"),
	gender2 = $("#female");
	
	$('#pwdDiv').removeClass("has-error");
	$('#nameDiv').removeClass("has-error");
	$('#phoneDiv').removeClass("has-error");
	$('#emailDiv').removeClass("has-error");
	$('#genderDiv').removeClass("has-error");
	if($("#newPwd").val()!=""){
		if(re_pwd.test(newPwd.val())!=true){
			$("#userFormBody").text("[Password 입력 오류] 변경할  Password를 양식에 맞게 입력해 주세요.");
			$('#userForm').modal('show');
			$('#pwdDiv').addClass("has-error");
			return false;
		}
	}
	if(name.val()==""){
		$("#userFormBody").text("[이름 입력 오류] 이름을 입력해 주세요.");
		$('#userForm').modal('show');
		$('#nameDiv').addClass("has-error");
		return false;
	}else if(re_tel.test(phone.val()) != true) { // 전화번호 검사
		$("#userFormBody").text("[전화번호 입력 오류] 유효한 전화번호를 입력해 주세요.");
		$('#userForm').modal('show');
		$('#phoneDiv').addClass("has-error");
		return false;
	}else if(re_mail.test(email.val()) != true) { // 이메일 검사
		$("#userFormBody").text("[이메일 입력 오류] 유효한 이메일을 입력해 주세요.");
		$('#userForm').modal('show');
		$('#emailDiv').addClass("has-error");
		return false;
	}else if(!gender1[0].checked&&!gender2[0].checked){
		$("#userFormBody").text("[성별 입력 오류] 성별을 선택 해 주세요.");
		$('#userForm').modal('show');
		$('#genderDiv').addClass("has-error");
		return false;
	}
	return true;
}
function logout() {
	$("#logout").submit();
}
$(function() {
	
	if(${error==true}){
		$("#userFormBody").text("[Password 입력 오류] Password를 한번 더 확인 해 주세요.");
		$('#userForm').modal('show');
	}
	
	var re_pwd = /^[a-zA-Z0-9]{6,18}$/; 
	$('#newPwd').keyup( function() {
		if ($('#newPwd').val().length == 0) {
			$("#newPwdLength").text(''); 
		} 
		else if (!re_pwd.test($('#newPwd').val())) { 
			$("#newPwdLength").css("color","red");
			$("#newPwdLength").text('새로운 비밀번호를 영문, 숫자으로 구성 된  6~18 문자로 입력해주세요.');
			$('#newPwdDiv').addClass("has-error");
		} 
		else if(re_pwd.test($('#newPwd').val())) { 
			$("#newPwdLength").css("color","green");
			$("#newPwdLength").text('적당합니다.'); 
			$('#newPwdDiv').removeClass("has-error");
		}
	});
});
function tog() {
	$("#newPwdCon").toggle();
	$("#newBut").toggle();
	$("#newPwdLength").text(''); 
	$('#newPwdDiv').removeClass("has-error");
}
function edit() {
	$("#pwd").val($("#pwdModal").val());
	$("#editForm").submit();
}
</script>
<style>
#newPwdCon{
display: none;
}
</style>
</head>
<body>
<sec:authentication var="id" property="name"/>
	<header>
		<div id="navigation"class="navbar navbar-inverse navbar-fixed-top default"role="navigation">
			<div class="container">
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
									<li><a href="<c:url value="/user/join"/>">매니저계정만들기</a></li>
								</sec:authorize>
								<sec:authorize access="hasAnyAuthority('MANAGER','ADMIN')">
									<li><a href="<c:url value="/book/add"/>">도서등록</a></li>
								</sec:authorize>
					</ul>
						<ul class="nav navbar-nav navbar-right" id="mynav">
								<sec:authorize access="isAuthenticated()">
								<c:url var="user" value="/user/info">
								<c:param name="id" value="${id }" />
								</c:url>
								<li><a href="javascript:logout();">로그아웃</a></li>
								<li><a href="${user}">내 서재 가기</a></li>
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
<h3>개인 정보 수정</h3>
</div>
<P></P>
<div id="inputCon">
<form:form action="edit" commandName="userVo" method="post" class="form-horizontal" id="editForm" onsubmit="return re();">
<form:hidden path="userid"/>
<form:hidden path="upwd" id="pwd"/>
<div class="form-group" id="newPwdDiv">
    <label for="Password" class="col-sm-2 control-label">Password</label>
    <div class="col-sm-10" id="newBut">
    <button type="button" onclick="tog();" class="btn btn-theme btn-sm">비밀번호 변경</button>
    </div>
    <div class="col-sm-10" id="newPwdCon">
    <input type="password" name="newpwd" class="form-control" id="newPwd" placeholder="새로운 비밀번호를 영문, 숫자으로 구성 된  6~18 문자로 입력해주세요." />
    <span class="help-block">
     <span id="newPwdLength" ></span><br>
    <button type="reset" onclick="tog();" class="btn btn-theme btn-sm">취소</button>
    </span>
    </div>
  </div>
  
<div class="form-group" id="nameDiv">
    <label for="name" class="col-sm-2 control-label">이름</label>
    <div class="col-sm-10">
    <form:input path="uname" class="form-control" id="name" />
    </div>
  </div>
  
  <div class="form-group" id="phoneDiv">
    <label for="phone" class="col-sm-2 control-label">전화번호</label>
    <div class="col-sm-10">
    <form:input path="phone" class="form-control" id="phone" placeholder="\"-\"없이 입력해주세요." />
    <span class="help-block">
    "-"없이 입력해주세요.<br>
    </span>
    </div>
  </div>

     <div class="form-group" id="emailDiv">
    <label for="email" class="col-sm-2 control-label">이메일</label>
    <div class="col-sm-10">
    <form:input path="uemail" class="form-control" id="email"/>
    </div>
  </div>
  
   <div class="form-group" id="genderDiv">
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
<div id="bset">
<a href="#editModal" data-toggle="modal"><button type="button" class="btn btn-theme">작성완료</button></a>
<button type="reset" class="btn btn-theme">다시 작성하기</button>
</div>
</form:form>
</div>
</div>
</div>
</div>
</section>
<!-- 정보수정 모달 -->
<div class="modal fade" id="editModal" tabindex="-1"  aria-labelledby="myModalLabel" aria-hidden="true">
<div class="modal-dialog">
<div class="modal-content">
<div class="modal-header">
<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
<h4 class="modal-title" id="editModalLabel">정보 수정</h4>
</div>
<div class="modal-body">
<div class="form-group">
 정보 수정을 원하시면 현재 비밀번호를 입력해주세요. (필수사항)
</div>
<div class="form-group">
<label for="pwd" class="col-sm-2 control-label">Password</label>
<div class="col-sm-10">
<input type="password" class="form-control" id="pwdModal">
</div>
</div>
<br>
</div>
<div class="modal-footer">
<button type="button"  class="btn btn-success" onclick="edit();">확인</button>
<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
</div>
</div>
</div>
</div>	
<!--로그아웃  -->
<form action="<c:url value="/logout"/>" method="post" id="logout">
		<input type="hidden" name="${_csrf.parameterName }"
			value="${_csrf.token }">
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