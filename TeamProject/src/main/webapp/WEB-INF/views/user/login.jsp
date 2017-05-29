<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>로그인해주세요</title>
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
</script>
<style>
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
						<ul class="nav navbar-nav navbar-right" id="mynav">
								<sec:authorize access="!isAuthenticated()">
									<li><a href="<c:url value="/user/join"/>">회원가입</a></li>
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
<section id="login" class="section gray">
<div class="container">
	<div class="row">
		<div class="col-md-8 col-md-offset-2">
			<div class="heading">
				<h3>로그인 해 주세요.</h3>
			</div>
			<br>
				<div class="sub-heading">
				<c:choose>
				<c:when test="${join==true}">
				<p class="bg-info">
				가입을 환영합니다. 
				</p>
				</c:when>
				<c:when test="${param.error==true }">
				<p class="bg-danger">
				아이디와 비밀번호를 확인해주세요.
				</p>
				</c:when>
				</c:choose>
				
			</div>
				<div id="inputCon">
				<form  action='<c:url value="/user/login"/>' class="form-horizontal" method="post" id="loginForm"> 
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
				<div id="bset">
				<button type="submit" class="btn btn-theme" >로그인</button>
				</div>
				</form>
			</div>
		</div>
	</div>
</div>
</section>

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
</body>
</html>