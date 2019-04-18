console.log("ebookReply Module.......");
var ebookReplyService = (function(){

	function getList(param, callback, error){
		var ebookNo = param.ebookNo;
		var page = param.page || 1;
		$.getJSON("/haengbok/replies/pages/" + ebookNo + "/" + page + ".json",
			function(data){
				if(callback){
					callback(data); //댓글 목록만 가져오는 경우
					//callback(data.replyCnt, data.list); //글 숫자와 목록을 가져오는 경우
				}
			}).fail(function(xhr, status, err){
				if(error){
					error();
				}
			});
	}

	function add(reply, callback, error) {
		console.log("add reply............");
		
		$.ajax({
			type : "post",
			url : "/haengbok/replies/new",
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
				if(callback){
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if(error){
					error(er);
				}
			}
		});
	}
	
	function get(replyNo, callback, error){
		$.get("/haengbok/replies/"+replyNo+".json", function(result){
			if(callback){
				callback(result);
			}
		}).fail(function(xhr, status, err){
			if(error){
				error();
			}
		});
	}
	function remove(replyNo, callback, error){
		$.ajax({
			type : "delete",
			url : "/haengbok/replies/" + replyNo,
//			data : JSON.stringify({replyNo : replyNo, replyer : replyer}),
//			contentType : "application/json; charset=utf-8",
			success : function(deleteResult, status, xhr){
				if(callback){
					callback(deleteResult);
				}
			},
			error : function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		});
	}
	function update(reply, callback, error) {
		$.ajax({
			type : 'put',
			url : '/haengbok/replies/' + reply.replyNo,
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
				if(callback) {
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if(error) {
					error(er);
				}
			}
		});
	}
	function displayTime(timeValue){
		var today = new Date();
		var gap = today.getTime() - timeValue;
		var dateObj = new Date(timeValue);
		var str = "";
		
		if(gap < (1000 * 60 * 60 * 24)){
			var hh = dateObj.getHours();
			var mi = dateObj.getMinutes();
			var ss = dateObj.getSeconds();
			
			return [ (hh > 9 ? '' : '0') + hh, ':', (mi > 9 ? '' : '0') + mi,
				':', (ss > 9 ? '' : '0') + ss ].join('');
		}else{
			var yy = dateObj.getFullYear();
			var mm = dateObj.getMonth() + 1;
			var dd = dateObj.getDate();
			
			return [ yy, '/', (mm > 9 ? '' : '0') + mm, '/',
				(dd > 9 ? '' : '0') + dd ].join('');
		}
	};
	return{

		getList : getList,
		add : add,
		displayTime : displayTime,
		get : get,
		remove : remove,
		update : update

	};
})();