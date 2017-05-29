<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" trimDirectiveWhitespaces="true"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>도서 등록확인</title>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<c:url var="url" value="/resources/jquery.bootpag.min.js" />
<script src="${url }"></script>
<link href="<c:url value='/resources/assets/css/bootstrap.css'/>" rel="stylesheet" />
<link href="<c:url value='/resources/assets/css/bootstrap-theme.css'/>" rel="stylesheet" />
<link href="<c:url value='/resources/assets/css/style.css'/>" rel="stylesheet" />
<link rel="stylesheet" href="<c:url value='/resources/assets/color/default.css'/>">
<script src="<c:url value='/resources/assets/js/bootstrap.js'/>"></script>
<script>
function logout() {
	$("#logout").submit();
}
</script>
<style>
#headimg{
display: inline-block;
}
#headtable{
display: inline-table;
vertical-align: top;
}
#headtable td{
height:70px;
width: 300px;
font-size: 15pt;
}
.panel{
padding-top: 15px;
}
#rentalInfo{
line-height: 20pt;
}
.link{
font-size: 15pt;
}
pre{
white-space: pre-line;
}
</style>
</head>
<body>
<header>
<div id="navigation"class="navbar navbar-inverse navbar-fixed-top default"role="navigation">
<div class="container">
<div class="navbar-header">
<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
<span class="icon-bar"></span> 
<span class="icon-bar"></span> 
<span class="icon-bar"></span>
</button>
<a class="navbar-brand" href="<c:url value="/"/>">RD Library</a>
</div>
<div>
<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
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
<li><a href="javascript:logout();">로그아웃</a></li>
<li><a href="<c:url value="/user/info"/>">내 서재 가기</a></li>
</sec:authorize>
<li><a href="<c:url value="/qna/list"/>">Q&amp;A게시판</a></li>
<li><a href="<c:url value="/board/list"/>">자유게시판</a></li>
</ul>
					
<form action="<c:url value="/book/search"/>" method="post" onsubmit="return check();" class="navbar-form navbar-right" id="searchForm">
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
<div class="panel panel-default">
<div class="panel-body">
<div id="headimg">
<img class="img-rounded" width="200px" height="210px" src="img?coverName=${book.vo.coverName} "/>
</div>
<div id="headtable">
<table class="table table-striped" >
<tr class="success">
<td class="cell bname" >${book.vo.bname }</td>
</tr>
<tr class="success">
<td class="cell author">${book.vo.author }</td>
</tr>
<tr class="success"> 
<td class="cell publisher">${book.vo.publisher }</td>
</tr>
</table>
</div>
</div>
</div>
</div>
<div id="result">
<div class="panel panel-success">
<div class="panel-heading">
<h4 class="panel-title">목차</h4>
</div>
<div class="panel-body">
<pre>
${book.vo.bindex }
</pre>
</div>
</div>
<div class="panel panel-success">
<div class="panel-heading">
<h4 class="panel-title">줄거리</h4>
</div>
<div class="panel-body">
<pre>
${book.vo.bcontents }
</pre>
</div>
</div>
<div class="panel panel-success">
<div class="panel-heading">
<h4 class="panel-title">도서정보</h4>
</div>
<div class="panel-body">
<dl class="dl-horizontal">
<dt>저자 :</dt>
  <dd>${book.vo.author }</dd>
  <dt>출판사 :</dt>
  <dd>${book.vo.publisher }</dd>
  <dt>출판일 :</dt>
  <dd>${book.vo.pdate }</dd>
   <dt>카테고리 :</dt>
  <dd>
<c:forEach var="cate" varStatus="sta" items="${book.vo.cate }">
<c:if test="${!sta.last }">${cate },&nbsp;</c:if>
<c:if test="${sta.last }">${cate}</c:if>
</c:forEach>
</dd>
</dl>

</div>
</div>
</div>
<div class="panel panel-default">
<div class="panel-body">
<ul class="list-inline" style="text-align: center;">
<li><a class="link" href="<c:url value="/"/>">&bull; 메인</a></li>
<li></li>
<li><a class="link" href="add">&bull; 추가등록하러 가기</a></li>
<li></li>
<li><a class="link" href="<c:url value="/book/edit?bnum=${book.vo.bnum}"/>">도서 수정</a></li>
</ul>
</div>
</div>
</div>
</div>
</div>
</section>

<!--로그아웃  -->
<form action="<c:url value="/logout"/>" method="post" id="logout">
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
</form>
</body>
</html>