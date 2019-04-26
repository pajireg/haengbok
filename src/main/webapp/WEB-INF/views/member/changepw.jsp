<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ include file="../includes/header.jsp" %>
<script>
$(document).ready(function(){

	var confirm1 = 1, confirm2 = 1, confirm3 = 0, confirm4 = 0;

	$("#inputPassword").keyup(function(e){
		var pw_len = document.getElementById("inputPassword").value.length;
		var pw1 = $("#inputPassword").val();
		var num = "{}[]()<>?|`~'!@#$%^&*-+=,.;:\"'\\/ ";
		for(var i = 0; i<pw1.length; i++){
			if(num.indexOf(pw1.charAt(i)) != -1){
				document.getElementById("inputPassword").className = "form-control is-invalid";
				confirm3 = 0;
			}
		}
		
		if(pw_len > 5 && pw_len < 17 && isNaN($("#inputPassword").val())){
			document.getElementById("inputPassword").className = "form-control is-valid";
			confirm3 = 1;
				for(var i = 0; i<pw1.length; i++){
					if(num.indexOf(pw1.charAt(i)) != -1){
						document.getElementById("inputPassword").className = "form-control is-invalid";
						confirm3 = 0;
					}
				}
		}else{
			document.getElementById("inputPassword").className = "form-control is-invalid";
			confirm3 = 1;
		}
		$("#confirmPassword").keyup(function(e){
			if($("#confirmPassword").val() != $("#inputPassword").val()){
				document.getElementById("confirmPassword").className = "form-control is-invalid";
				confirm4 = 0;
			}else{
				document.getElementById("confirmPassword").className = "form-control is-valid";
				confirm4 = 1;
			}
		});
	});
	var formObj = $("#signupform");
	$("button[type='submit']").on("click", function(e){
		e.preventDefault();
		var result = confirm1 + confirm2 + confirm3 + confirm4;
		console.log(result);
		if(result == 4){
			formObj.submit();
		}else{
			alert("다시 입력하세요.");
		}
	});
});
</script>  


  <div class="container">
  
    <ol class="breadcrumb mt-4">
      <li class="breadcrumb-item">
        <a href="/haengbok">홈</a>
      </li>
      <li class="breadcrumb-item active">마이페이지</li>
    </ol>
    
    <div class="row mt-4">
      <div class="col-lg-3 mb-4 smallhide">
      <sec:authentication property="principal" var="pinfo"/>
      <c:choose>
        <c:when test="${pinfo.username eq 'admin' }">
        <div class="list-group">
          <a href="/haengbok/admin/userinfo" class="list-group-item">회원 리스트</a>
          <a href="/haengbok/admin/borrowinfo" class="list-group-item">대출 정보	</a>
          <a href="#" class="list-group-item active">비밀번호 변경</a>
        </div>
        </c:when>
        <c:otherwise>
        <div class="list-group">
          <a href="mybooks?userid=<sec:authentication property="principal.username"/>" class="list-group-item">나의 서재</a>
          <a href="#" class="list-group-item active">비밀번호 변경</a>
          <a href="leavemember" class="list-group-item">회원 탈퇴</a>
        </div>
        </c:otherwise>
      </c:choose>
      </div>
    
    <div class="col-lg-9 mb-4">
    
    <div class="card card-register mx-auto">
      <div class="card-header">비밀번호 변경</div>
      <div class="card-body">
        <form id="signupform" action="/haengbok/member/changepw" method="post">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
          <div class="form-group mb-4">
             <input type="hidden" style="height:50px" id="userid" name="userid" class="form-control" value="<sec:authentication property="principal.username"/>" readonly>
          </div>
<%--           <div class="form-group has-success">
            <div class="form-label-group">
              <input type="email" id="inputEmail" name="useremail" value='<c:out value="${useremail }"/>' class="form-control" placeholder="Email address" required="required">
              <label for="inputEmail">이메일 입력</label>
            </div>
            <label><small>&nbsp;아이디 또는 비밀번호 분실시 사용됩니다.</small></label>
          </div> --%>
          <div class="form-group">
            <div class="form-row">
              <div class="col-md-6">
                <div class="form-label-group">
                  <input type="password" id="inputPassword" name="userpw" class="form-control" placeholder="Password" required="required">
                  <label for="inputPassword">비밀번호 입력</label>
                </div>
                <label id="inputPasswordlabel"><small>&nbsp;영문,숫자 조합 6자 이상 16자 이하, 특수문자 불가</small></label>
              </div>
              <div class="col-md-6">
                <div class="form-label-group">
                  <input type="password" id="confirmPassword" class="form-control" placeholder="Confirm password" required="required">
                  <label for="confirmPassword">비밀번호 확인</label>
                </div>
              </div>
            </div>
          </div>
          <button type="submit" class="btn btn-primary btn-block">비밀번호 변경</button>
        </form>
 
      </div>
    </div>
    </div>
    </div>
  </div>

<%@ include file="../includes/footer.jsp" %>