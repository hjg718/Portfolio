<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

<title>작성 완료</title>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="<c:url value="/resources/jquery.bootpag.min.js" />"></script>
<link href="<c:url value='/resources/assets/css/bootstrap.css'/>" rel="stylesheet" />
<link href="<c:url value='/resources/assets/css/bootstrap-theme.css'/>" rel="stylesheet" />
<link href="<c:url value='/resources/assets/css/style.css'/>" rel="stylesheet" />
<link rel="stylesheet" href="<c:url value='/resources/assets/color/default.css'/>">
<script src="<c:url value='/resources/assets/js/bootstrap.js'/>"></script>
<style>
#result{
font-size: 14pt;
}

dd pre{
font-size: 13pt;
}
</style>
<script type="text/javascript">
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
function edit() {
	$("#edit").submit();
}
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
<section id="recentcon" class="section gray">
<div class="container">
	<div class="row">
		<div class="col-md-8 col-md-offset-2">
<div class="heading">
<h4>작성하신 글을 확인해 주세요.</h4>
</div>
<div id="result">
<div class="panel panel-success">
<div class="panel-heading">
<h4 class="panel-title">작성내용 내용</h4>
</div>
<div class="panel-body">
<dl class="dl-horizontal">

<dt>글 번호 :</dt>
  <dd><p>${board.num}</p></dd>
<dt>제목 :</dt>
  <dd><p>${board.title}</p></dd>
  <dt>조회수 :</dt>
  <dd><p>${board.readCnt}</p></dd>
    <dt>추천수 :</dt>
  <dd><p>${board.goodcnt}</p></dd>
  <dt>작성자 :</dt>
  <dd><p>${board.author}</p></dd>
     <dt>작성일 :</dt>
  <dd><p>${board.regdate}</p></dd>
  <dt>내용 :</dt>
  <dd>
  <pre>${board.contents}</pre>
  </dd>
</dl>
<ul class="list-inline" style="text-align: center;">
<li><a class="link" href="<c:url value="/board/list"/>">&bull; 목록보기</a></li>
<li></li>
<li><a class="link" href="javascript:edit();">&bull; 글 수정</a></li>
</ul>
</div>
</div>
</div>
</div>
</div>
</div>
</section>
<!--수정 폼  -->
<form action="<c:url value="/board/edit"/>" method="post" id="edit">
<input type="hidden" name="${_csrf.parameterName }"	value="${_csrf.token }">
<input type="hidden" name="num" value="${board.num }">
</form>

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
		
</body>
</html>
