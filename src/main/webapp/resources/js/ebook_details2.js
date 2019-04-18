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
		           str +"</li>";
		         }else{
		           str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
		           str += "<span> "+ attach.fileName+"</span><br/>";
		           str += "<img src='/resources/img/attach.png'></a>";
		           str += "</div>";
		           str +"</li>";
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