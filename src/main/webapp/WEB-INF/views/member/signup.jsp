<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>
<script>
$(document).ready(function(){
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
		
	var checked = 0;
	var checkedemail = 0, checkedcode = 0;
	$(function() {
	    $("#checkid").click(function() {
	        var userid =  $("#userid").val(); 
	        if(userid.length > 5 && userid.length < 13 && isNaN($("#userid").val())){
		        $.ajax({
		            async: true,
		            type : 'POST',
		            data : userid,
					beforeSend : function(xhr){
						xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
					},
		            url : "/haengbok/member/checkid",
		            dataType : "json",
		            contentType: "application/json; charset=UTF-8",
		            success : function(data) {
		                if (data.count > 0) {
		                    alert("아이디가 존재합니다. 다른 아이디를 입력해주세요.");
		                    document.getElementById("userid").className = "form-control is-invalid";
		                    $("#userid").focus();
		                } else {
		                    alert("사용가능한 아이디입니다.");
		                    $("#useremail").focus();
		                    checked = 1;
		                }
		            },
		            error : function(error) {
		                alert("error : " + error);
		            }
		        });
	        }else{
	        	alert("6자 이상 12자 이하, 특수문자 불가");
	        	document.getElementById("userid").className = "form-control is-invalid";
	        	$("#userid").focus();
	        }
	    });
	});
	$(function() {
	    $("#checkemail").click(function() {
	        var useremail =  $("#useremail").val(); 
	        var emailRule = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	        if(!emailRule.test(useremail)) {
	            alert("올바른 이메일 형식이 아닙니다.");
	            document.getElementById("useremail").className = "form-control is-invalid";
	            $("#useremail").focus();
	            return false;
			}else{
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
		                if (data.count > 0) {
		                    alert("동일한 이메일주소가 존재합니다. 다른 이메일주소를 입력해주세요.");
		                    document.getElementById("useremail").className = "form-control is-invalid";
		                    $("#useremail").focus();
		                } else {
		                    alert("발송된 인증코드를 아래 입력해 주시기 바랍니다.");
		                    document.getElementById("useremail").className = "form-control is-valid";
		                    sendcode(useremail);
		                    $("#emailcode").focus();
		                    checkedemail = 1;
		                }
		            },
		            error : function(error) {
		                alert("error : " + error);
		            }
		        });
			}
	    });
	});
	function sendcode(useremail){
		console.log(useremail);
		$.ajax({
			url : "/haengbok/member/sendcode",
			beforeSend : function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			type : 'POST',
            data : useremail,
            dataType : "json",
            contentType: "application/json; charset=UTF-8",
            success : function(data){
            	console.log(data.authcode);
            	$("#checkcode").click(function() {
            		var emailcode = $("#emailcode").val();
        			if(emailcode == data.authcode){
        				alert("인증번호가 확인 되셨습니다.");
        				document.getElementById("emailcode").className = "form-control is-valid";
        				$("#inputPassword").focus();
        				checkedcode = 1;
        			}else{
        				alert("인증번호가 맞지 않습니다.");
        				document.getElementById("emailcode").className = "form-control is-invalid";
        			}
        		});
            },
            error : function(error) {
                alert("error : " + error);
            }
		});
	}
/* 	function checkcode(authcode){
		
	} */
	var confirm1 = 0, confirm2 = 1, confirm3 = 0, confirm4 = 0;
	$("#userid").keyup(function(e){
		checked = 0;
		var userid = $("#userid").val();	
		var num = "{}[]()<>?|`~'!@#$%^&*-+=,.;:\"'\\/ ";
		for(var i = 0; i<userid.length; i++){
			if(num.indexOf(userid.charAt(i)) != -1){
				document.getElementById("userid").className = "form-control is-invalid";
				confirm1 = 0;
			}
		}
		if(userid.length > 5 && userid.length < 13 && isNaN($("#userid").val())){
			document.getElementById("userid").className = "form-control is-valid";
			confirm1 = 1;
				for(var i = 0; i<userid.length; i++){
					if(num.indexOf(userid.charAt(i)) != -1){
						document.getElementById("userid").className = "form-control is-invalid";
						confirm1 = 0;
					}
				}
			
		}else{
			document.getElementById("userid").className = "form-control is-invalid";
			confirm1 = 0;
		}
		$(this).val( $(this).val().replace( /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/g, '' ) );
	});
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
		if(result == 4 && checked == 1 && checkedemail == 1 && checkedcode == 1){
			formObj.submit();
		}else if(checked == 0){
			alert("아이디 중복확인을 해주세요.");
		}else if(checkedemail == 0){
			alert("이메일 인증을 해주세요.");
		}else if(checkedcode == 0){
			alert("인증번호 확인을 해주세요.");
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
      <li class="breadcrumb-item active">회원가입</li>
    </ol>
    
    <div class="row mt-4">
      <div class="col-lg-3 mb-4 smallhide">
        <div class="list-group">
        	<a href="/haengbok/member/login" class="list-group-item">로그인</a>
          <a href="/haengbok/member/signup" class="list-group-item active">회원가입</a>
          
        </div>
      </div>
    
    <div class="col-lg-9 mb-4">
    
    <div class="card card-register mx-auto">
      <div class="card-header">간단한 계정등록</div>
      <div class="card-body">
        <form id="signupform" action="/haengbok/member/signup" method="post">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
          <div class="form-group">
            <div class="form-row">
              <div class="col">
            	<div class="form-label-group">
              		<input type="text" id="userid" name="userid" class="form-control" placeholder="아이디" required="required" autofocus="autofocus">
              		<label for="userid">아이디 입력</label>
            	</div>
          	  </div>
              <div class="col" style="max-width:120.39px;">
              	<button type="button" id="checkid" class="btn btn-secondary" style="width:110.39px;height:50px;">중복확인</button>
              </div>
            </div>
            <label id="useridlabel"><small>&nbsp;6자 이상 12자 이하, 특수문자 불가</small></label>
          </div>
          <div class="form-group">
            <div class="form-row">
              <div class="col">
                <div class="form-label-group">
                  <input type="email" id="useremail" name="useremail" class="form-control" placeholder="Email address" required="required">
                  <label for="useremail">이메일 입력</label>
                </div>
              </div>
              <div class="col" style="max-width:120.39px;">
              	<button type="button" id="checkemail" class="btn btn-secondary" style="height:50px;">이메일 인증</button>
              </div>
            </div>
            <label><small>&nbsp;아이디 또는 비밀번호 분실시 사용됩니다.</small></label>
          <div class="form-group">
            <div class="form-row">
              <div class="col">
                <div class="form-label-group">
                  <input type="text" id="emailcode" name="emailcode" class="form-control" placeholder="emailcode" required="required">
                  <label for="emailcode">인증번호 입력</label>
                </div>
              </div>
              <div class="col" style="max-width:136.39px;">
              	<button type="button" id="checkcode" class="btn btn-secondary" style="height:50px;">인증번호 확인</button>
              </div>
            </div>
          </div>
          </div>
			<div style="height:1rem;"></div>
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
          <button type="submit" class="btn btn-primary btn-block" style="height:50px;">회원가입</button>
        </form>
        <div class="text-center">
          <a class="d-block small mt-3" href="/haengbok/member/login">로그인 페이지</a>
          <a class="d-block small" href="/haengbok/member/findid">아이디를 잊으셨나요?</a>
          <a class="d-block small" href="/haengbok/member/findpw">비밀번호를 잊으셨나요?</a>
        </div>
      </div>
    </div>
    </div>
    </div>
  </div>

<%@ include file="../includes/footer.jsp" %>