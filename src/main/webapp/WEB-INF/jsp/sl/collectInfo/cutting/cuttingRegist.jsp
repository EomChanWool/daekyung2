<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<%@ include file="../../header.jsp" %>
<style>
	.table th{
		padding-top: 1.3rem;
	}
</style>
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
                        <!-- Nav cutting - User Information -->
                        <%@ include file="../../menu/logout/nav_user.jsp" %>
                    </ul>
                </nav>
                <!-- End of Topbar -->

                <!-- Begin Page Content -->
                <div class="container-fluid">
                    <!-- Page Heading -->
                    <h1 class="h3 mb-2 text-gray-800">절단공정정보 등록</h1>
                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-body">
                            <div class="table-responsive">
                            	<form action="${pageContext.request.contextPath}/sl/collectInfo/cutting/registCuttingOk.do" name="registForm" method="post">
	                                <table class="table table-bordered" id="dataTable">
	                                    <tbody>
										<tr>
											<th>설비</th>
											<td><input type="text" class="form-control" name="eqSensorid" id="eqSensorid" list="list" autocomplete="off">
												<datalist id="list">
													<option value="">선택</option>
													<c:forEach var="list" items="${eqList}" varStatus="status">
														<option value="${list.eqSensorid}">${list.eqSensorid} / ${list.eqName}</option>
													</c:forEach>
												</datalist></td>
											<th>품명</th>
											<td><input type="text" class="form-control" name="csProdName" value="${cuttingVO.csProdName}"/></td>
										</tr>
										<tr>
											<th>모델  </th>
											<td><input type="text" class="form-control" name="csModel" value="${cuttingVO.csModel}"/></td>
											<th>반경  </th>
											<td><input type="text" class="form-control" name="csRadius" value="${cuttingVO.csRadius}"/></td>
										</tr>
										<tr>
											<th>두께</th>
											<td><input type="text" class="form-control" name="csThickness" value="${cuttingVO.csThickness}"></td>
											<th>갭</th>
											<td><input type="text" class="form-control" name="csGap" value="${cuttingVO.csGap}"></td>
										</tr>
										<tr>
											<th>생산량</th>
											<td><input type="text" class="form-control" name="csQty" value="${cuttingVO.csQty}"></td>
											<th>배길이</th>
											<td><input type="text" class="form-control" name="csLong" value="${cuttingVO.csLong}"></td>
										</tr>
										<tr>
											<th>시작시간</th>
											<td><input type="datetime-local" class="form-control" name="csRegDate"  value="${curTime}"></td>
											<th>종료시간</th>
											<td><input type="datetime-local" class="form-control" name="csEdDate" value="${curTime}"></td>
										</tr>
										<tr>
											<th>작업시간</th>
											<td><input type="text" class="form-control" name="csWorkTime" value="${cuttingVO.csWorkTime}"></td>
										</tr>
									</tbody>
	                                </table>
                                </form>
                                <div class="btn_bottom_wrap">
									<button type="submit" class="btn_ok" onclick="fn_regist_cutting()" style="border:none;">확인</button>
									<span class="btn_cancel" onclick="location.href='${pageContext.request.contextPath}/sl/collectInfo/cutting/cuttingList.do'">취소</span>
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
	function fn_regist_cutting(){
		if(registForm.csRegDate.value == ''){
			alert("시작시간을 확인 바랍니다.");
			return;
		}
		
	
		
		registForm.submit();
	}
	
	
	
	$(function() {
		$('#collectInfoMenu').addClass("active");
		$('#collectInfo').addClass("show");
		$('#cuttingList').addClass("active");
		
		let msg = '${msg}';
		if(msg) {
			alert(msg);
		}
		console.log('${eqList}');
	});
	

	
	

	</script>
</body>

</html>