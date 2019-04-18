<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ page import="java.util.*" %>

<link href="resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="resources/css/modern-business.css" rel="stylesheet">

<div class="container">

<div class="jumbotron">
      <h1 class="display-1">404</h1>
      <h2><c:out value="${msg}"/></h2>
      <h2><c:out value="${SPRING_SECURITY_403_EXCEPTION.getMessage()}"/></h2>
      <br><br>
      <ul>
        <li>
          <a href="/haengbok">홈</a>
        </li>
        <li>
          <a href="javascript:history.back();">이전페이지</a>
        </li>
      </ul>
    </div>

</div>
