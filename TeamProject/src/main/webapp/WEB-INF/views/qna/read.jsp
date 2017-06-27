<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

<title>글 읽기</title>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="<c:url value="/resources/jquery.bootpag.min.js" />"></script>
<link href="<c:url value='/resources/assets/css/bootstrap.css'/>"
	rel="stylesheet" />
<link href="<c:url value='/resources/assets/css/bootstrap-theme.css'/>"
	rel="stylesheet" />
<link href="<c:url value='/resources/assets/css/style.css'/>"
	rel="stylesheet" />
<link rel="stylesheet"
	href="<c:url value='/resources/assets/color/default.css'/>">
<script src="<c:url value='/resources/assets/js/bootstrap.js'/>"></script>
<style>
#result {
	font-size: 14pt;
}

dd pre {
	font-size: 13pt;
}

#answer {
	display: none;
}

pre {
	white-space: pre-line;
}
</style>
<script type="text/javascript">
$(function() {
	if(${error==true}){
		
		$("#readModalBody").text("비밀번호를 확인해주세요. ");
		$('#readModal').modal('show');
	}
})

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
function showModify() {
	$("#modifyModal").modal("show");
}
function modify() {
	$("#modify [name=pwd]").val($("#pwdModify").val());
	$("#modify").submit();
}
function showDel() {
	$("#deleteModal").modal("show");
}
function del() {
	$('#deleteModal').modal('hide')
	$("#delete [name=pwd]").val($("#pwdDelete").val());
	var param = $("#delete").serialize();
	$.ajax({
		url:'delete',
		method:'post',
		data:param,
		dataType:'json',
		success:function(r){
			if(r.pass==true){
				$("#readModalBody").text("삭제되었습니다.");
				$('#readModal').modal('show');
				$('#readModal').on('hidden.bs.modal', function (e) {
			 		location.href="list";
			 	});
			}
			else if(r.pass==false ){
				$("#readModalBody").text("비밀번호를 확인하세요.");
				$('#readModal').modal('show');
			}
		},
		error:function(xhr,status,err){
			alert("오류!");
		}
	});
}
function answer() {
	$("#answer").toggle();
}

function re() {
	
	var t = $('#title').val();
	var c = $('#qcontents').val();
	var p = $('#pwd').val();
	var pche = /^[0-9]{4}$/; 
	
	$('#titleDiv').removeClass("has-error");
	$('#contentsDiv').removeClass("has-error");
	$('#pwdDiv').removeClass("has-error");
	
	if(t==""||t==null){
		$("#readModalBody").text("제목을 입력하세요. ");
		$('#readModal').modal('show');
		$('#titleDiv').addClass("has-error");
			return false;
	}else if(c==""||c==null){
		$("#readModalBody").text("내용을 입력하세요 .");
		$('#readModal').modal('show');
		$('#contentsDiv').addClass("has-error");
		return false;
	}else if(!pche.test(p)){
		$("#readModalBody").text("비밀번호 숫자 4자리를 입력하세요.");
		$('#readModal').modal('show');
		$('#pwdDiv').addClass("has-error");
		return false;
	}
	
	   var param = $("#reForm").serialize();
	   $.ajax({
	      url : "reple",
	      method : "post",
	      data : param,
	      dataType : "json",
	      success : function(r) {
	    	 if(r.ok==true){
	    		 $("#readModalBody").text("답변이 성공적으로 작성되었습니다. ");
	    			$('#readModal').modal('show');
	    			$('#readModal').on('hidden.bs.modal', function (e) {
				 		location.href = "recent?id=<sec:authentication property='name' />"
				 	});
	    	 }
	      },
	      error : function(x, s, e) {
	         alert('오류!');
	      }
	   });
	   return false;
	}
</script>
<body>
	<sec:authentication var="id" property="name" />
	<header>
		<div id="navigation"
			class="navbar navbar-inverse navbar-fixed-top default"
			role="navigation">
			<div class="container">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse"
						data-target="#bs-example-navbar-collapse-1">
						<span class="icon-bar"></span> <span class="icon-bar"></span> <span
							class="icon-bar"></span>
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

							<form action="<c:url value="/book/search"/>" method="post"
								onsubmit="return check();" class="navbar-form navbar-right"
								id="searchForm">
								<input type="hidden" name="${_csrf.parameterName }"
									value="${_csrf.token }"> <select name="category"
									class="form-control input-lg">
									<option value="bname">제목</option>
									<option value="author">저자</option>
									<option value="publisher">출판사</option>
								</select> <input type="text" name="keyword" id="key"
									class="form-control input-lg" placeholder="도서정보를 입력해주세요">
								<button type="submit" class="btn btn-theme">검색</button>
							</form>
						</nav>
					</div>
				</div>
			</div>
		</div>
	</header>
	<section id="recentcon" class="section gray">
		<div class="container">
			<div class="row">
				<div class="col-md-8 col-md-offset-2">
					<div id="result">
						<div class="panel panel-success">
							<div class="panel-heading">
								<h4 class="panel-title">문의 내용${error}</h4>
							</div>
							<div class="panel-body">
								<dl class="dl-horizontal">
									<dt>제목 :</dt>
									<dd>
										<p>${read.title}</p>
									</dd>
									<dt>작성자 :</dt>
									<dd>
										<p>${read.author}</p>
									</dd>
									<dt>작성일 :</dt>
									<dd>
										<p>${read.bdate}</p>
									</dd>
									<dt>내용 :</dt>
									<dd>
										<pre>${read.qcontents}</pre>
									</dd>
								</dl>
								<ul class="list-inline" style="text-align: center;">
									<li><a class="link" href="<c:url value="/qna/list"/>">&bull;
											목록보기</a></li>
									<li></li>
									<li><a class="link" href="javascript:showModify();">&bull;
											글 수정</a></li>
									<li></li>
									<li><a class="link" href="javascript:showDel();">&bull;
											글 삭제</a></li>
									<sec:authorize access="hasAnyAuthority('MANAGER','ADMIN')">
										<li></li>
										<li><a class="link" href="javascript:answer()">&bull;
												답변 달기</a></li>
									</sec:authorize>
								</ul>
							</div>
						</div>

						<div id="answer">
							<div class="panel panel-success">
								<div class="panel-heading">
									<h4 class="panel-title">답변 달기</h4>
								</div>
								<div class="panel-body">
									<form id="reForm" class="form-horizontal"
										onsubmit="return re();">
										<input type="hidden" name="${_csrf.parameterName }"
											value="${_csrf.token }"> <input type="hidden"
											name="ref" value="${read.num}">

										<div class="form-group" id="titleDiv">
											<label for="name" class="col-sm-2 control-label">제목 </label>
											<div class="col-sm-10">
												<input type="text" name="title" id="title"
													class="form-control" value="RE:">
											</div>
										</div>

										<div class="form-group" id="contentsDiv">
											<label for="name" class="col-sm-2 control-label">내용 </label>
											<div class="col-sm-10">
												<textarea class="form-control" id="qcontents" rows="5"
													style="resize: none;" name="qcontents"
													placeholder="답변을 입력해주세요"></textarea>
											</div>
										</div>

										<div class="form-group">
											<label for="name" class="col-sm-2 control-label">작성자
											</label>
											<div class="col-sm-10">
												<input type="text" disabled class="form-control"
													value="${id }"> <input type="hidden" name="author"
													value="${id }">
											</div>
										</div>

										<div class="form-group" id="pwdDiv">
											<label for="name" class="col-sm-2 control-label">Password</label>
											<div class="col-sm-10">
												<input type="password" name="pwd" id="pwd"
													class="form-control" placeholder="비밀번호를 입력해주세요">
											</div>
										</div>

										<div id="bset">
											<button type="submit" class="btn btn-theme">작성 완료</button>
											<button type="reset" class="btn btn-theme">다시 작성</button>
										</div>
									</form>
								</div>
							</div>
						</div>

					</div>
				</div>
			</div>
		</div>
	</section>

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
				<div class="modal-body">2자 이상 입력해주세요.</div>
				<div class="modal-footer">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">확인</button>
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
				<form action='<c:url value="/user/login"/>' class="form-horizontal"
					method="post" id="loginForm">
					<div class="modal-body">
						<input type="hidden" name="${_csrf.parameterName }"
							value="${_csrf.token }">
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
						<button type="submit" class="btn btn-success">로그인</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<!--상태 모달  -->
	<div class="modal fade" id="readModal" tabindex="-1"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body" id="readModalBody"></div>
				<div class="modal-footer">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">확인</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 글 수정 모달 -->
	<div class="modal fade" id="modifyModal" tabindex="-1"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="modifyModalLabel">글 수정</h4>
				</div>
				<div class="modal-body">
					<div class="form-group">수정을 원하시면 비밀번호를 입력해주세요. (필수사항)</div>
					<div class="form-group">
						<label for="pwd" class="col-sm-2 control-label">Password</label>
						<div class="col-sm-10">
							<input type="password" class="form-control" id="pwdModify">
						</div>
					</div>
					<br>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-success" onclick="modify();">확인</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>

	<!--수정 폼  -->
	<form action="<c:url value="/qna/modifyPage"/>" method="post"
		id="modify">
		<input type="hidden" name="${_csrf.parameterName }"
			value="${_csrf.token }"> <input type="hidden" name="num"
			value="${read.num }"> <input type="hidden" name="pwd">
	</form>

	<!-- 글 삭제 모달 -->
	<div class="modal fade" id="deleteModal" tabindex="-1"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="deleteModalLabel">글 삭제</h4>
				</div>
				<div class="modal-body">
					<div class="form-group">삭제을 원하시면 비밀번호를 입력해주세요. (필수사항)</div>
					<div class="form-group">
						<label for="pwd" class="col-sm-2 control-label">Password</label>
						<div class="col-sm-10">
							<input type="password" class="form-control" id="pwdDelete">
						</div>
					</div>
					<br>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-success" onclick="del();">확인</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>

	<!--삭제 폼  -->
	<form id="delete">
		<input type="hidden" name="${_csrf.parameterName }"
			value="${_csrf.token }"> <input type="hidden" name="num"
			value="${read.num }"> <input type="hidden" name="pwd">
	</form>

</body>
</html>
