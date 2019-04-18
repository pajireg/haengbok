<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>

  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>행복도서관</title>

  <!-- Bootstrap core CSS -->
  <link href="../resources/vendor/bootstrap/css/bootstrap.css" rel="stylesheet">

  <!-- Custom styles for this template -->
  <link href="../resources/css/modern-business.css" rel="stylesheet">
  <!-- Custom styles for this template-->
  <!-- <link href="../resources/css/sb-admin.css" rel="stylesheet"> -->
  
  <link href="../resources/css/img_attach.css" rel="stylesheet">
  <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
</head>
<style>
body{
display: flex;
  min-height: 100vh;
  flex-direction: column;
}
.container{
flex: 1;
}
</style>
<body>

  <!-- Navigation -->
  <nav class="navbar fixed-top navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container">
      <a class="navbar-brand" href="/haengbok">행복도서관</a>
      <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarResponsive">
        <ul class="navbar-nav ml-auto">
          <li class="nav-item">
            <a class="nav-link" href="/haengbok/ebook/list?sort=recent">전자도서관</a>
          </li>
          <sec:authorize access="isAnonymous()">
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownBlog" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              	로그인
            </a>
            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdownBlog">
              <a class="dropdown-item" href="/haengbok/member/login">로그인</a>
              <a class="dropdown-item" href="/haengbok/member/signup">회원가입</a>
            </div>
          </li>
          </sec:authorize>
          <sec:authentication property="principal" var="pinfo"/>
          <sec:authorize access="isAuthenticated()">

          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownBlog" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              	<sec:authentication property="principal.username"/>
            </a>
            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdownBlog">
            <c:choose>
              <c:when test="${pinfo.username eq 'admin' }">
				<a class="dropdown-item" href="/haengbok/admin/userinfo">회원 리스트</a>
				<a class="dropdown-item" href="/haengbok/admin/borrowinfo">대출 정보</a>
	      	  </c:when>
	      	  <c:otherwise>
	      	    <a class="dropdown-item" href="/haengbok/member/mybooks?userid=<sec:authentication property="principal.username"/>">나의 서재</a>
                <a class="dropdown-item" href="/haengbok/member/changepw">회원정보 변경</a>
	      	  </c:otherwise>
            </c:choose>
              <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">로그아웃</a>
            </div>
          </li>
          </sec:authorize>
        </ul>
      </div>
    </div>
  </nav>
  
  