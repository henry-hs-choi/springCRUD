<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@include file="../include/header.jsp"%>

<!-- Main content -->
<section class="content">
<div class="row">
    <!-- left column -->
    <div class="col-md-12">
        <!-- general form elements -->
        <div class='box'>
            <div class="box-header with-border">
                <h3 class="box-title">Board List</h3>
            </div>
            <div class='box-body'>
                <!-- 추가  -->
                <select name="searchType" id="searchType">
                    <option value="title">제목</option>
                    <option value="writer">작성자</option>
                </select> 
                <input type="text" name='searchKeyword' id="searchKeyword">
                <button id='searchBtn'>Search</button>
                <!-- 기존 -->
                <button id='newBtn'>New Board</button>
            </div>
        </div>
        <div class="box">
            <div class="box-header with-border">
                <h3 class="box-title">LIST PAGING</h3>
            </div>
            <div class="box-body">
                <table class="table table-bordered">
                    <tr>
                        <th style="width: 10px">BNO</th>
                        <th>TITLE</th>
                        <th>WRITER</th>
                        <th>REGDATE</th>
                        <th style="width: 40px">VIEWCNT</th>
                    </tr>
                    
                    <tbody id="tbody">
                    <c:forEach items="${list}" var="boardVO">
                        <tr>
                            <td>${boardVO.seq}</td>
                            <td>
                                <a  href='readPage.sinc?seq=${boardVO.seq}'>
                                    <c:if test="${boardVO.newFlag}">
                                    	<span class="badge badge-primary" style="background-color: #dc3545">New</span>
                                    </c:if>
                                    <c:if test='${ boardVO.writer == "administrator" }'>
										<span style="font-weight: 600; color: #dc3545"> ${boardVO.title} (${ boardVO.rcount })</span>
									</c:if>
                                    <c:if test='${ boardVO.writer != "administrator" }'>
										${boardVO.title} (${ boardVO.rcount })
									</c:if>
                                 </a>
                             </td>
                            <td>
                            	<c:if test='${ boardVO.writer == "administrator" }'>
									<span style="font-weight: 600; color: #dc3545"> ${boardVO.writer}</span>
								</c:if>	
								<c:if test='${ boardVO.writer != "administrator" }'>
									 ${boardVO.writer}
								</c:if>	
                            </td>
                            <td>${boardVO.regdate}</td>
                            <td><span class="badge bg-red">${boardVO.viewcnt }</span></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
            <!-- /.box-body -->


            <div class="box-footer">

                <div class="text-center">
                        <!--  -->

                        <jsp:include page="./paging.jsp" flush="true">
                            <jsp:param name="prev" value="${page.prev}" />
                            <jsp:param name="prevPageNo" value="${page.startPage-1}" />
                            <jsp:param name="startPageNo" value="${page.startPage}" />
                            
                            <jsp:param name="endPageNo" value="${page.endPage}" />
                            <jsp:param name="nextPageNo" value="${page.endPage+1}" />
                            <jsp:param name="next" value="${page.next}" />
                        </jsp:include>

                        <!--  -->
                </div>
            </div>
        </div>
    </div>
</div>
</section>
</div>
<!-- /.content -->

<form id="jobForm">
<input type='hidden' name="page" value=${pageManager.currentPage}>
</form>




<%@include file="../include/footer.jsp"%>


<script>
function goPage(pageNum){
    location.href="listPage.sinc?pageNum="+pageNum ; 
}
////////////////////////////////////////////////////////
var result = '${msg}';

if (result == 'SUCCESS') {
    alert("처리가 완료되었습니다.");
}

// 	$(".pagination li a").on("click", function(event){
    
// 		event.preventDefault(); 
    
// 		var targetPage = $(this).attr("href");
    
// 		var jobForm = $("#jobForm");
// 		jobForm.find("[name='page']").val(targetPage);
// 		jobForm.attr("action","/board/listPage.do").attr("method", "get");
// 		jobForm.submit();
// 	});

$("#newBtn").on("click", function() {
    location.href="register.sinc";  
});

$("#searchBtn").click(function() {
    $.ajax({
        url  : "search.sinc" , 
        type : "post" , 
        dataType : "json" , 
        data : { type : $("#searchType").val() , keyword : $("#searchKeyword").val() } ,
        success : function(data) {
            $("#tbody").empty();
            var txt = "";
            $.each(data , function(idx, obj) {
                txt +="<tr><td>"+obj.seq+"</td>" ; 
                txt +="<td><a href='readPage.sinc?seq="+obj.seq+"'>"+obj.title+ "</a></td>";
                txt +="<td>"+obj.writer+"</td>";
                txt +="<td>"+obj.regdate+"</td>";
                txt +="<td><span class='badge bg-red'>"+obj.viewcnt+"</span></td></tr>" ; 
            });
            $("#tbody").append(txt); 
        }
        
    });
    
});
</script>
















