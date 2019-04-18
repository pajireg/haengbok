<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ include file="../includes/header.jsp" %>
<style>
.replies pre{
white-space: pre-wrap;
}
</style>

<script type="text/javascript" src="../resources/js/ebookReply.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	var ebookNoValue = '<c:out value="${ebook.ebookNo}"/>';
	var replyUL = $(".replies");

	showList(1);
	
	function showList(page){
		ebookReplyService.getList({ebookNo : ebookNoValue, page : page || 1},
			function(list){
				var str="";
				if(list == null || list.length == 0){
					replyUL.html("");
					return;
				}
				for(var i = 0, len = list.length || 0; i < len; i++){
					str += "<li style='list-style:none;'><div class='media mb-4'><img class='d-flex mr-3 rounded-circle' src='../resources/icons/baseline_account_circle_black_18dp.png'>";
			        str += "<div class='media-body'><h6 class='mt-0'>"+list[i].replyer+" <small>"+ebookReplyService.displayTime(list[i].regdate)+"</small>";
			        str += "<img class='modify' data-replyno='"+list[i].replyNo+"' style='cursor:pointer' src='../resources/icons/baseline_more_horiz_black_18dp.png'>";
			        str += "</h6><pre>"+list[i].replytext+"</pre></div></div></li>";
				}
				replyUL.html(str);
			});
	}
	var modal = $(".modal");
	var modalInputReply = modal.find("textarea[name='replytext']");
	var modalInputReplyer = modal.find("input[name='replyer']");
	var modalInputReplyDate = modal.find("input[name='regdate']");
	
	var modalModBtn = $("#modalModBtn");
 	var modalRemoveBtn = $("#modalRemoveBtn");
 	var modalRegisterBtn = $("#modalRegisterBtn");
 	
 	var replyer = null;
 	<sec:authorize access="isAuthenticated()">
 		replyer = '<sec:authentication property="principal.username"/>';
 	</sec:authorize>
 	
 	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	$(document).ajaxSend(function(e, xhr, options){
		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	});

	
 	var addReply = $(".addReply");
 	var addReplytext = addReply.find("textarea[name='replytext']");
 	var addReplyer = addReply.find("input[name='replyer']");
	$(".addReplyDeny").on("click", function(e){
		alert("로그인 후 작성 가능합니다.");
	});
 	$("#addReplyBtn").on("click", function(e){
 		if(addReplytext.val() == ''){
 			alert("내용 작성 후 제출 가능합니다.")
 			return;
 		}else{
	 		var reply = {
	 				replyer : addReplyer.val(),
	 				replytext : addReplytext.val(),
	 				ebookNo : ebookNoValue
	 		};
	 		console.log(reply);
	 		ebookReplyService.add(reply, function(result){
	 			addReplytext.val("");
	 			showList(1);
	 		});
 		}
 	});
/*   	$(".replies").on("click", ".delete", function(e){
 		var replyNo = $(this).data("replyno");
 		console.log("replyNo : " + replyNo);
 		
 		if(!replyer){
 			alert("로그인 후 삭제가 가능합니다.");
 			return;
 		}
 		var originalReplyer = modalInputReplyer.val();
 		console.log("Original Replyer : " + originalReplyer);
 		console.log("sec:replyer : " + replyer);
 		
 		if(replyer != originalReplyer){
 			alert("자신이 작성한 댓글만 삭제가 가능합니다.");
 			modal.modal("hide");
 			return;
 		}
 		
 		ebookReplyService.remove(replyNo, originalReplyer, function(result){
 			showList(1);
 		});
 	}); */
   	$(".replies").on("click", ".modify", function(e){
 		var replyNo = $(this).data("replyno");
 		ebookReplyService.get(replyNo, function(reply){
 			modalInputReply.val(reply.replytext);
 			modalInputReplyer.val(reply.replyer).attr("readonly", "readonly");
 			modalInputReplyDate.val(reply.regdate).attr("readonly", "readonly");
 			modal.data("replyNo", reply.replyNo);
 			
 			modal.find("button[id != 'modalCloseBtn']").hide();
 			modalModBtn.show();
 			modalRemoveBtn.show();
 			
 			$("#replyModal").modal("show");
 		});
 	});
	 	modalModBtn.on("click", function(e){
	 		var replyNo = modal.data("replyNo");
	 		var reply = {replyNo : replyNo, replytext : modalInputReply.val()};
	 		
	 		if(!replyer){
	 			alert("로그인 후 수정 가능합니다.");
	 			return;
	 		}
	 		var originalReplyer = modalInputReplyer.val();
	 		console.log("Original Replyer : " + originalReplyer);
	 		console.log("sec:replyer : " + replyer);
	 		
	 		if(replyer != originalReplyer){
	 			alert("자신이 작성한 댓글만 수정 가능합니다.");
	 			modal.modal("hide");
	 			return;
	 		}
	 		
	 		ebookReplyService.update(reply, function(result){
	 			//alert(result);
	 			modal.modal("hide");
	 			showList(1);
	 		});
	 	});
	 	modalRemoveBtn.on("click", function(e){
	 		var replyNo = modal.data("replyNo");
	 		console.log("replyNo : " + replyNo);
	 		
	 		if(!replyer){
	 			alert("로그인 후 삭제가 가능합니다.");
	 			return;
	 		}
	 		var originalReplyer = modalInputReplyer.val();
	 		console.log("Original Replyer : " + originalReplyer);
	 		console.log("sec:replyer : " + replyer);
	 		
	 		if(replyer != originalReplyer){
	 			alert("자신이 작성한 댓글만 삭제가 가능합니다.");
	 			modal.modal("hide");
	 			return;
	 		}
	 		
	 		ebookReplyService.remove(replyNo, function(result){
	 			modal.modal("hide");
	 			showList(1);
	 		});
	 	});
});

</script>
<script>
$(document).ready(function(){
	(function(){
		var ebookNo = '<c:out value="${ebook.ebookNo }"/>';
		console.log("test 1 : " + ebookNo);
		$.getJSON("/haengbok/ebook/getAttachList", {ebookNo : ebookNo}, function(arr){
			console.log(arr);
			var str = "";
			
			$(arr).each(function(i, attach){
				
		         if(attach.fileType){
		           var fileCallPath =  encodeURIComponent( attach.uploadPath+ "/s_"+attach.uuid +"_"+attach.fileName);
		           str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
		           str += "<img src='/haengbok/display?fileName="+fileCallPath+"'>";
		           str += "</div>";
		           str += "</li>";
		         }else{
		           str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
		           str += "<span> "+ attach.fileName+"</span><br/>";
		           str += "<img src='/resources/img/attach.png'></a>";
		           str += "</div>";
		           str += "</li>";
		         }
			});
			$(".uploadResult ul").html(str);
		});
	})();
	
	  $(".uploadResult").on("click","li", function(e){
	      
		    console.log("view image");
		    
		    var liObj = $(this);
		    
		    var path = encodeURIComponent(liObj.data("path")+"/" + liObj.data("uuid")+"_" + liObj.data("filename"));
		    
		    if(liObj.data("type")){
		      showImage(path.replace(new RegExp(/\\/g),"/"));
		    }else {		      
		      self.location ="/haengbok/download?fileName="+path
		    }
		    
		});
		  
		  function showImage(fileCallPath){
			    
		    //alert(fileCallPath);
		    
		    $(".bigPictureWrapper").css("display","flex").show();
		    
		    $(".bigPicture")
		    .html("<img src='/haengbok/display?fileName="+fileCallPath+"' >")
		    /* .animate({width:'100%', height: '100%'}, 300) */;
		    
		  }

		  $(".bigPictureWrapper").on("click", function(e){
		    /* $(".bigPicture").animate({width:'0%', height: '0%'}, 1000);
		    setTimeout(function(){ */
		      $('.bigPictureWrapper').hide();
		    /* }, 200); */

		  });
});
</script>


  <!-- Page Content -->
  <div class="container">

  <form role="form" action="/haengbok/ebook/remove" method="post">
  	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	<input type="hidden" name="ebookNo" value="<c:out value="${ebook.ebookNo }"/>">
	<input type="hidden" name="ebookAuthor" value="<c:out value="${ebook.ebookAuthor}"/>">
    <!-- Page Heading/Breadcrumbs -->
    <h1 class="mt-4 mb-3"><c:out value="${ebook.ebookTitle}"/>
    </h1>

    <ol class="breadcrumb d-flex justify-content-between bd-highlight mb-3">
      <li class="breadcrumb-item">
        <a href="/haengbok/ebook/list?sort=${sort }&type=${cri.type }&keyword=${cri.keyword }&pageNum=${cri.pageNum }"><button type="button" class="btn btn-breadcrumb">목록</button></a>
      </li>
      <sec:authentication property="principal" var="pinfo"/>
      <sec:authorize access="isAuthenticated()">
      <c:if test="${pinfo.username eq ebook.ebookAuthor }">
      <li>
      <a href="/haengbok/ebook/modify?sort=${sort }&type=${cri.type }&keyword=${cri.keyword }&pageNum=${cri.pageNum }&ebookNo=<c:out value="${ebook.ebookNo}"/>">
      	<button type="button" class="btn btn-secondary">수정</button>
      </a>
	  <button type="submit" class="btn btn-danger">삭제</button>
      </li>
      </c:if>
      </sec:authorize>
    </ol>
  </form>
    <div class="row">

      <!-- Post Content Column -->
      <div class="col-lg-8">

	  <form id="borrowform" action="" method="post">
	  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	  <input type="hidden" name="ebookNo" value="<c:out value="${ebook.ebookNo }"/>">
	  <sec:authorize access="isAuthenticated()">
	  <input type="hidden" name="userid" value="<sec:authentication property="principal.username"/>">
	  </sec:authorize>
	  <sec:authorize access="isAnonymous()">
	  <input type="hidden" name="userid" value="guest">
	  </sec:authorize>
	  <div class="row mb-3">
        <!-- Preview Image -->
        <!-- <img class="img-fluid rounded" src="http://placehold.it/900x300" alt=""> -->
		<div class="uploadResult col-lg-4">
			<ul>
			
			</ul>
		</div>
		
		<div class="col-lg-8">
			<small>
					대출가능 : <c:out value="${ebook.quantity }"/>
					<br>
					좋아요 : <c:out value="${ebook.liked }"/>
			</small>
		</div>
	  </div>
    	<ol class="breadcrumb d-flex justify-content-between bd-highlight mb-3">
    		<li></li>
      		<li class="breadcrumb-item">
        		<button type="submit" data-oper="borrow" class="btn btn-info">대출하기</button>
        		<button type="submit" data-oper="like" class="btn btn-danger">좋아요</button>
      		</li>
      		<li></li>
      	</ol>
        <hr>

        <!-- Date/Time -->
        <p><fmt:formatDate type="both" value="${ebook.ebookRegdate }"/></p>
        <hr>

        <!-- Post Content -->
        <pre style="font-size:11px;"><c:out value="${ebook.ebookDetails}"/></pre>
		
        <hr>

      	
      	</form>
      	
        <!-- Comments Form -->
        <div class="card my-4">
          <h5 class="card-header d-flex justify-content-between bd-highlight mb-3">평점 남기기:
		  </h5>

          <div class="card-body">
            <div class="addReply">
              
              <sec:authorize access="isAnonymous()">
              <div class="form-group">
                <textarea name="replytext" class="form-control addReplyDeny" rows="3" placeholder="로그인 후 작성 가능합니다."></textarea>
              </div>
              <button type="button" class="btn btn-secondary addReplyDeny">작성</button>
              </sec:authorize>
              <sec:authorize access="isAuthenticated()">
              <input type="hidden" name="replyer" value='<sec:authentication property="principal.username"/>'>
              <input type="hidden" name="regdate" value="2019-00-00 00:00">
              <div class="form-group">
                <textarea id="replytextarea" name="replytext" class="form-control" rows="3" placeholder="의견을 작성해 주세요."></textarea>
              </div>
              <button type="button" id="addReplyBtn" class="btn btn-secondary">작성</button>
              </sec:authorize>
            </div>
          </div>
        </div>

        <!-- Single Comment -->
        <ul class="replies" style="padding-left:10px">
        <li style="list-style:none">
	        <div class="media mb-4">
	          <img class="d-flex mr-3 rounded-circle" src="http://placehold.it/50x50" alt="">
	          <div class="media-body">
	            <h5 class="mt-0">댓글 오류</h5>
	            	댓글 불러오지 못함ㅜㅜ
	          </div>
	        </div>
        </li>
        </ul>


      </div>

<!-- Modal -->
<div class="modal fade" id="replyModal" tabindex="-1" role="dialog" aria-labelledby="replyModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="replyModalLabel">댓글 수정</h4>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<label>작성자</label>
					<input class="form-control" name="replyer" value="replyer">
				</div>
				<div class="form-group">
					<label>댓글</label>
					<textarea class="form-control" name="replytext" rows="4"></textarea>
				</div>
				<div class="form-group">
					<input type="hidden" class="form-control" name="regdate" value="2019-00-00 00:00">
				</div>
			</div>
			<div class="modal-footer">
				<button id="modalRemoveBtn" type="button" class="btn btn-danger">삭제</button>
				<button id="modalModBtn" type="button" class="btn btn-secondary">수정</button>
				<button id="modalRegisterBtn" type="button" class="btn btn-primary">등록</button>
				<button id="modalCloseBtn" type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- /.Modal -->

      <!-- Sidebar Widgets Column -->
      <div class="col-lg-4">

        <!-- Search Widget -->
        <div class="card mb-4">
          <h5 class="card-header">검색</h5>
          <div class="card-body">
    		<form id="searchForm" action="/haengbok/ebook/list" method="get">
           	<div class="input-group">
           		<input type="hidden" name="sort" value="">
           		<input type="hidden" name="type" value="TDA">
           		<input type="text" name="keyword" class="form-control" placeholder="검색..." value="${cri.keyword }"/>
           		<input type="hidden" name="pageNum" value="${cri.pageNum }">
           		<span class="input-group-btn">
               	<button class="btn btn-secondary" type="button">검색!</button>
           		</span>
           	</div>
           	</form>
        </div>
        </div>
<!--

        <div class="card my-4">
          <h5 class="card-header">카테고리</h5>
          <div class="card-body">
            <div class="row">
              <div class="col-lg-6">
                <ul class="list-unstyled mb-0">
                  <li>
                    <a href="#">Web Design</a>
                  </li>
                  <li>
                    <a href="#">HTML</a>
                  </li>
                  <li>
                    <a href="#">Freebies</a>
                  </li>
                </ul>
              </div>
              <div class="col-lg-6">
                <ul class="list-unstyled mb-0">
                  <li>
                    <a href="#">JavaScript</a>
                  </li>
                  <li>
                    <a href="#">CSS</a>
                  </li>
                  <li>
                    <a href="#">Tutorials</a>
                  </li>
                </ul>
              </div>
            </div>
          </div>
        </div>


        <div class="card my-4">
          <h5 class="card-header">사이드 위젯</h5>
          <div class="card-body">
           	 동해물과 백두산이 마르고 닳도록
          </div>
        </div>
-->
      </div>

    </div>
    <!-- /.row -->

  </div>
  <!-- /.container -->
<div class='bigPictureWrapper'>
			<div class='bigPicture'>
			</div>
		</div>
<!-- Modal  추가 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<!-- <div class="modal-header">
				<h4 class="modal-title" id="myModalLabel">Modal title</h4>
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			</div> -->
			<div class="modal-body"></div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- /.modal -->

<script type="text/javascript">
	$(document).ready(function() {
		var register = '<c:out value="${register}"/>';
		var modify = '<c:out value="${modify}"/>';
		var borrow = '<c:out value="${borrow}"/>';
		var result = '';
		var str = '';
		if(parseInt(register) > 0){
			result = register;
			str = ' 번이 등록되었습니다.';
		}else if(parseInt(modify) > 0){
			result = modify;
			str = ' 번이 수정되었습니다.';
		}else if(borrow != ''){
			result = borrow;
		}
		checkModal(result);
		history.replaceState({},null,null);
		function checkModal(result) {
			if (result === '' || history.state) {
				return;
			}
			if (parseInt(result) > 0 || result != '') {
				$(".modal-body").html(result + str);
			}
			$("#myModal").modal("show");
		}
		
		var searchForm = $("#searchForm");
		$("#searchForm button").on("click", function(e){
			if(!searchForm.find("input[name='keyword']").val()){
				alert("검색어를 입력하세요.");
				return false;
			}
			searchForm.find("input[name='pageNum']").val("0");
			e.preventDefault();
			searchForm.submit();
		});
		var borrowForm = $("#borrowform");
		$("#borrowform button").on("click", function(e){
			e.preventDefault();
			var operation = $(this).data("oper");
			console.log(operation);
			if(borrowForm.find("input[name='userid']").val() == 'guest'){
				alert("로그인 후 이용 가능합니다.");
				return false;
			}else{
				if(operation === "borrow"){
					borrowForm.attr("action", "/haengbok/ebook/borrow");
				}else if(operation === "like"){
					borrowForm.attr("action", "/haengbok/ebook/like");
				}
			}
			borrowForm.submit();
		});
	});
</script>

  <%@ include file="../includes/footer.jsp"%>