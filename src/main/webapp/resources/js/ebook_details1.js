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
			        str += "<div class='media-body'><h6 class='mt-0'>"+list[i].replyer+" <img class='modify' data-replyno='"+list[i].replyNo+"' style='cursor:pointer' src='../resources/icons/baseline_more_horiz_black_18dp.png'> <small>"+ebookReplyService.displayTime(list[i].regdate)+"</small> <img class='delete' data-replyno='"+list[i].replyNo+"' src='../resources/icons/baseline_close_black_18dp.png' style='cursor:pointer'></h6>";
			        str += list[i].replytext+"</div></div></li>";
				}
				replyUL.html(str);
			});
	}
	var modal = $(".modal");
	var modalInputReply = modal.find("input[name='replytext']");
	var modalInputReplyer = modal.find("input[name='replyer']");
	var modalInputReplyDate = modal.find("input[name='regdate']");
	
	var modalModBtn = $("#modalModBtn");
 	var modalRemoveBtn = $("#modalRemoveBtn");
 	var modalRegisterBtn = $("#modalRegisterBtn");
 	

 	var addReply = $(".addReply");
 	var addReplytext = addReply.find("textarea[name='replytext']");
 	var addReplyer = addReply.find("input[name='replyer']");
 	$("#addReplyBtn").on("click", function(e){
 		if(addReplytext.val() == ''){
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
  	$(".replies").on("click", ".delete", function(e){
 		var replyNo = $(this).data("replyno");
 		ebookReplyService.remove(replyNo, function(result){
 			showList(1);
 		});
 	});
   	$(".replies").on("click", ".modify", function(e){
 		var replyNo = $(this).data("replyno");
 		ebookReplyService.get(replyNo, function(reply){
 			modalInputReply.val(reply.replytext);
 			modalInputReplyer.val(reply.replyer).attr("readonly", "readonly");
 			modalInputReplyDate.val(reply.regdate).attr("readonly", "readonly");
 			modal.data("replyNo", reply.replyNo);
 			
 			modal.find("button[id != 'modalCloseBtn']").hide();
 			modalModBtn.show();
 			//modalRemoveBtn.show();
 			
 			$("#replyModal").modal("show");
 		});
 	});
	 	modalModBtn.on("click", function(e){
	 		var replyNo = modal.data("replyNo");
	 		var reply = {replyNo : replyNo, replytext : modalInputReply.val()};
	 		
	 		ebookReplyService.update(reply, function(result){
	 			//alert(result);
	 			modal.modal("hide");
	 			showList(1);
	 		});
	 	});
	 	modalRemoveBtn.on("click", function(e){
	 		var replyNo = modal.data("replyNo");
	 		ebookReplyService.remove(replyNo, function(result){
	 			modal.modal("hide");
	 			showList(1);
	 		});
	 	});
});
