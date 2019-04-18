<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ include file="../includes/header.jsp" %>

<style>


input[type=text]:-ms-clear{
    display: none;
}

#searchclear {
    position: absolute;
    right: 80px;
    top: 0;
    bottom: 0;
    height: 26px;
    margin: auto;
    cursor: pointer;
    color: #ccc;
}
#listpre {
font-size:11px;
overflow:hidden;
height:6em;
}
</style>

<!-- Page Content -->
  <div class="container">
<!-- 	<a class="scroll-to-top rounded" href="#" style="display: inline;z-index:100">
		<img class="fas fa-angle-up" src="../resources/icons/sharp_expand_less_white_18dp.png">
	</a> -->

    <!-- Page Heading/Breadcrumbs -->
<!--     <h2 class="mt-4 mb-3">요구르트
      <small>앙팡</small>
    </h2> -->

    <ol class="breadcrumb mt-4">
      <li class="breadcrumb-item">
        <a href="/haengbok">Home</a>
      </li>
      <li class="breadcrumb-item active">전자도서관</li>
      <sec:authentication property="principal" var="pinfo"/>
      <sec:authorize access="isAuthenticated()">
      <c:if test="${pinfo.username eq 'admin' }">
      <li class="breadcrumb-item">
	    <a href="/haengbok/ebook/register">등록</a>
      </li>
      </c:if>
      </sec:authorize>
    </ol>

    <div class="card mb-4">
    	<div class="card-body">
    		<form id="searchForm" action="/haengbok/ebook/list" method="get">
           	<div class="input-group">
           		<input type="hidden" name="sort" value="${sort }">
           		<input type="hidden" name="type" value="TDA">
           		<input id="searchinput" type="text" name="keyword" class="form-control" placeholder="검색..." value="${pageMaker.cri.keyword }"/>
           		<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
           		<span id="searchclear">X</span>
           		<span class="input-group-btn">
               	<button class="btn btn-secondary" type="button">검색!</button>
           		</span>
           	</div>
           	</form>
        </div>
    </div>
    
<%--     <div>
    	<div class="col-lg-12">
    		<form id="searchForm" action="/haengbok/ebook/list" method="get">
    			<select name="type">
    				<option value="" <c:out value="${pageMaker.cri.type == null ? 'selected' : ''}"/>>--</option>
    				<option value="T" <c:out value="${pageMaker.cri.type eq 'T' ? 'selected' : ''}"/>>제목</option>
    				<option value="D" <c:out value="${pageMaker.cri.type eq 'D' ? 'selected' : ''}"/>>내용</option>
    				<option value="A" <c:out value="${pageMaker.cri.type eq 'A' ? 'selected' : ''}"/>>작성자</option>
    				<option value="TD" <c:out value="${pageMaker.cri.type eq 'TD' ? 'selected' : ''}"/>>제목or내용</option>
    				<option value="TA" <c:out value="${pageMaker.cri.type eq 'TA' ? 'selected' : ''}"/>>제목or작성자</option>
    				<option value="TDA" <c:out value="${pageMaker.cri.type eq 'TDA' ? 'selected' : ''}"/>>전체</option>
    			</select>
    			<input type="text" name="keyword" value="${pageMaker.cri.keyword }"/>
    			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
    			<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
    			<button class="btn btn-secondary">검색</button>
    		</form>
    	</div>
    </div> --%>
    <div class="row">
    <!-- Sidebar Column -->
      <div class="col-lg-3 mb-4" id="accordion" role="tablist" aria-multiselectable="true">
        <div class="list-group">
          <a href="list?sort=recent" class="list-group-item ${sort == 'recent' or sort == '' ? 'active' : '' }">신작</a>
          <a href="list?sort=popular" class="list-group-item ${sort == 'popular' ? 'active' : '' }">인기순</a>
          <a href="list?sort=liked" class="list-group-item ${sort == 'liked' ? 'active' : '' }">좋아요순</a>
        </div>
      </div>
      
<div class="col-lg-9 mb-4">
<c:forEach items="${list }" var="ebook">

    <!-- Blog Post -->
    <div class="card mb-4">
      <div class="card-body">
        <div class="row">
          <div class="col-lg-4">
            
              <!-- <img class="img-fluid rounded" src="http://placehold.it/750x300" alt=""> -->
           <div class="uploadResult">
			<ul id="ebookNo<c:out value="${ebook.ebookNo }"/>">
			
			</ul>
		   </div>
          </div>
          <div class="col-lg-8">
            <h4 class="card-title"><c:out value="${ebook.ebookTitle }"/></h4>
            <pre id="listpre" class="card-text"><c:out value="${ebook.ebookDetails }"/></pre>
            <a href="/haengbok/ebook/details?ebookNo=<c:out value="${ebook.ebookNo }"/>&sort=${sort }&type=${pageMaker.cri.type }&keyword=${pageMaker.cri.keyword }&pageNum=${pageMaker.cri.pageNum }" class="btn btn-secondary">자세히 &rarr;</a>
          </div>
        </div>
      </div>
      <div class="card-footer text-muted">
       	 <small><c:out value="${ebook.ebookNo }"/>, 인기도: <c:out value="${ebook.numofborrow }"/>, 대출가능 수 : <c:out value="${ebook.quantity }"/>, 좋아요: <c:out value="${ebook.liked }"/> </small>
      </div>
    </div>
    <script>
$(document).ready(function(){
(function(){
	var ebookNo = '<c:out value="${ebook.ebookNo }"/>';
	console.log("test : " + ebookNo);
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
		$("#ebookNo<c:out value="${ebook.ebookNo }"/>").html(str);
			
		/* $("#ebookNo<c:out value="${ebook.ebookNo }"/>").html(ebookno); */
		
	});
})();
});
</script>
</c:forEach>
</div>
</div>
    <!-- Pagination -->

    <ul class="pagination justify-content-center">
      <c:if test="${pageMaker.prev }">
      <li class="page-item">
        <a class="page-link" href="/haengbok/ebook/list?type=${pageMaker.cri.type }&keyword=${pageMaker.cri.keyword }&pageNum=${(pageMaker.startPage -1)*pageMaker.cri.amount-pageMaker.cri.amount }" aria-label="Previous">
          <span aria-hidden="true">&laquo;</span>
          <span class="sr-only">Previous</span>
        </a>
      </li>
      </c:if>
      <c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
      <li class="page-item ${pageMaker.cri.pageNum == (num-1)*pageMaker.cri.amount ? 'active' : '' } ">
        <a class="page-link" href="/haengbok/ebook/list?sort=${sort }&type=${pageMaker.cri.type }&keyword=${pageMaker.cri.keyword }&pageNum=${(num -1)*pageMaker.cri.amount }">${num }</a>
      </li>
      </c:forEach>
      <c:if test="${pageMaker.next }">
      <li class="page-item">
        <a class="page-link" href="/haengbok/ebook/list?type=${pageMaker.cri.type }&keyword=${pageMaker.cri.keyword }&pageNum=${(pageMaker.endPage -1)*pageMaker.cri.amount+pageMaker.cri.amount }" aria-label="Next">
          <span aria-hidden="true">&raquo;</span>
          <span class="sr-only">Next</span>
        </a>
      </li>
      </c:if>
    </ul>
<%-- <form id="actionForm" action="/board/list" method="get">
	<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum / pageMaker.cri.amount +1}'>
	<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
</form> --%>
  </div>
  
  <!-- /.container -->

<!-- Modal  추가 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="myModalLabel"><c:out value="${result }"/></h4>
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			</div>
			<div class="modal-body">삭제가 완료되었습니다.</div>
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
		var result = '<c:out value="${result}"/>';
		checkModal(result);
		history.replaceState({},null,null);
		function checkModal(result) {
			if (result === '' || history.state) {
				return;
			}
			$("#myModal").modal("show");
		}

/* 		$(".page-item a").on("click", function(e){
			e.preventDefault();
			console.log("click page a tag");
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();
		}); */
		var searchForm = $("#searchForm");
		$("#searchForm button").on("click", function(e){
/* 			if(!searchForm.find("option:selected").val()){
				alert("검색 종류를 선택하세요.");
				return false;
			} */
			if(!searchForm.find("input[name='keyword']").val()){
				alert("검색어를 입력하세요.");
				return false;
			}
			searchForm.find("input[name='pageNum']").val("0");
			e.preventDefault();
			searchForm.submit();
		});
		
		var $ipt = $('#searchinput'),
		$clearIpt = $('#searchclear');

		$ipt.keyup(function(){
			$("#searchclear").toggle(Boolean($(this).val()));
		});

		$clearIpt.toggle(Boolean($ipt.val()));
		$clearIpt.click(function(){
			$("#searchinput").val('').focus();
			$(this).hide();
			searchForm.submit();
		});
	});
</script>
<%@ include file="../includes/footer.jsp" %>