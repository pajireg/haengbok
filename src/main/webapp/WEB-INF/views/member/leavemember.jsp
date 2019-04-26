<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

  <div class="container">

    <ol class="breadcrumb mt-4">
      <li class="breadcrumb-item">
        <a href="/haengbok">홈</a>
      </li>
      <li class="breadcrumb-item active"><a href="#">마이페이지</a></li>
    </ol>
    
    <div class="row mt-4">
      <div class="col-lg-3 mb-4 smallhide">
        <div class="list-group">
        	<a href="mybooks" class="list-group-item">나의 서재</a>
          <a href="changepw" class="list-group-item">비밀번호 변경</a>
          <a href="#" class="list-group-item active">회원 탈퇴</a>
          
        </div>
      </div>
    
    <div class="col-lg-9 mb-4">
    
    <div class="card card-login mx-auto">
      <div class="card-header">회원탈퇴</div>
      <div class="card-body">
        <div class="text-center mb-4">
          <h4>정말 탈퇴하시겠습니까?</h4>
          <p>탈퇴시 기존의 정보는 모두 삭제됩니다.</p>
        </div>
        <form action="/haengbok/member/leavemember" method="post">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
          <div class="form-group">
            <div class="form-label-group">
				<input type="hidden" name="userid" value="<sec:authentication property="principal.username"/>">
            </div>
          </div>
          <button type="submit" class="btn btn-danger btn-block">회원탈퇴</button>
        </form>
      </div>
    </div>
    
    </div>
    </div>
  </div>

  <%@ include file="../includes/footer.jsp" %>

  