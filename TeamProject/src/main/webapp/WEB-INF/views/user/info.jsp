<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>내 서재 보기</title>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<link href="<c:url value='/resources/assets/css/bootstrap.css'/>" rel="stylesheet" />
<link href="<c:url value='/resources/assets/css/bootstrap-theme.css'/>" rel="stylesheet" />
<link href="<c:url value='/resources/assets/css/style.css'/>" rel="stylesheet" />
<link rel="stylesheet" href="<c:url value='/resources/assets/color/default.css'/>">
<script src="<c:url value='/resources/assets/js/bootstrap.js'/>"></script>
<script>
function secession() {
	if(${info.rvoList.size()>0}){
		$("#resultModalBody").text("대여 하신책을 반납해주세요!");
		$('#resultModal').modal('show');
		return;
	}
	$("#seceForm input[name=upwd]").val($("#secessionPwd").val());
	var param =$("#seceForm").serialize();
	$.ajax({
		url : "secession",
		method : "post",
		data : param,
		dataType : "json",
		success : function(res) {
			if(res.pass){
				$("#resultModalBody").text("성공적으로 탈퇴되었습니다.");
				$('#resultModal').modal('show');
				$('#resultModal').on('hidden.bs.modal', function (e) {
					$("#logout").submit();
				});
				
			}
		},
		error : function(x,s,e){
			alert("오류!");
		}
	});
}
function returnBook(num) {
	$("#returnForm input[name=num]").val(num);
	var param = $("#returnForm").serialize();
	$.ajax({
		url : "<c:url value='/book/returnBook'/>",
		method : "post",
		data : param,
		dataType : "json",
		success : function(res){
			if(res.pass){
				$("#resultModalBody").text("반납완료!");
				$('#resultModal').modal('show');
				$('#resultModal').on('hidden.bs.modal', function (e) {
					location.reload();
				});
			}
		},
		error : function(x,s,e){
			alert("오류!");
		}
	});
}
function cancel(num) {
	$("#cancelForm input[name=num]").val(num);
	var param = $("#cancelForm").serialize();
	$.ajax({
		url : "<c:url value='/book/cancel'/>",
		method : "post",
		data : param,
		dataType : "json",
		success : function(res){
			if(res.pass){
				$("#resultModalBody").text("예약취소완료!");
				$('#resultModal').modal('show');
				$('#resultModal').on('hidden.bs.modal', function (e) {
					location.reload();
				});
			}
		},
		error : function(x,s,e){
			alert("오류!");
		}
	});
}

function rental(booknum,bookingnum) {
	
	$("#rentalForm input[name=booknum]").val(booknum);
	$("#rentalForm input[name=bookingnum]").val(bookingnum);
	var param = $("#rentalForm").serialize();
	$.ajax({
		url : "<c:url value='/book/bookingrental'/>",
		method : "post",
		data : param,
		dataType : "json",
		success : function(res){
			if(res.pass==true){
				$("#resultModalBody").text("대여되었습니다.");
				$('#resultModal').modal('show');
				$('#resultModal').on('hidden.bs.modal', function (e) {
					location.reload();
				});
			}
			else{
				$("#resultModalBody").text("더 이상 대여할 수 없습니다.");
				$('#resultModal').modal('show');
			}
		},
		error : function(x,s,e){
			alert("오류!");
		}
	});
}

function logout() {
	$("#logout").submit();
}
</script>
<style>
.table{
text-align: center;
table-layout: fixed;
}
th{
text-align: center;
}
td{
white-space:nowrap;
overflow:hidden;
text-overflow: ellipsis;
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
									<li><a href="javascript:logout();">로그아웃</a></li>
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
<section id="infoResult" class="section gray">
<div class="container">
	<div class="row">
		<div class="col-md-8 col-md-offset-2">
<div class="heading">
<h3>서재 보기</h3>
</div>
<P></P>		
<div id="result">
<div class="panel panel-success">
<div class="panel-heading">
<h4 class="panel-title">회원 정보</h4>
</div>
<div class="panel-body">
<dl class="dl-horizontal">
 <dt>아이디 :</dt>
  <dd>${info.vo.userid }</dd>
  <dt>이름 :</dt>
  <dd>${info.vo.uname }</dd>
   <dt>전화번호 :</dt>
  <dd>${info.vo.phone }</dd>
  <dt>이메일 :</dt>
  <dd>${info.vo.uemail }</dd>
   <dt>성별 :</dt>
  <dd>
  <c:if test="${info.vo.gender=='m' }">남성</c:if>
  <c:if test="${info.vo.gender=='f' }">여성</c:if>
  </dd>
</dl>
</div>
</div>
<div class="panel panel-success">
<div class="panel-heading">
<h4 class="panel-title">대여 정보</h4>
</div>
<table class="table table-hover">
<tr>
<th>도서 제목</th>
<th>대여 시작일</th>
<th>반납 일</th>
<th>남은 대여일</th>
<th>반납</th>
</tr>
<c:forEach items="${info.rvoList }" var="ren" >
<tr id="ren${ren.num}">
<td><a href="<c:url value="/book/read?bnum=${ren.booknum}"/>">${ren.bookname}</a></td>
<td>${ren.rendate }</td>
<td>${ren.returndate }</td>
<td>${ren.day }</td>
<td><a href="javascript:returnBook(${ren.num });">반납하기</a></td>
</tr>
</c:forEach>
</table>
</div>
<div class="panel panel-success">
<div class="panel-heading">
<h4 class="panel-title">예약 정보</h4>
</div>
<table class="table table-hover">
<tr>
<th>도서 제목</th>
<th>대여 시작일</th>
<th>예정 반납 일</th>
<th>대여 가능일까지</th>
<th>대여  / 예약취소</th>
</tr>
<c:forEach items="${info.bvoList }" var="boo" >
<tr id="boo${boo.num}">
<td><a href="<c:url value="/book/read?bnum=${boo.booknum }"/>">${boo.bookname}</a></td>
<c:choose>
<c:when test="${!boo.ok }">
<td>${boo.rendate }</td>
<td>${boo.returndate }</td>
<td>${boo.day }</td>
<td><a href="javascript:cancel(${boo.num });">예약취소</a></td>
</c:when>
<c:otherwise>
<td colspan="3">대여가능합니다.</td>
<td>
<a href="javascript:rental(${boo.booknum },${boo.num});">대여</a> /
<a  href="javascript:cancel(${boo.num });">취소</a>
</td>
</c:otherwise>
</c:choose>
</tr>
</c:forEach>
</table>
</div>
<div class="panel panel-default">
<div class="panel-body">
<ul class="list-inline" style="text-align: center;">
  <li><a class="link" href="<c:url value="/"/>">&bull; 메인</a></li><li>
  <li></li>
  <li><a class="link" href="<c:url value="/user/edit?id=${id}"/>">&bull;정보수정</a></li>
  <li></li>
  <li><a class="link" href="#secessionModal" data-toggle="modal">&bull;회원탈퇴</a></li>
</ul>
</div>
</div>
</div>
</div>
</div>
</div>
</section>
<!-- 탈퇴 모달 -->
<div class="modal fade" id="secessionModal" tabindex="-1"  aria-labelledby="myModalLabel" aria-hidden="true">
<div class="modal-dialog">
<div class="modal-content">
<div class="modal-header">
<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
<h4 class="modal-title" id="secessionModalLabel">탈퇴 하실건가요?</h4>
</div>
<div class="modal-body">
<div class="form-group">
 탈퇴를 원하시면 비밀번호를 입력해주세요.
</div>
<div class="form-group">
<label for="pwd" class="col-sm-2 control-label">Password</label>
<div class="col-sm-10">
<input type="password" class="form-control" id="secessionPwd">
</div>
</div>
<br>
</div>
<div class="modal-footer">
<button type="button"  class="btn btn-success" onclick="secession();">탈퇴</button>
<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
</div>
</div>
</div>
</div>	
<!--결과 모달  -->
<div class="modal fade" id="resultModal" tabindex="-1"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body" id="resultModalBody">
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
	
<!--탈퇴 폼  -->	
<form  id="seceForm" > 
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
<input type="hidden" name="userid" value="${info.vo.userid }">
<input type="hidden" name="upwd">
</form>
<!--반납  -->
<form  id="returnForm">
<input type="hidden" name="${_csrf.parameterName }"	value="${_csrf.token }">
<input type="hidden" name="num">
<input type="hidden" name="userid" value="${id }">
</form>
<!--예약도서 렌탈  -->
<form  id="rentalForm">
<input type="hidden" name="${_csrf.parameterName }"	value="${_csrf.token }">
<input type="hidden" name="booknum">
<input type="hidden" name="bookingnum">
<input type="hidden" name="userid" value="${id }">
</form>
<!--예약 취소  -->
<form  id="cancelForm">
<input type="hidden" name="${_csrf.parameterName }"	value="${_csrf.token }">
<input type="hidden" name="num">
</form>
<!--로그아웃  -->
<form action="<c:url value="/logout"/>" method="post" id="logout">
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
</form>
</body>
</html>