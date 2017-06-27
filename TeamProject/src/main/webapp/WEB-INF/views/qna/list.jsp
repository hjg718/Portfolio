<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Q&amp;A게시판 리스트</title>
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
<script>
function search() {
	   var param = $("#searchF").serialize();
	   $.ajax({
	      url : "find",
	      method : "post",
	      data : param,
	      dataType : "json",
	      success : function(r) {
	    	  $(".cell").remove();
              for (var i=0; i < r.length; i++) {
                 var tr = $("<tr class='cell'></tr>");
                 var td = $("<td>" + r[i].num + "</td>");
                 tr.append(td);
                 td = $("<td id='title'><a href='<c:url value='/qna/read?num="+r[i].num+"'/>'>"
                       + r[i].title + "</a></td>");
                 tr.append(td);
                 td = $("<td>" + r[i].author + "</td>");
                 tr.append(td);
                 $("table").append(tr);
              }
	         $('#page-selection').empty();
	          $('#page-selection').off("page");
	           $('#page-selection').bootpag({
	                 total: r[0].total,        
	                 page:  r[0].curr,          
	                 maxVisible: 5,     
	                 leaps: true,
	                 firstLastUse: true,
	                 first: '←',
	                 last: '→',
	                 wrapClass: 'pagination',
	                 activeClass: 'active',
	                 disabledClass: 'disabled',
	                 nextClass: 'next',
	                 prevClass: 'prev',
	                 lastClass: 'last',
	                 firstClass: 'first'
	             }).on("page", function(event, num){
	                var param={};
	                param.pgnum = num;
	                param.category = $("#searchF select[name=category]").val();
	                param.keyword=$("#searchF input[name=keyword]").val();
	                param.${_csrf.parameterName} = '${_csrf.token }';
	                $.ajax({
	                   url : 'find',
	                   method : 'post',
	                   data : param,
	                   dataType : 'json',
	                   success : function(r){
	                		  $(".cell").remove();
	                          for (var i=0; i < r.length; i++) {
	                             var tr = $("<tr class='cell'></tr>");
	                             var td = $("<td>" + r[i].num + "</td>");
	                             tr.append(td);
	                             td = $("<td id='title'><a href='<c:url value='/qna/read?num="+r[i].num+"'/>'>"
	                                   + r[i].title + "</a></td>");
	                             tr.append(td);
	                             td = $("<td>" + r[i].author + "</td>");
	                             tr.append(td);
	                             $("table").append(tr);
	                          }
	                   },
	                   error : function(x,s,e){
	                      alert('오류!');
	                   }
	                });
	            });
	                
	      },
	      error : function(x,s,e) {
	         alert("오류!");
	      }
	      
	   });
	   return false;
	}
$(function(){
         $('#page-selection').bootpag({
            total:"${list[0].totalpages}",        
             page:"${list[0].page}",   
             maxVisible: 5,     
             leaps: true,
             firstLastUse: true,
             first: '←',
             last: '→',
             wrapClass: 'pagination',
             activeClass: 'active',
             disabledClass: 'disabled',
             nextClass: 'next',
             prevClass: 'prev',
             lastClass: 'last',
             firstClass: 'first'
         }).on("page", function(event, num){
             var param = {};
             param.${_csrf.parameterName} = '${_csrf.token }';
             param.pgnum = num;
             $.ajax({
              url : "page",
              method : "post",
              data : param,
              dataType : "json",
              success : function(r){
                 $(".cell").remove();
               for (var i=0; i < r.length; i++) {
                  var tr = $("<tr class='cell'></tr>");
                  var td = $("<td>" + r[i].num + "</td>");
                  tr.append(td);
                  td = $("<td id='title'><a href='<c:url value='/qna/read?num="+r[i].num+"'/>'>"
                        + r[i].title + "</a></td>");
                  tr.append(td);
                  td = $("<td>" + r[i].author + "</td>");
                  tr.append(td);
                  $("table").append(tr);
               }
              },
              error : function(x, s, e) {
                 alert("오류");
              }
           });
           return false;
         });
   });
function logout() {
	$("#logout").submit();
}
function check() {
	var ch = /.{2,}/;
	 var pass = ch.test($("#searchForm input[name=keyword]").val());
	if(!pass){
		$('#input').modal('show');
	}
	return pass;
}
</script>
<style>
.panel-heading {
	text-align: center;
}

th {
	text-align: center;
	height: 40px;
	font-size: 20px;
}

td {
	width: 33%;
	text-align: center;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

table {
	table-layout: fixed;
}

#title {
	text-align: left;
}

#searchF [name=keyword] {
	width: 300px;;
}

#toolBox {
	text-align: center;
}
</style>
</head>
<body>
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
	<section id="infoResult" class="section gray">
		<div class="container">
			<div class="row">
				<div class="col-md-8 col-md-offset-2">
					<div class="panel panel-success">
						<div class="panel-heading">
							<h3>Q&amp;A.</h3>
						</div>
						<div class="panel-body">
							<table class="table table-striped table-hover">
								<tr>
									<th>번호</th>
									<th>제목</th>
									<th>글쓴이</th>
								</tr>
								<c:forEach var="qna" items="${list }">
									<tr class="cell">
										<td>${qna.num}</td>
										<td id="title"><a
											href="<c:url value="/qna/read?num=${qna.num}"/>">${qna.title}</a></td>
										<td>${qna.author}</td>
									</tr>
								</c:forEach>
							</table>
							<p>
							<div id="toolBox">
								<div id="page-selection"></div>
								<form id="searchF" onsubmit="return search();"
									class="navbar-form">
									<input type="hidden" name="${_csrf.parameterName }"
										value="${_csrf.token }"> <input type="hidden"
										name="pgnum" value="1"> <select name="category"
										class="form-control">
										<option value="title" selected>제목</option>
										<option value="author">작성자</option>
										<option value="contents">내용</option>
									</select> <input type="text" name="keyword" class="form-control">
									<button type="submit" class="btn btn-theme">검색</button>
								</form>
								<ul class="list-inline" style="text-align: center;">
									<li><a class="link" href="<c:url value="/"/>">&bull;
											메인</a></li>
									<li>
									<li></li>
									<li><a class="link" href="save">&bull; 문의하기</a></li>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
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
</body>
</html>