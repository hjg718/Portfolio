<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

<title>작성 완료</title>
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

#repleBox {
	display: none;
}
</style>
<script type="text/javascript">
	function deleteNum() {

		var param = $('#deleteForm').serialize();

		$.ajax({
			url : 'delete',
			method : 'post',
			data : param,
			dataType : 'json',
			success : function(res) {
				if (res.ok) {
					$("#infoModalBody").text("삭제되었습니다. ");
					$('#infoModal').modal('show');
					$('#infoModal').on('hidden.bs.modal', function(e) {
						location.href = "list";
					});
				} else {
					$("#infoModalBody").text("댓글이 있는 글은 삭제 할 수 없습니다. ");
					$('#infoModal').modal('show');
				}
			},
			error : function(xhr, status, err) {
				alert("오류");
			}
		});

	}
	//댓글

	function saveRepl() {

		var t = $('#title').val();
		var c = $('#contents').val();

		$('#titleDiv').removeClass("has-error");
		$('#contentsDiv').removeClass("has-error");

		if (t == "" || t == null) {
			$("#infoModalBody").text("제목을 입력하세요. ");
			$('#infoModal').modal('show');
			$('#titleDiv').addClass("has-error");
			return false;
		} else if (c == "" || c == null) {
			$("#infoModalBody").text("내용을 입력하세요 .");
			$('#infoModal').modal('show');
			$('#contentsDiv').addClass("has-error");
			return false;
		}

		var param = $('#refForm').serialize();

		$
				.ajax({
					url : "boardRepl",
					method : "post",
					data : param,
					dataType : "json",
					success : function(res) {
						if (res) {
							$("#infoModalBody").text("작성하신 댓글을 정상적으로 저장했습니다.");
							$('#infoModal').modal('show');
							$('#infoModal')
									.on(
											'hidden.bs.modal',
											function(e) {
												location.href = "recent?id=<sec:authentication property='name' />";
											});
						} else {
							alert("저장 실패");
						}
					},
					error : function(xhr, status, err) {
						alert("오류");
					}
				});
		return false;
	}
	//추천
	function goodClick() {
		var param = $('#goodForm').serialize();

		$.ajax({
			url : 'good',
			method : 'post',
			data : param,
			dataType : 'json',
			success : function(res) {
				if (res.ok) {
					$("#infoModalBody").text("추천성공! ");
					$('#infoModal').modal('show');
				} else {
					$("#infoModalBody").text("이미 추천 하신 글입니다. ");
					$('#infoModal').modal('show');
				}
			},
			error : function(xhr, status, err) {
				alert("추천 오류");
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
		if (!pass) {
			$('#input').modal('show');
		}
		return pass;
	}
	function edit() {
		$("#edit").submit();
	}
	function reple() {
		$("#repleBox").toggle();
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
								<h4 class="panel-title">글 읽기</h4>
							</div>
							<div class="panel-body">
								<dl class="dl-horizontal">

									<dt>글 번호 :</dt>
									<dd>
										<p>${list.num}</p>
									</dd>
									<dt>제목 :</dt>
									<dd>
										<p>${list.title}</p>
									</dd>
									<dt>조회수 :</dt>
									<dd>
										<p>${list.readCnt}</p>
									</dd>
									<dt>추천수 :</dt>
									<dd>
										<p>${list.goodcnt}</p>
									</dd>
									<dt>작성자 :</dt>
									<dd>
										<p>${list.author}</p>
									</dd>
									<dt>작성일 :</dt>
									<dd>
										<p>${list.regdate}</p>
									</dd>
									<dt>내용 :</dt>
									<dd>
										<pre>${list.contents}</pre>
									</dd>
								</dl>
								<ul class="list-inline" style="text-align: center;">
									<li><a class="link" href="<c:url value="/board/list"/>">&bull;
											목록보기</a></li>
									<sec:authorize access="isAuthenticated()">
										<li></li>
										<li><a class="link" href="javascript:goodClick();">&bull;
												글 추천</a></li>
										<li></li>
										<li><a class="link" href="javascript:reple();">&bull;
												답글 달기</a></li>
									</sec:authorize>
									<c:choose>
										<c:when test="${id==list.author }">
											<li></li>
											<li><a class="link" href="javascript:edit();">&bull;
													글 수정</a></li>
											<li></li>
											<li><a class="link" href="javascript:deleteNum();">&bull;
													글 삭제</a></li>
										</c:when>
										<c:otherwise>
											<sec:authorize access="hasAnyAuthority('MANAGER,ADMIN')">
												<li></li>
												<li><a class="link" href="javascript:deleteNum();">&bull;
														글 삭제</a></li>
											</sec:authorize>
										</c:otherwise>
									</c:choose>
								</ul>
							</div>
						</div>
						<div id="repleBox">
							<div class="panel panel-success">
								<div class="panel-heading">
									<h4 class="panel-title">답글 달기</h4>
								</div>
								<div class="panel-body">
									<form id="refForm" class="form-horizontal">
										<!-- 댓글 -->
										<input type="hidden" name="${_csrf.parameterName }"
											value="${_csrf.token }"> <input type="hidden"
											name="ref" value="${list.num}">

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
												<textarea class="form-control" id="contents" rows="5"
													style="resize: none;" name="contents"
													placeholder="내용을 입력해주세요"></textarea>
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

										<div id="bset">
											<button type="button" onclick="saveRepl();"
												class="btn btn-theme">작성 완료</button>
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
	<!-- 추천 -->
	<form id="goodForm">
		<input type="hidden" name="${_csrf.parameterName }"
			value="${_csrf.token }"> <input type="hidden" name="num"
			value="${list.num }"> <input type="hidden" name="goodname"
			value="${id }"> <input type="hidden" name="goodnum"
			value="${list.num}"> <input type="hidden" id="goodcnt"
			name="goodcnt" value="${list.goodcnt}">
	</form>

	<!-- 삭제 -->
	<form id="deleteForm">
		<input type="hidden" name="${_csrf.parameterName }"
			value="${_csrf.token }"> <input type="hidden" name="num"
			value="${list.num }">
	</form>

	<!--수정 폼  -->
	<form action="<c:url value="/board/edit"/>" method="post" id="edit">
		<input type="hidden" name="${_csrf.parameterName }"
			value="${_csrf.token }"> <input type="hidden" name="num"
			value="${list.num }">
	</form>

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
	<div class="modal fade" id="infoModal" tabindex="-1"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body" id="infoModalBody"></div>
				<div class="modal-footer">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">확인</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
