<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" trimDirectiveWhitespaces="true"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>

<meta charset="utf-8">
<title>도서 정보 : ${book.vo.bname }</title>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<c:url var="url" value="/resources/jquery.bootpag.min.js" />
<script src="${url }"></script>
<link href="<c:url value='/resources/assets/css/bootstrap.css'/>" rel="stylesheet" />
<link href="<c:url value='/resources/assets/css/bootstrap-theme.css'/>" rel="stylesheet" />
<link href="<c:url value='/resources/assets/css/style.css'/>" rel="stylesheet" />
<link rel="stylesheet" href="<c:url value='/resources/assets/color/default.css'/>">
<script src="<c:url value='/resources/assets/js/bootstrap.js'/>"></script>

<script>
function list() {
	$("#list").submit();	
}
function rental() {
	var param =$("#rentalForm").serialize();
	$.ajax({
		url : "rental",
		method : "post",
		data : param,
		dataType : "json",
		success : function(res){
			if(res.pass==true){
				$("#readModalBody").text("대여완료!");
				$('#readModal').modal('show');
				$('#readModal').on('hidden.bs.modal', function (e) {
			 		location.reload();
			 	});
				
			}
			else {
				$("#readModalBody").text("대여불가!");
				$('#readModal').modal('show');
			}
		},
		error : function(x,s,e) {
			alert("오류!");
		}
	});
}
function booking() {
	var param =$("#bookingForm").serialize();
	$.ajax({
		url : "booking",
		method : "post",
		data : param,
		dataType : "json",
		success : function(res){
			if(res.pass==true){
				$("#readModalBody").text("예약완료!");
				$('#readModal').modal('show');
				$('#readModal').on('hidden.bs.modal', function (e) {
			 		location.reload();
			 	});
			}
			else {
				$("#readModalBody").text("예약불가!");
				$('#readModal').modal('show');
			}
		},
		error : function(x,s,e) {
			alert("오류!");
		}
	});
}
function logout() {
	$("#logout").submit();
}
function deleteBook() {
	if(${book.rentaluser!=null}){
		$("#readModalBody").text("대여된 도서는 삭제할 수 없습니다.");
		$('#readModal').modal('show');
		return;
	}
	var param = $("#deleteForm").serialize();
	$.ajax({
		url : "delete",
		method : "post",
		data : param,
		dataType : "json",
		success : function(res) {
			if(res.pass){
				$("#readModalBody").text("삭제되었습니다.");
				$('#readModal').modal('show');
				$('#readModal').on('hidden.bs.modal', function (e) {
			 		list();
			 	});
			}
			
		},
		error : function(x,s,e) {
			alert("오류!");
		}
	});
}
function check() {
	var ch = /.{2,}/;
	 var pass = ch.test($("input[name=keyword]").val());
	if(!pass){
		$('#input').modal('show');
	}
	return pass;
}
function clickSearch(category,keyword) {
	$("#csc").val(category);
	$("#csk").val(keyword);
	$("#clickSearch").submit();
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
<sec:authentication var="id" property="name"/>
<c:set var="ok" value="false"/>
<c:forEach var="sub" items="${book.subscriber}">
<c:if test="${sub==id}">
<c:set var="ok" value="true"/>
</c:if>
</c:forEach>
<section id="readResult" class="section gray">
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
<td class="cell author"><a href="javascript:clickSearch('author','${book.vo.author }');">${book.vo.author }</a></td>
</tr>
<tr class="success"> 
<td class="cell publisher"><a href="javascript:clickSearch('publisher','${book.vo.publisher }');">${book.vo.publisher }</a></td>
</tr>
</table>
<c:choose>
<c:when test="${book.rentaluser!=null||book.bookingnum>0 }">
<c:choose>
<c:when test="${book.rentaluser!=id }">
<div class="panel panel-warning">
<div class="panel-heading">
<h4 class="panel-title">이도서는 대여중 (예약중) 입니다.</h4>
</div>
<div class="panel-body">
<c:choose>
<c:when test="${book.returndate!=null }">
<p> 반납예정일 : ${book.returndate }</p>
</c:when>
<c:otherwise>
<p> 예약자만 대여 가능합니다.</p>
<p> 예약인원 : ${book.bookingnum }/5명</p>
</c:otherwise>
</c:choose>
<c:choose>
<c:when test="${ok==true }">
<a class="btn btn-theme disabled">예약중</a>
</c:when>
<c:when test="${book.bookingnum<5&&ok==false }">
<sec:authorize access="hasAuthority('USER')">
<a class="btn btn-theme" href="<c:url value="javascript:booking();"/>">예약가능</a>
</sec:authorize>
			
<sec:authorize access="!isAuthenticated()">
<a class="btn btn-theme disabled">로그인 후 예약가능</a>
</sec:authorize>
</c:when>
<c:otherwise>
<a class="btn btn-theme disabled">예약정원을 초과했습니다.</a>
</c:otherwise>
</c:choose>
</div>
</div>
</c:when>
<c:otherwise>
<div class="panel panel-warning">
<div class="panel-heading">
<h4 class="panel-title">이 도서를 대여중입니다.</h4>
</div>
<div class="panel-body">
<a class="btn btn-theme disabled">대여중</a>
</div>
</div>
	
</c:otherwise>
</c:choose>
</c:when>

<c:otherwise>
<div class="panel panel-warning">
<div class="panel-heading">
<h4 class="panel-title">대여 가능</h4>
</div>
<div class="panel-body">
<sec:authorize access="hasAuthority('USER')">
<a class="btn btn-theme" href="<c:url value="javascript:rental();"/>">대여하기</a>
</sec:authorize>
<sec:authorize access="!isAuthenticated()">
<a class="btn btn-theme disabled">로그인 후 대여가능합니다.</a>
</sec:authorize>
</div>
</div>
</c:otherwise>
</c:choose>
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
<li><a class="link" href="<c:url value="/"/>">&bull; 메인</a></li><li>
<li></li>
<li><a class="link" href="javascript:list();">&bull; 목록보기</a></li>
<li></li>
<sec:authorize access="hasAnyAuthority('MANAGER','ADMIN')">
<li><a class="link" href="<c:url value="/book/edit?bnum=${book.vo.bnum}"/>">도서 수정</a></li>
<li></li>
<li><a class="link" href="javascript:deleteBook();">도서 삭제</a></li>
</sec:authorize>
</ul>
</div>
</div>
</div>
</div>
</div>
</section>
<!--결과모달 -->
 <div class="modal fade" id="readModal" tabindex="-1"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body" id="readModalBody">
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
<!-- 목록보기 폼  -->
<form action="search" method="post" id="list">
	<input type="hidden" name="${_csrf.parameterName }"	value="${_csrf.token }"> 
	<input type="hidden" name="category" value="${category}">				
	<input type="hidden" name="keyword" value="${keyword}">
</form>
<!-- 클릭 서치  -->
<form action="search" method="post" id="clickSearch">
	<input type="hidden" name="${_csrf.parameterName }"	value="${_csrf.token }"> 
	<input type="hidden" name="category" id="csc">				
	<input type="hidden" name="keyword" id="csk">
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

	<!-- 로그인 모달  -->
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
	<!--로그아웃  -->
<form action="<c:url value="/logout"/>" method="post" id="logout">
<input type="hidden" name="${_csrf.parameterName }"	value="${_csrf.token }">
</form>
<!--렌탈 폼  -->
<form id="rentalForm">
<input type="hidden" name="${_csrf.parameterName }"	value="${_csrf.token }">
<input type="hidden" name ="userid" value="<sec:authentication property='name'/>">
<input type="hidden" name ="booknum" value="${book.vo.bnum}">
</form>
<!--부킹 폼  -->
<form id="bookingForm">
<input type="hidden" name="${_csrf.parameterName }"	value="${_csrf.token }">
<input type="hidden" name ="userid" value="<sec:authentication property='name'/>">
<input type="hidden" name ="booknum" value="${book.vo.bnum}">
</form>
<!--삭제 폼  -->
<form id="deleteForm">
<input type="hidden" name="${_csrf.parameterName }"	value="${_csrf.token }">
<input type="hidden" name ="booknum" value="${book.vo.bnum}">
</form>
</body>
</html>