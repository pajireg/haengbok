<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ include file="../includes/header.jsp" %>

<script>
$(document).ready(function(){
	(function(){
		var ebookNo = '<c:out value="${ebook.ebookNo}"/>';
		$.getJSON("/haengbok/ebook/getAttachList", {ebookNo : ebookNo}, function(arr){
			console.log(arr);
			var str = "";
			
			$(arr).each(function(i, attach){
				
		         if(attach.fileType){
		           var fileCallPath =  encodeURIComponent( attach.uploadPath+ "/s_"+attach.uuid +"_"+attach.fileName);
		           str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
		           str += "<span> "+attach.fileName+"</span>";
		           str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
		           str += "<img src='/haengbok/display?fileName="+fileCallPath+"'>";
		           str += "</div>";
		           str += "</li>";
		         }else{
		           str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
		           str += "<span> "+ attach.fileName+"</span><br/>";
		           str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
		           str += "<img src='/resources/img/attach.png'></a>";
		           str += "</div>";
		           str += "</li>";
		         }
			});
			$(".uploadResult ul").html(str);
		});
	})();
	$(".uploadResult").on("click", "button", function(e){
		console.log("delete file");
		if(confirm("삭제하시겠습니까?")){
			var targetLi = $(this).closest("li");
			targetLi.remove();
		}
	});
	
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	var maxSize = 10485760;	// 10mb
	
	function checkExtension(fileName, fileSize){
		if(fileSize >= maxSize){
			alert("파일 사이즈 초과");
			return false;
		}
		if(regex.test(fileName)){
			alert("해당 종류의 파일은 업로드할 수 없습니다.");
			return false;
		}
		return true;
	}
	
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	
	$("input[type='file']").change(function(e){
		var formData = new FormData();
		var inputFile = $("input[name='uploadFile']");
		var files = inputFile[0].files;
		
		for(var i=0; i<files.length; i++){
			if(!checkExtension(files[i].name, files[i].size)){
				return false;
			}
			formData.append("uploadFile", files[i]);
		}
		$.ajax({
			url : '/haengbok/uploadAjaxAction',
			processData : false,
			contentType : false,
			beforeSend : function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			data : formData,
			type : 'POST',
			dataType : 'json',
			success : function(result){
				console.log(result);
				showUploadResult(result); // 업로드 결과 처리 함수
			}
		});
	});
	function showUploadResult(uploadResultArr){
		if(!uploadResultArr || uploadResultArr.length == 0){
			return;
			}
		var uploadUL = $(".uploadResult ul");
		var str = "";
		
		$(uploadResultArr).each(function(i, obj){
			//image type
	        if(obj.image){
	            var fileCallPath = encodeURIComponent( obj.uploadPath+ "/s_"+obj.uuid +"_"+obj.fileName);
	            str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'><div>";
	            str += "<span> "+ obj.fileName+"</span>";
	            str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
	            str += "<img src='/haengbok/display?fileName="+fileCallPath+"'>";
	            str += "</div>";
	            str +"</li>";
	        }else{
	            var fileCallPath = encodeURIComponent( obj.uploadPath+"/"+ obj.uuid +"_"+obj.fileName);            
	              var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
	                
	            str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'><div>";
	            str += "<span> "+ obj.fileName+"</span>";
	            str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
	            str += "<img src='/resources/img/attach.png'></a>";
	            str += "</div>";
	            str +"</li>";
	          }
		});
		uploadUL.append(str);
	}
});
</script>

  <!-- Page Content -->
  <div class="container">

	<form role="form" id="modifyform" action="/haengbok/ebook/modify" method="post">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		<input type="hidden" name="type" value="<c:out value="${cri.type }"/>">
		<input type="hidden" name="keyword" value="<c:out value="${cri.keyword }"/>">
		<input type="hidden" name="pageNum" value="<c:out value="${cri.pageNum }"/>">
    <!-- Page Heading/Breadcrumbs -->
    <h1 class="mt-4 mb-3"><input class="form-control" name="ebookTitle" value="<c:out value="${ebook.ebookTitle}"/>">
      <small>
        <input name="ebookAuthor" class="form-control" value="<c:out value="${ebook.ebookAuthor}"/>" readonly>
        <input name="ebookNo" class="form-control" value="<c:out value="${ebook.ebookNo}"/>" readonly>
      </small>
    </h1>

    <ol class="breadcrumb d-flex justify-content-between bd-highlight mb-3">
      <li class="breadcrumb-item">
      	<a href="/haengbok/ebook/list?sort=${sort }&type=${cri.type }&keyword=${cri.keyword }&pageNum=${cri.pageNum }">
          <input type="button" class="btn btn-breadcrumb" value="목록">
        </a>
      </li>
      <li>
      <a href="/haengbok/ebook/details?sort=${sort }&ebookNo=<c:out value="${ebook.ebookNo}"/>">
      	<input type="button" class="btn btn-secondary" value="취소">
      </a>
      <sec:authentication property="principal" var="pinfo"/>
      <sec:authorize access="isAuthenticated()">
      <c:if test="${pinfo.username eq ebook.ebookAuthor }">
      <button type="submit" data-oper='modify' class="btn btn-secondary">수정</button>
	  <button type="submit" data-oper='remove' class="btn btn-danger">삭제</button>
	  </c:if>
	  </sec:authorize>
      </li>
    </ol>

    <div class="row">

      <!-- Post Content Column -->
      <div class="col-lg-8">

        <!-- Preview Image -->
        <!-- <img class="img-fluid rounded" src="http://placehold.it/900x300" alt=""> -->
		<div class="form-group uploadDiv">
				<div class="custom-file">
					<input type="file" class="custom-file-input" name="uploadFile" multiple>
					<label class="custom-file-label">사진 탐색</label>
				</div>
		</div>
        <div class="uploadResult">
			<ul>
			
			</ul>
		</div>

        <hr>

        <!-- Date/Time -->
        <p><fmt:formatDate type="both" value="${ebook.ebookRegdate }"/></p>
        <hr>

        <!-- Post Content -->
        <input class="form-control" name="ebookNo" value="<c:out value="${ebook.ebookNo }"/>" readonly>
		<textarea class="form-control" name="ebookDetails" rows="10"><c:out value="${ebook.ebookDetails}"/></textarea>
        <hr>


      </div>

      <!-- Sidebar Widgets Column -->
      <div class="col-md-4">


<!--         <div class="card mb-4">
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
        </div> -->

      </div>

    </div>
    <!-- /.row -->
</form>
  </div>
  <!-- /.container -->

<script type="text/javascript">
$(document).ready(function(){
	var formObj = $("#modifyform");
	$("button").on("click", function(e){
		e.preventDefault();
		var operation = $(this).data("oper");
		console.log(operation);
		if(operation === "remove"){
			formObj.attr("action", "/haengbok/ebook/remove");
		}/* else if(operation === "list"){
			formObj.attr("action", "/haengbok/ebook/list").attr("method", "get");
			
			var sortTag = $("input[name='sort']").clone();
 			var typeTag = $("input[name='type']").clone();
			var keywordTag = $("input[name='keyword']").clone();
			var pageNumTag = $("input[name='pageNum']").clone();
			
			formObj.empty();
			
			formObj.append(sortTag);
 			formObj.append(typeTag);
			formObj.append(keywordTag);
			formObj.append(pageNumTag);
			
		} */else if(operation === 'modify'){
	    	console.log("submit clicked");
	    	var str = "";
	    	
	    	$(".uploadResult ul li").each(function(i, obj){
	    		var jobj = $(obj);
	    		console.dir(jobj);
	    		
	    		str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
	    		str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
	    		str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
	    		str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+jobj.data("type")+"'>";
	    	});
	    	formObj.append(str).submit();
	    }
		formObj.submit();
	});
});
</script>
  <%@ include file="../includes/footer.jsp"%>