<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<%@ include file="../../header.jsp" %>

<body id="page-top">
    <!-- Page Wrapper -->
    <div id="wrapper">

        <!-- Sidebar -->
        <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">
            <!-- Side Menu Section -->
			<%@ include file="../../menu/sideMenu.jsp" %>
        </ul>
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

                        <!-- Nav facMaster - User Information -->
                        <%@ include file="../../menu/logout/nav_user.jsp" %>

                    </ul>

                </nav>
                <!-- End of Topbar -->

                <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading -->
                    <h1 class="h3 mb-2 text-gray-800">설비마스터관리</h1>

                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
							<div class="search">
								<form name ="listForm" class="listForm" action="${pageContext.request.contextPath}/sl/facility/facMaster/facMasterList.do" method="post">
									<input type="hidden" name="eqId">
									<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
									<select class="btn btn-secondary dropdown-toggle searchCondition" name="searchCondition" id="searchCondition">
							    		<option value="" <c:if test="${searchVO.searchCondition eq ''}">selected="selected"</c:if>>선택</option>
							    		<option value="코드네임" <c:if test="${searchVO.searchCondition eq '코드네임'}">selected="selected"</c:if>>코드네임</option>
							    		<option value="설비구분" <c:if test="${searchVO.searchCondition eq '설비구분'}">selected="selected"</c:if>>설비구분</option>
							    		<option value="설비명" <c:if test="${searchVO.searchCondition eq '설비명'}">selected="selected"</c:if>>설비명</option>
							    		<option value="설비상태" <c:if test="${searchVO.searchCondition eq '설비상태'}">selected="selected"</c:if>>설비상태</option>
						    		</select>
						    		<input type="text" class="form-control bg-light border-0 small" name="searchKeyword"
						    									value="${searchVO.searchKeyword}" placeholder="검색어를 입력해 주세요"
						    									style="background-color:#eaecf4; width: 25%; float: left; margin-right: 5px;">
						    	</form>
						    	<a href="#" class="btn btn-info btn-icon-split" onclick="fn_search_facMaster()" style="margin-left: 0.3rem;">
	                                <span class="text">검색</span>
	                            </a>
						    	<a href="#" class="btn btn-success btn-icon-split" onclick="fn_searchAll_facMaster()">
	                                <span class="text">전체목록</span>
	                            </a>
	                            <a href="#" class="btn btn-primary btn-icon-split" onclick="fn_regist_facMaster()" style="float: right;">
	                                <span class="text">등록</span>
	                            </a>
							</div>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable"  >
                                    <thead>
                                        <tr>
											<th>설비구분</th>
											<th>코드네임</th>
											<th>설비명</th>
											<th>설치장소</th>
											<th>설비상태</th>
											<th>수정/삭제</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    	<c:forEach var="result" items="${facMasterList}" varStatus="status">
	                                   		<tr onclick="fn_detail_facMaster('${result.eqId}')" style="cursor: pointer;">
												<td>${result.eqType}</td>
												<td>${result.eqSensorid}</td>
												<td>${result.eqName}</td>
												<td>${result.eqPlace}</td>
												<td>${result.eqOpState}</td>
	                                            <td class="list_btn" onclick="event.cancelBubble=true" style="padding: 5px 0px; cursor: default;">
	                                            	<a href="#" class="btn btn-warning btn-icon-split" onclick="fn_modify_facMaster_go('${result.eqId}')">
				                                        <span class="text">수정</span>
				                                    </a>
				                                    <a href="#" class="btn btn-danger btn-icon-split" onclick="fn_delete_facMaster('${result.eqId}')">
				                                        <span class="text">삭제</span>
				                                    </a>
	                                            </td>
	                                        </tr>
                                    	</c:forEach>
                                    	<c:if test="${empty facMasterList}"><tr><td colspan='8'>결과가 없습니다.</td><del></del></c:if>
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
	
	function fn_search_facMaster(){
		if($('#searchCondition').val()==''){
			alert("검색조건을 선택하세요.");
			return;
		}
		listForm.pageIndex.value = 1;
		listForm.submit();
	}
	
	function fn_searchAll_facMaster(){
		listForm.searchCondition.value = "";
		listForm.searchKeyword.value = "";
		listForm.pageIndex.value = 1;
		listForm.submit();
	}
	
	function fn_regist_facMaster(){
		listForm.action = "${pageContext.request.contextPath}/sl/facility/facMaster/registFacMaster.do";
		listForm.submit();
	}
	
	function fn_modify_facMaster_go(eqId){
		listForm.eqId.value = eqId;
		listForm.action = "${pageContext.request.contextPath}/sl/facility/facMaster/modifyFacMaster.do";
		listForm.submit();
	}
	
	function fn_detail_facMaster(eqId){
		listForm.eqId.value = eqId;
		listForm.action = "${pageContext.request.contextPath}/sl/facility/facMaster/detailFacMaster.do";
		listForm.submit();
	}
	
	function fn_delete_facMaster(eqId){
		if(confirm('해당 내역을 삭제하시겠습니까?')) {
			listForm.eqId.value = eqId;
			listForm.action = "${pageContext.request.contextPath}/sl/facility/facMaster/deleteFacMaster.do";
			listForm.submit();
		}
	}
	
	$(function() {
		$('#facilityMenu').addClass("active");
		$('#facility').addClass("show");
		$('#facMasterList').addClass("active");
		
		let msg = '${msg}';
		if(msg) {
			alert(msg);
		}
		
		$('#searchStDate').change(function(){
			listForm.submit();
		});
		$('#searchEdDate').change(function(){
			listForm.submit();
		});
		
	});
	</script>
</body>

</html>