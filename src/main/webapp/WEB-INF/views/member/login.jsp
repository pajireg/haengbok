<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../includes/header.jsp" %>

  <div class="container">
  
  <ol class="breadcrumb mt-4">
      <li class="breadcrumb-item">
        <a href="/haengbok">홈</a>
      </li>
      <li class="breadcrumb-item active">로그인</li>
    </ol>
    
    <div class="row mt-4">
      <div class="col-lg-3 mb-4 smallhide">
        <div class="list-group">
          <a href="/haengbok/member/login" class="list-group-item active">로그인</a>
          <a href="/haengbok/member/signup" class="list-group-item">회원가입</a>
          
        </div>
      </div>
    
    <div class="col-lg-9 mb-4">
  
    <div class="card card-login mx-auto">
      <div class="card-header">로그인 </div>
      <div class="card-body">
        <form id="loginform" action="/haengbok/login" method="post">
          <div class="form-group">
            <div class="form-label-group">
              <input type="text" name="username" id="inputId" class="form-control" placeholder="아이디" required="required" autofocus="autofocus">
              <label for="inputId">아이디 입력</label>
            </div>
          </div>
          <div class="form-group">
            <div class="form-label-group">
              <input type="password" name="password" id="inputPassword" class="form-control" placeholder="비밀번호" required="required">
              <label for="inputPassword">비밀번호 입력</label>
            </div>
          </div>
          <div class="form-group">
            <div class="checkbox">
              <label>
                <input type="checkbox" name="remember-me"> 자동 로그인
              </label>
            </div>
          </div>
          <input type="submit" class="btn btn-primary btn-block" value="로그인">
          <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        </form>
        <div class="text-center">
          <a class="d-block small mt-3" href="/haengbok/member/signup">회원가입</a>
          <a class="d-block small" href="/haengbok/member/findid">아이디를 잊으셨나요?</a>
          <a class="d-block small" href="/haengbok/member/findpw">비밀번호를 잊으셨나요?</a>
        </div>
      </div>
    </div>
    
    </div>
    </div>
  </div>


<script type="text/javascript">
$(document).ready(function(){
	var error = '<c:out value="${error}"/>';
	if(error != ''){
		alert(error);
	}
	var signup = '<c:out value="${signup}"/>';
	if(signup != ''){
		alert(signup + "로그인 후 이용해 주세요.");
	}
});
</script>


<%@ include file="../includes/footer.jsp" %>
