<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

<title>수정하기</title>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="<c:url value="/resources/jquery.bootpag.min.js" />"></script>
<link href="<c:url value='/resources/assets/css/bootstrap.css'/>" rel="stylesheet" />
<link href="<c:url value='/resources/assets/css/bootstrap-theme.css'/>" rel="stylesheet" />
<link href="<c:url value='/resources/assets/css/style.css'/>" rel="stylesheet" />
<link rel="stylesheet" href="<c:url value='/resources/assets/color/default.css'/>">
<script src="<c:url value='/resources/assets/js/bootstrap.js'/>"></script>
<style>
</style>
<script type="text/javascript">
function update(){
	var t = $('#title').val();
	var c = $('#contents').val();
	
	
	$('#titleDiv').removeClass("has-error");
	$('#contentsDiv').removeClass("has-error");
	
	if(t==""||t==null){
		$("#updateModalBody").text("제목을 입력하세요. ");
		$('#updateModal').modal('show');
		$('#titleDiv').addClass("has-error");
			return false;
	}else if(c==""||c==null){
		$("#updateModalBody").text("내용을 입력하세요 .");
		$('#updateModal').modal('show');
		$('#contentsDiv').addClass("has-error");
		return false;
	}
	var param = $('#editForm').serialize();
	$.ajax({
		url:'update',
		method:'post',
		data:param,
		dataType:'json',
		success:function(res){
			
			if(res.ok){
				$("#updateModalBody").text("수정 완료 ");
				$('#updateModal').modal('show');
				$('#updateModal').on('hidden.bs.modal', function (e) {
					location.href="info?num=${list.num}";
				});
			}else{
				$("#updateModalBody").text("수정 실패 ");
				$('#updateModal').modal('show');
			}
		},
		error:function(xhr,status,err){
			alert("오류");
			}
	});
	return false;
}
function logout() {
	$("#logout").submit();
}
function check() {
	var ch = /.{2,}/;
	 var pass = ch.test($("input[name=keyword]").val());
	if(!pass){
		$('#input').modal('show');
	}
	return pass;
}
$(function() {
	if(${error==true}){
		$("#modifyModalBody").text("글 수정을 실패했습니다.");
		$('#modifyModal').modal('show');
	}
})
</script>
<body>
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
<sec:authorize access="!isAuthenticated()">
<li><a href="#myModal" data-toggle="modal">로그인</a></li>
<li><a href="<c:url value="/user/join"/>">회원가입</a></li>
</sec:authorize>
<sec:authorize access="isAuthenticated()">
<li><a href="javascript:logout();">로그아웃</a></li>
<li><a href="<c:url value="/user/info"/>">내 서재 가기</a></li>
</sec:authorize>
<li><a href="<c:url value="/qna/list"/>">Q&amp;A게시판</a></li>
<li><a href="<c:url value="/board/list"/>">자유게시판</a></li>
</ul>
					
<form action="<c:url value="/book/search"/>" method="post" onsubmit="return check();"
class="navbar-form navbar-right" id="searchForm">
<input type="hidden" name="${_csrf.parameterName }"	value="${_csrf.token }"> 
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
<h3>수정 하기</h3>
</div>
<P></P>
<div id="inputCon">
<form:form class="form-horizontal" id="editForm" modelAttribute="list" method="post" onsubmit="return update();">
<form:hidden path="num"/>


<div class="form-group" id="titleDiv">
<label for="name" class="col-sm-2 control-label">제목 </label>
<div class="col-sm-10">
<form:input path="title" id="title" class="form-control"/>
</div>
</div>

<div class="form-group" id="contentsDiv">
<label for="name" class="col-sm-2 control-label">내용 </label>
<div class="col-sm-10">
<form:textarea path="contents" class="form-control" rows="15" style="resize: none;" id="contents"></form:textarea>
</div>
</div>

<div class="form-group" >
<label for="name" class="col-sm-2 control-label">작성자 </label>
<div class="col-sm-10">
<input type="text" disabled class="form-control" value="${list.author }">
</div>
</div>

<div id="bset">
 <button type="submit" class="btn btn-theme">작성 완료 </button>
 <button type="reset" class="btn btn-theme">다시 작성</button>
 <a href="list" class="btn btn-theme">목록 보기</a>
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
	
<!--상태 모달  -->
<div class="modal fade" id="updateModal" tabindex="-1"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body" id="updateModalBody">
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
