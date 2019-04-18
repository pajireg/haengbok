<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ include file="../includes/header.jsp" %>
<style>
.custom-file-label:after{
  content: "탐색";
}
</style>
<script>
$(document).ready(function(e){
	var formObj = $("form[role='form']");
	$("button[type='submit']").on("click", function(e){
		e.preventDefault();
		console.log("submit clicked");
		var str = "";
		
		$(".uploadResult ul li").each(function(i, obj){
			var jobj = $(obj);
			console.dir(jobj);
			
			str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
		    str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
		    str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
		    str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+ jobj.data("type")+"'>";
		      
		});
		formObj.append(str).submit();
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
	$(".uploadResult").on("click", "button", function(e){
		console.log("delete file");
		
		var targetFile = $(this).data("file");
		var type = $(this).data("type");
		var targetLi = $(this).closest("li");
		
		$.ajax({
			url : '/haengbok/deleteFile',
			data : {fileName : targetFile, type : type},
			beforeSend : function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			dataType : 'text',
			type : 'POST',
			success : function(result){
				//alert(result);
				targetLi.remove();
			}
		});
	});
});
</script>

  <!-- Page Content -->
  <div class="container">

	<form role="form" action="/haengbok/ebook/register" method="post">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    <!-- Page Heading/Breadcrumbs -->
    <h1 class="mt-4 mb-3"><input class="form-control" name="ebookTitle" placeholder="title">
    </h1>

    <ol class="breadcrumb d-flex justify-content-between bd-highlight mb-3">
      <li class="breadcrumb-item">
        <a href="/haengbok/ebook/list?sort=recent"><button type="button" class="btn btn-breadcrumb">목록</button></a>
      </li>
      <li>
      <button type="reset" class="btn btn-secondary">리셋</button>
      <button type="submit" class="btn btn-info">등록</button>
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
        <input name="ebookAuthor" class="form-control" placeholder="author" value='<sec:authentication property="principal.username"/>' readonly>
        <hr>

        <!-- Post Content -->
		<textarea name="ebookDetails" class="form-control" rows="10"></textarea>
        <hr>


      </div>

      <!-- Sidebar Widgets Column -->
      <div class="col-md-4">

<!-- 
        <div class="card mb-4">
          <h5 class="card-header">카테고리</h5>
          <div class="card-body">
            <div class="row">
              <div class="col-lg-6">
                <ul class="list-unstyled mb-0">
                  <li>
                    <label><input type="checkbox" name="category" value="Web Design">Web Design</label>
                  </li>
                  <li>
                    <label><input type="checkbox" name="category" value="html">HTML</label>
                  </li>
                  <li>
                    <label><input type="checkbox" name="category" value="freebies">Freebies</label>
                  </li>
                </ul>
              </div>
              
              <div class="col-lg-6">
                <ul class="list-unstyled mb-0">
                  <li>
                    <label><input type="checkbox" name="category" value="javascript">JavaScript</label>
                  </li>
                  <li>
                    <label><input type="checkbox" name="category" value="css">CSS</label>
                  </li>
                  <li>
                    <label><input type="checkbox" name="category" value="tutorials">Tutorials</label>
                  </li>
                </ul>
              </div>
            </div> 	
          </div>
        </div>


        <div class="card my-4">
          <h5 class="card-header">사이드 위젯</h5>
          <div class="card-body">
           	 <input type="text" class="form-control">
          </div>
        </div>
 -->
      </div>

    </div>
    <!-- /.row -->
</form>
  </div>
  <!-- /.container -->

  <%@ include file="../includes/footer.jsp"%>