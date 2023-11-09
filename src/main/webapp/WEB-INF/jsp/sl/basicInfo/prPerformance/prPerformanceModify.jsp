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
                        <!-- Nav member - User Information -->
                        <%@ include file="../../menu/logout/nav_user.jsp" %>
                    </ul>
                </nav>
                <!-- End of Topbar -->

                <!-- Begin Page Content -->
                <div class="container-fluid">
                    <!-- Page Heading -->
                    <h1 class="h3 mb-2 text-gray-800">생산실적 수정</h1>
                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-body">
                            <div class="table-responsive">
                            	<form action="${pageContext.request.contextPath}/sl/basicInfo/prPerformance/modifyPrPerformanceOk.do" name="modifyForm" method="post">
                            		<input type="hidden" name="relIdx" value="${prPerVo.relIdx}">
	                                <table class="table table-bordered" id="dataTable">
	                                    <tbody>
	                                    	<tr>
												<th>수주번호<span class="req">*</span></th>
												<td><input type="text" class="form-control" name="orId" id="orId" readonly="readonly" value="${prPerVo.orId}"/></td>
												<th>로트번호<span class="req">*</span></th>
												<td><input type="text" class="form-control" name="poLotno" id="poLotno" readonly="readonly" value="${prPerVo.poLotno}"/></td>
											</tr>
											<tr>
												<th>거래처</th>
												<td><input type="text" class="form-control" name="relCompony" id="relCompony" value="${prPerVo.relCompony}"/></td>
												<th>납품처</th>
												<td><input type="text" class="form-control" name="relDel" id="relDel" value="${prPerVo.relDel}"/></td>
											</tr>
											<tr>
												<th>주문번호</th>
												<td><input type="text" class="form-control" name="relEsno" id="relEsno" readonly="readonly" value="${prPerVo.relEsno}"/></td>
												<th>공정번호</th>
												<td><input type="text" class="form-control" name="relPrno" id="relPrno" readonly="readonly" value="${prPerVo.relPrno}"/></td>
											</tr>
											<tr>
												<th>수주구분</th>
												<td><input type="text" class="form-control" name="relOrType" id="relOrType" value="${prPerVo.relOrType}"/></td>
												<th>납기일</th>
												<td><input type="date" class="form-control" name="relNabgi" id="relNabgi" readonly="readonly" value="${prPerVo.relNabgi}"/></td>
											</tr>
											<tr>
												<th>수량</th>
												<td><input type="text" class="form-control" name="relQty" id="relQty" value="${prPerVo.relQty}"/></td>
												<th>판매단가</th>
												<td><input type="text" class="form-control" name="relUnit" id="relUnit" value="${prPerVo.relUnit}"/></td>
											</tr>
											<tr>
												<th>금액</th>
												<td><input type="text" class="form-control" name="relPrice" id="relPrice" value="${prPerVo.relPrice}"/></td>
												<th>품명</th>
												<td><input type="text" class="form-control" name="relProd" id="relProd" value="${prPerVo.relProd}"/></td>
											</tr>
											<tr>
												<th>재질</th>
												<td><input type="text" class="form-control" name="relTexture" id="relTexture" value="${prPerVo.relTexture}"/></td>
												<th>두께</th>
												<td><input type="text" class="form-control" name="relThickness" id="relThickness" value="${prPerVo.relThickness}"/></td>
											</tr>
											<tr>
												<th>규격</th>
												<td><input type="text" class="form-control" name="relStandard" id="relStandard" value="${prPerVo.relStandard}"/></td>
												<th>상태</th>
												<td><input type="text" class="form-control" name="relState" id="relState" value="${prPerVo.relState}"/></td>
											</tr>
											<tr>
												<th>성적서일자</th>
												<td><input type="text" class="form-control" name="relReport" id="relReport" readonly="readonly" value="${prPerVo.relReport}"/></td>
												<th>완료일자</th>
												<td><input type="text" class="form-control" name="relCompletion" id="relCompletion" readonly="readonly" value="${prPerVo.relCompletion}"/></td>
											</tr>
											<tr>
												<th>담당자</th>
												<td><input type="text" class="form-control" name="relPerson" id="relPerson" value="${prPerVo.relPerson}"/></td>
												<th>출고일</th>
												<td><input type="date" class="form-control" name="relClgo" id="relClgo" value="${prPerVo.relClgo}"/></td>
											</tr>
											<tr>
												<th>비고</th>
												<td colspan="3"><textArea name="relNote1" id="relNote1" ></textArea></td>
											</tr>
										</tbody>
	                                </table>
                                </form>
                                <div class="btn_bottom_wrap">
									<button type="submit" class="btn_ok" onclick="fn_modify_prPerfomance()" style="border:none;">확인</button>
									<span class="btn_cancel" onclick="location.href='${pageContext.request.contextPath}/sl/basicInfo/prPerformance/prPerformanceList.do'">취소</span>
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
	function fn_modify_prPerfomance(){
		var num =  /^[0-9.]+$/;
		
		if($('#poLotno').val() == ""){
			alert("로트번호를 확인 바랍니다.");
			return;
		}
		
		if($('#orId').val() == ""){
			alert("수주번호를 확인 바랍니다.");
			return;
		}
		
		if($('#relIdx').val() == ""){
			alert("생산실적번호를 확인 바랍니다.");
			return;
		}
		
		modifyForm.submit();
	}
	
	function cal(){
		var price =  parseFloat(document.getElementsByClassName('relPrice')[0].value);
		var tax = price * 0.1;
		var total = price + tax;
		
		$('#relTax').val(tax);
		$('#relTotalPrice').val(total);
	}
	
	$(function() {
		$('#basicInfoMenu').addClass("active");
		$('#basicInfo').addClass("show");
		$('#prPerformanceList').addClass("active");
		
		let msg = '${msg}';
		if(msg) {
			alert(msg);
		}
		$('.relPrice').focusout(function(){
			cal();
		});
	});
	
	
	</script>
</body>

</html>