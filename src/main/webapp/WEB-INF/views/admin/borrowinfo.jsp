<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    <%@ page import="java.util.Date" %>
<%@ include file="../includes/header.jsp" %>


<div class="container">

        <!-- Breadcrumbs-->
        <ol class="breadcrumb mt-4">
          <li class="breadcrumb-item">
            <a href="/haengbok">홈</a>
          </li>
          <li class="breadcrumb-item active">마이페이지</li>
        </ol>

	<div class="row mt-4">
      <div class="col-lg-3 mb-4 smallhide">
        <div class="list-group">
          <a href="userinfo" class="list-group-item">회원 리스트</a>
          <a href="#" class="list-group-item active">대출 정보</a>
          <a href="/haengbok/member/changepw" class="list-group-item">비밀번호 변경</a>
          
        </div>
      </div>
      <div class="col-lg-9 mb-4">

        <div class="card mb-3">
          <div class="card-header">
            <i class="fas fa-table"></i>
            	대출 목록</div>
          <div class="card-body">
            <div class="table-responsive">
              <table class="table table-bordered">
                <thead>
                  <tr>
                    <th>책번호</th>
                    <th>책이름</th>
                    <th>아이디</th>
                    <th>대출일</th>
                    <th>반납 예정일</th>
                  </tr>
                </thead>
                <c:forEach items="${list }" var="user">
                
                <tbody>
                  <tr>
                    <td><c:out value="${user.ebookNo }"/></td>
                    <td><c:out value="${user.ebookTitle }"/></td>
                    <td><c:out value="${user.userid }"/></td>
                    <td><fmt:formatDate pattern="yyyy-MM-dd" value="${user.regdate }"/></td>
                    <td><fmt:formatDate pattern="yyyy-MM-dd" value="${user.deadline }"/></td>
                  </tr>
                </tbody>
                
                </c:forEach>
              </table>
            </div>
          </div>
        </div>
	</div>
	</div>
      </div>
      <!-- /.container-fluid -->



<%@ include file="../includes/footer.jsp" %>