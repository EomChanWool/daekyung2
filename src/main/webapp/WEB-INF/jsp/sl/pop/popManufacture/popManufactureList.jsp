<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<style>
	#graph {
		width: 100%;
	}
</style>
<%@ include file="../../header.jsp" %>
<body id="page-top">
    <!-- Page Wrapper -->
    <div id="wrapper">

        <!-- Sidebar -->
       <%--  <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">
            <!-- Side Menu Section -->
			<%@ include file="../../menu/sideMenu.jsp" %>
        </ul> --%>
        <!-- End of Sidebar -->

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

                <!-- Topbar -->
                <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

                    <!-- Sidebar Toggle (Topbar) -->
                    <form class="form-inline">
                        <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                            <i class="fa fa-bars"></i>
                        </button>
                    </form>

                    <!-- Topbar Navbar -->
                    <ul class="navbar-nav ml-auto">

                        <!-- Nav cut - User Information -->
                        <%@ include file="../../menu/logout/nav_user.jsp" %>

                    </ul>

                </nav>
                <!-- End of Topbar -->

                <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading -->
                    <div class="btn_bottom_wrap">
                    	<h1 class="h3 mb-2 text-gray-800" style="display: inline-block;">가공공정관리</h1>
                    	
                    </div>

                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
							<div class="search">
								<form name ="listForm" class="listForm" action="${pageContext.request.contextPath}/sl/pop/popMf/popMfList.do" method="post">
									<input type="hidden" name="orId">
									<input type="hidden" name="mfsIdx">
									<input type="hidden" name="mflManager" id="mflManage">
									<input type="hidden" name="searchCondition" id="searchCondition" value="${searchVO.searchCondition}">
									<input type="hidden" name="searchCondition2" id="searchCondition2"value="${searchVO.searchCondition2}">
									<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
									<input type="text" class="form-control bg-light border-0 small" name="searchKeyword" id="searchKeyword"
																<c:if test="${not empty searchVO.searchKeyword}">value="${searchVO.searchKeyword}"</c:if>
																<c:if test="${not empty searchVO.searchCondition2}">value="${searchVO.searchCondition2}"</c:if>
						    									 placeholder="수주번호를 입력해 주세요" oninput="fn_search_mf()" autofocus
						    									style="background-color:#eaecf4; width: 25%; float: left; margin: 0 0.3rem 0 0;">
									
						    	</form>
						    	<a href="#" class="btn btn-info btn-icon-split" onclick="fn_search_mf2()" style="margin-left: 0.3rem;">
	                                <span class="text">검색</span>
	                            </a>
	                            <a href="#" class="btn btn-info btn-icon-split" id="sr" onclick="fn_search_several()" style="margin-left: 0.3rem;">
	                                <span class="text">다중검색</span>
	                            </a>
						    	<a href="#" class="btn btn-success btn-icon-split" onclick="fn_searchAll_mf()">
	                                <span class="text">전체목록</span>
	                            </a>
	                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						    	<a href="#" class="btn btn-success btn-icon-split" onclick="fn_lunchTime_mf()">
	                                <span class="text">점심시간</span>
	                            </a>
	                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						    	<a href="#" class="btn btn-danger btn-icon-split" onclick="fn_proceeding_mf()">
	                                <span class="text">가공중</span>
	                            </a>
						    	<a href="#" class="btn btn-primary btn-icon-split" onclick="fn_stopping_mf()">
	                                <span class="text">정지중</span>
	                            </a>
	                            
							</div>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                 <table class="table table-bordered" id="dataTable"  >
                                    <thead>
                                        <tr>
                                        	<th>수주번호</th>
                                            <th>품목</th>
                                            <th>수주량</th>
                                            <th>현재공정</th>
                                            <th>진행/중단/재개</th>
                                            
											<th>작업완료</th>
											<th>작업자</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    	<c:forEach var="result" items="${ordList}" varStatus="status">
	                                   		<tr>
	                                   			<td>${result.orId}</td>
	                                   			<td>${result.mpProdName}</td>
	                                   			<td>${result.mpQty}</td>
	                                   			
	                                   			
	                                   			<c:if test="${result.mpPrState eq 0}"><td>가공공정대기중</td></c:if>
	                                   			<c:if test="${result.mpPrState eq 1 and (result.mfsState eq 2 or result.mfsState eq 0)}"><td>가공공정중</td></c:if>
	                                   			<c:if test="${result.mfsState eq 1 and result.mpPrState eq 1}"><td>일시정지</td></c:if>
	                                   			<c:if test="${result.mfsState eq 1 and result.mpPrState eq 1}"><td><a href="#" class="btn btn-primary btn-icon-split" onclick="fn_re_mf_go('${result.orId}','${result.mfsIdx}')">
				                                        <span class="text">재개</span>
				                                    </a></td></c:if>
				                                <c:if test="${result.mpPrState eq 0}"><td><a href="#" class="btn btn-warning btn-icon-split" onclick="fn_goProcess('${result.orId}')">
				                                        <span class="text">진행</span>
				                                    </a></td>
				                                    </c:if>
				                                    <c:if test="${result.mpPrState eq 1 and (result.mfsState eq 2 or result.mfsState eq 0)}"><td><a href="#" class="btn btn-danger btn-icon-split" onclick="fn_stop_mf('${result.orId}')">
				                                        <span class="text">중단</span>
				                                    </a></td>
				                                    </c:if> 
	                                            <td>
				                                    <a href="#" class="btn btn-danger btn-icon-split" onclick="fn_go_finish('${result.orId}','${result.orProcess}')">
				                                        <span class="text">작업완료</span>
				                                    </a>
	                                            </td>
	                                            <td>
	                                            <select class="form-control" id="mflManager_${status.index}" onChange="addManger(${status.index})">
	                                          			    <option value="">선택</option>
														<c:forEach var="list" items="${mfmList}">
															<option value="${list.miName}" <c:if test="${result.mflManager eq list.miName}">selected="selected"</c:if>>${list.miName}</option>
														</c:forEach>
													</select></td>
												
	                                        </tr>
                                    	</c:forEach>
                                    	<c:if test="${empty ordList}"><tr><td colspan='9'>결과가 없습니다.</td><del></del></c:if>
                                    </tbody>
                                </table>
                                <div class="btn_page">
									<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_pageview"/>
							    </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.container-fluid -->
            </div>
            <!-- End of Main Content -->

            <!-- Footer -->
            <%@ include file="../../menu/footer/footer.jsp" %>
            <!-- End of Footer -->
        </div>
        <!-- End of Content Wrapper -->
    </div>
    <!-- End of Page Wrapper -->
    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>

    <!-- Logout Modal-->
    <%@ include file="../../menu/logout/logout_alert.jsp" %>
    
    <!-- Bootstrap core JavaScript-->
    <script src="/resources/conf/vendor/jquery/jquery.min.js"></script>
    <script src="/resources/conf/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    
    <!-- Core plugin JavaScript-->
    <script src="/resources/conf/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="/resources/js/sb-admin-2.min.js"></script>

	<script>
	function fn_pageview(pageNo) {
		listForm.pageIndex.value = pageNo;
	   	listForm.submit();
	}
	
	function fn_search_several(){
		var color = document.getElementById("sr");
		var color2 = color.style.backgroundColor;
		if(color2 == ''){
			
			color.style.backgroundColor = 'red';
			$('#searchKeyword').removeAttr("oninput");
		}
		
		if(color2 == 'red'){
			color.style.removeProperty('background-color');
			$('#searchKeyword').attr("oninput","fn_search_mf()");
		}
		//color.style.backgroundColor = 'red';
		//var inputVal = $('#searchKeyword').val();
	}
	
	function fn_search_mf(){
		var inputVal = $('#searchKeyword').val();
		var length = inputVal.length;
		if(length >= 16){
		listForm.pageIndex.value = 1;	
		listForm.submit();}
	}
	
	function fn_search_mf2(){
		
		listForm.pageIndex.value = 1;
		listForm.submit();
	}
	
	function fn_searchAll_mf(){
		listForm.searchCondition.value = "";
		listForm.searchKeyword.value = "";
		listForm.pageIndex.value = 1;
		listForm.submit();
	}

	function fn_lunchTime_mf(){
		if (confirm("현재 가공중인 공정을 모두 일시정지 합니다.")) {
			listForm.searchCondition.value = 0;
			listForm.action = "${pageContext.request.contextPath}/sl/pop/popMf/stopLunchMf.do";
			listForm.submit();
		}
	}

	function fn_proceeding_mf(){
		listForm.searchCondition.value = 1;
		listForm.pageIndex.value = 1;
		listForm.submit();
	}

	function fn_stopping_mf(){
		listForm.searchCondition.value = 2;
		listForm.pageIndex.value = 1;
		listForm.submit();
	}
	
	function fn_re_mf_go(orId,mfsIdx){
		listForm.orId.value = orId;
		listForm.mfsIdx.value = mfsIdx;
		listForm.action = "${pageContext.request.contextPath}/sl/pop/popMf/reMf.do";
		listForm.submit();
	}
	
	function fn_goProcess(orId){
		if($('#mflManage').val() == ''){
			alert("작업자를 확인 바랍니다.");
			return;
		}
		
		
		listForm.orId.value = orId;
		listForm.action = "${pageContext.request.contextPath}/sl/pop/popMf/goMf.do";
		listForm.submit();
	}
	
	
	function fn_stop_mf(orId){
		listForm.orId.value = orId;
		listForm.action = "${pageContext.request.contextPath}/sl/pop/popMf/stopMf.do";
		listForm.submit();
	}
	
	
	
	function fn_go_finish(orId,orProcess){
		if(orProcess == 2){
			alert("공정을 진행하여 주세요.");
			return;
		}
		
		if(confirm('작업을 완료하시겠습니까?')) {
			listForm.orId.value = orId; 
			listForm.action = "${pageContext.request.contextPath}/sl/pop/popMf/finishMf.do";
			listForm.submit();
		}
	}
	function addManger(index){
		var str = '#mflManager_'+index;
		console.log($(str).val());
		$('#mflManage').val($(str).val());
	}
	

	$(function() {
		$('#processMenu').addClass("active");
		$('#process').addClass("show");
		$('#cutList').addClass("active");
		
		let msg = '${msg}';	
		if (msg) {
				alert(msg);
			}
		});
	</script>
</body>

</html>