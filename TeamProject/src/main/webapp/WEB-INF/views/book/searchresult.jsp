<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>검색결과</title>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="<c:url value="/resources/jquery.bootpag.min.js" />"></script>
<link href="<c:url value='/resources/assets/css/bootstrap.css'/>" rel="stylesheet" />
<link href="<c:url value='/resources/assets/css/bootstrap-theme.css'/>" rel="stylesheet" />
<link href="<c:url value='/resources/assets/css/style.css'/>" rel="stylesheet" />
<link rel="stylesheet" href="<c:url value='/resources/assets/color/default.css'/>">
<script src="<c:url value='/resources/assets/js/bootstrap.js'/>"></script>

<script>
$(function(){
	if(${book.tpg!=null}){
		$('#pageNav').bootpag({
	        total: "${book.tpg}",      
	        page:  "${book.page}",           
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
	    	var param ={};
	    	param.page = num;
	    	param.${_csrf.parameterName } = '${_csrf.token }';
	    	param.category = '${category}';
	    	param.keyword = '${keyword}';
	    	$.ajax({
	    		url : "searchPage",
	    		method : "post",
	    		data : param,
	    		dataType : "json",
	    		success : function(res){
	    			$("#result").empty();
	    			for(var i=0;i<res.length;i++){
	    				var table = $("<table class='table table-striped table-hover'></table>");
	    				var tbody = $("<tbody></tbody>");
	    				var tr =$("<tr></tr>");
	    				var td =$("<td rowspan='3'><a href='read?bnum="+res[i].bnum+"' class='thumbnail'><img"
	    						+"  src='<c:url value='/book/img?coverName="+res[i].coverName+"'/>'/>"
	    						+"</a></td>");
	    				tr.append(td);
	    				td = $("<td class='cell bname' ><a href='read?bnum="+res[i].bnum+"'>"+res[i].bname+"</a></td>");
	    				tr.append(td);
	    				tbody.append(tr);
	    				
	    				tr =$("<tr></tr>");
	    				td = $("<td class='cell author'><a href=\"javascript:clickSearch('author','"+res[i].author+"');\">"+res[i].author+"</a></td>");
	    				tr.append(td);
	    				tbody.append(tr);
	    				
	    				tr = $("<tr></tr>");
	    				td = $("<td class='cell publisher'><a href=\"javascript:clickSearch('publisher',"
	    						+"'"+res[i].publisher+"');\">"+res[i].publisher+"</a></td>");
	    				tr.append(td);
	    				tbody.append(tr);
	    				table.append(tbody);
	    				$("#result").append(table);
	    			}
	    			$(".${category}").addClass("success");
	    		},
	    		error : function(x,s,e){
	    			alert("오류!");
	    		}
	    	});
	    });
	   	$(".${category}").addClass("success");
	}
    });
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
function clickSearch(category,keyword) {
	$("#csc").val(category);
	$("#csk").val(keyword);
	$("#clickSearch").submit();
}
</script>
<style>
.cell{
	width: 550px;
	text-align: center;
	font-size: 15pt;
	
}
#pageNav{
	margin: 0px auto;
	text-align: center;
}
.table{
border-bottom: 1px solid #ddd;
}
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
					<!-- /.navbar-collapse -->
				</div>
			</div>
		</div>
	</header>
<section id="totalResult" class="section gray">
<div class="container">
	<div class="row">
		<div class="col-md-8 col-md-offset-2">
			<div class="heading">
				<h3><span>검색 결과</span></h3>
			</div>
			<br>
				<c:if test="${book==null }">
				<div class="sub-heading">
				<p>
					 해당 검색어에 해당하는 도서가 없습니다.
				</p>
			</div>
				</c:if>
				<div id="result">
				<c:forEach var="vo" items="${book.list }">
					<table class="table table-striped table-hover">
						<tr >
							<td rowspan="3">
							 <a href="read?bnum=${vo.bnum}" class="thumbnail">
     							<img src="<c:url value="/book/img?coverName=${vo.coverName}"/>" />
   							 </a>
							</td>
							<td class="cell bname" ><a href="read?bnum=${vo.bnum}">${vo.bname }</a></td>
						</tr>
						<tr>
							<td class="cell author"><a href="javascript:clickSearch('author','${vo.author }');">${vo.author }</a></td>
						</tr>
						<tr> 
							<td class="cell publisher"><a href="javascript:clickSearch('publisher','${vo.publisher }');">${vo.publisher }</a></td>
						</tr>
					</table>
				</c:forEach>
			</div>
				<div id="pageNav"></div>
		</div>
	</div>
</div>
</section>
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
		<input type="hidden" name="${_csrf.parameterName }"
			value="${_csrf.token }">
	</form>
</body>
</html>