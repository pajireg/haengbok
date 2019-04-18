<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>
  
  <script type="text/javascript">
  $(document).ready(function(){
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	  var formObj = $("#sendemail");
	  $("button[type='submit']").on("click", function(e){
		  e.preventDefault();
		  var useremail = $("#inputEmail").val();
		  $.ajax({
		      async: true,
		      type : 'POST',
		      data : useremail,
				beforeSend : function(xhr){
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
		      url : "/haengbok/member/checkemail",
		      dataType : "json",
		      contentType: "application/json; charset=UTF-8",
		      success : function(data) {
		          if(data.count == 0) {
		              alert("존재하지 않는 이메일주소 입니다.");
		              document.getElementById("inputEmail").className = "form-control is-invalid";
		              $("#inputEmail").focus();
		          }else if(data.count == 1) {
		              document.getElementById("inputEmail").className = "form-control is-valid";
		              alert("이메일 주소로 아이디를 보내드렸습니다.");
		              formObj.submit();
		          }else{
		        	  alert("오류발생");
		          }
		      },
		      error : function(error) {
		          alert("error : " + error);
		      }
		  });
	  });

  });
  </script>
  


  <div class="container">

    <ol class="breadcrumb mt-4">
      <li class="breadcrumb-item">
        <a href="/haengbok">홈</a>
      </li>
      <li class="breadcrumb-item"><a href="/haengbok/login">로그인</a></li>
      <li class="breadcrumb-item active">아이디 찾기</li>
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
      <div class="card-header">아이디 찾기</div>
      <div class="card-body">
        <div class="text-center mb-4">
          <h4>아이디를 잊으셨나요?</h4>
          <p>가입시 등록된 이메일 주소로 아이디를 보내드립니다.</p>
        </div>
        <form id="sendemail" action="/haengbok/member/findid" method="post">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
          <div class="form-group">
            <div class="form-label-group">
              <input type="email" name="useremail" id="inputEmail" class="form-control" placeholder="Enter email address" required="required" autofocus="autofocus">
              <label for="inputEmail">이메일 주소 입력</label>
            </div>
          </div>
          <button type="submit" class="btn btn-primary btn-block">이메일 보내기</button>
        </form>
        <div class="text-center">
          <a class="d-block small mt-3" href="/haengbok/member/signup">회원가입</a>
          <a class="d-block small" href="/haengbok/member/login">로그인 페이지</a>
        </div>
      </div>
    </div>
    
    </div>
    </div>
  </div>

  <%@ include file="../includes/footer.jsp" %>

  