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
        	<a href="#" class="list-group-item active">나의 서재</a>
          <a href="changepw" class="list-group-item">비밀번호 변경</a>
          <a href="leavemember" class="list-group-item">회원 탈퇴</a>
          
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
                    <th>책 번호</th>
                    <th>책 제목</th>
                    <th>대출일</th>
                    <th>반납 예정일</th>
                  </tr>
                </thead>
                <c:forEach items="${list }" var="borrow">
                
                <tbody>
                  <tr>
                    <td><c:out value="${borrow.ebookNo }"/></td>
                    <td><a href="/haengbok/ebook/details?ebookNo=<c:out value="${borrow.ebookNo }"/>"><c:out value="${borrow.ebookTitle }"/></a></td>
                    <td><fmt:formatDate pattern="yyyy-MM-dd" value="${borrow.regdate }"/></td>
                    <td><fmt:formatDate pattern="yyyy-MM-dd" value="${borrow.deadline }"/></td>
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