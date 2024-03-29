<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>

<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>


<%@include file="../include/header.jsp" %>

    <!-- Main content -->
    <section class="content">
      <div class="row">
      <!-- left column -->
      <div class="col-md-12">
        <!-- general form elements -->
        <div class="box box-primary">
        <div class="box-header">
          <h3 class="box-title">READ BOARD</h3>
        </div><!-- /.box-header -->
<%-- 
<form role="form" action="modifyPage" method="post">
    
    <input type='hidden' name='bno' value ="${boardVO.bno}">
    <input type='hidden' name='page' value ="${cri.page}">
    <input type='hidden' name='perPageNum' value ="${cri.perPageNum}">
    
</form>   
--%>    
  <div class="box-body">
    <div class="form-group">
      <label for="exampleInputEmail1">Title</label>
      <input type="text" name='title' class="form-control" 
         value="${board.title}" readonly="readonly">
    </div>
    
    <div class="form-group">
      <label for="exampleInputPassword1">Content</label>
      <%-- <textarea class="form-control"  name="content" rows="3" 
      readonly="readonly">${board.content}</textarea> --%>
      <br><br>
      <c:out value="${board.content}" escapeXml="false" />
    </div>
    <div class="form-group">
      <label for="exampleInputEmail1" >Writer</label>
      <input type="text" name="writer" class="form-control" 
        value="${board.writer}" readonly="readonly">
    </div>
  </div><!-- /.box-body -->

  <div class="box-footer">
	<c:if test="${ loginUser.id == board.writer }">
	<button id="modify" type="button" class="btn btn-warning">Modify</button> 
	<button id="remove" type="button" class="btn btn-danger">REMOVE</button> 
    </c:if>
    <button id="list" type="button" class="btn btn-primary">GO LIST </button>
  </div>
  
  <div class="row">
		<div class="col-md-12">

			<div class="box box-success">
				<div class="box-header">
					<h3 class="box-title">ADD NEW REPLY</h3>
				</div>
				 
				<c:if test="${ userSignedIn }">
					<div class="box-body">
						<label for="exampleInputEmail1">Writer</label> 
						<input class="form-control" type="text" placeholder="USER ID"    id="newReplyWriter" 
							value='${ currentUser.id }' readonly="readonly"> 
						<label for="exampleInputEmail1">Reply Text</label> 
						<input class="form-control" type="text" placeholder="REPLY TEXT" id="newReplyText">
					</div>
					<!-- /.box-body -->
					<div class="box-footer">
						<button type="button" class="btn btn-primary" id="replyAddBtn">ADD REPLY</button>
					</div>
				</c:if>
			</div>

		
		<!-- The time line -->
		<ul class="timeline">
		  	<!-- timeline time label -->
			<li class="time-label" id="repliesDiv">
			  <span class="bg-green">
			    Replies List <small id='replycntSmall'> [ 000 ] </small>
			  </span>
			</li>
		</ul>
		<!--  -->
		<ul id="rlist">
			<!-- TODO 댓글 기능 구현시 필요 -->
			
			<c:forEach items="${board.rlist}" var="reply">
				
				<li class="time-label">
					<c:if test="${ reply.rwriter == 'administrator' }">
						<p style="font-weight: 600; color: #dc3545">${reply.rwriter} : ${reply.rtext}</p>
					</c:if>
					<c:if test="${ reply.rwriter != 'administrator' }">
						${reply.rwriter} : ${reply.rtext}
					</c:if>
					
					<%-- ${reply.rtext} --%>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<%-- <a href="javascript:removeReply(${reply.rseq},${reply.seq})">X</a> --%>
				</li>
			</c:forEach>
			
		</ul>
		<!--  -->   
			<div class='text-center'>
				<ul id="pagination" class="pagination pagination-sm no-margin ">

				</ul>
			</div>

		</div>
		<!-- /.col -->
	</div>
	<!-- /.row -->


<script>
	function removeReply(seq,bno) {
		alert(seq);
		
		$.ajax({
			url  : "replyRemove" , 
			type : "post" , 
			data : { rseq : seq , bno : bno} ,
			dataType : "json" , 
			success : function(ary) {
				$("#rlist").empty(); // remove() 
				var txt = "";
				$.each(ary , function(idx, obj) {
					txt += "<li class='time-label'>"+obj.rtext;
					txt += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
					txt += "<a href='javascript:removeReply("+obj.rseq+","+obj.bno+")'>X</a></li>";
				});
				$("#rlist").append(txt);
			}
		});
		 
	}

	$(document).ready(function() {
		$("#list").click(function() {
			location.href="listPage.sinc" ; 
		});
		
		$("#remove").click(function() {
			location.href="removePage.sinc?seq="+${board.seq} ; 
		});
		$("#modify").click(function() {
			location.href="modifyPage.sinc?seq="+${board.seq} ; 
		});
		
		$("#replyAddBtn").click(function() {
			let userSignedIn = <%= (session.getAttribute("loginUser")!=null) %>;
			if($("#newReplyText").val() == ""){
				alert("내용을 입력해 주세요.");
			}
			else if(userSignedIn) {
				$.ajax({
					url  : "replyInsert.sinc" , 
					type : "post" , 
					data : {rwriter : $("#newReplyWriter").val() ,
						    rtext : $("#newReplyText").val()  , 
						    seq : ${board.seq}
						   } ,
					dataType : "json" , 
					success : function(ary) {
						$("#newReplyText").val("");
						$("#rlist").empty(); // remove() 
						var txt = "";
						$.each(ary , function(idx, obj) {
							txt += "<li class='time-label'>"+ obj.rwriter + ":" +  obj.rtext;
							txt += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
							txt += "<a href='javascript:removeReply("+obj.rseq+","+obj.bno+")'>X</a></li>";
						});
						$("#rlist").append(txt);
					}
				});
			} else {
				// 로그인 되지 않았을 때
				window.location.href="/user/loginForm.sinc";
			}
		});
	});

/* 
$(document).ready(function(){
	
	var formObj = $("form[role='form']");
	
	console.log(formObj);
	
	if(${boardVO.writer==sessionScope.loginUser.name}
	  || ${sessionScope.loginUser.name=='관리자'}){
		$(".box-footer").html(
				'<button type="submit" class="btn btn-warning">Modify</button> '
			   +'<button type="submit" class="btn btn-danger">REMOVE</button> '
			   +'<button type="submit" class="btn btn-primary">GO LIST </button>');
	}
});

$(document).on("click", ".btn-warning", function(){
	var formObj = $("form[role='form']");
	formObj.attr("action", "/board/modifyPage.do");
	formObj.attr("method", "get");		
	formObj.submit();
});

$(document).on("click", ".btn-danger", function(){
	var formObj = $("form[role='form']");
	if(confirm("게시물을 삭제하시겠습니까?")){	
		formObj.attr("action", "/board/removePage.do");
		formObj.submit();
	}
});

$(document).on("click", ".btn-primary", function(){
	var formObj = $("form[role='form']");
	formObj.attr("method", "get");
	formObj.attr("action", "/board/listPage.do");
	formObj.submit();
});
*/
</script>


  
  
        </div><!-- /.box -->
      </div><!--/.col (left) -->
 
      </div>   <!-- /.row -->
    </section><!-- /.content -->
    </div><!-- /.content-wrapper -->
    
<%@include file="../include/footer.jsp" %>
  