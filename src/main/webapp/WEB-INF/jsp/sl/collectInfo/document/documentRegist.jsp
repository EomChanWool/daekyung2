<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<%@ include file="../../header.jsp" %>
<style>
	.table th{
		padding-top: 1.3rem;
	}
	
	.val-area{
		text-align: left;
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
                        <!-- Nav document - User Information -->
                        <%@ include file="../../menu/logout/nav_user.jsp" %>
                    </ul>
                </nav>
                <!-- End of Topbar -->

                <!-- Begin Page Content -->
                <div class="container-fluid">
                    <!-- Page Heading -->
                    <h1 class="h3 mb-2 text-gray-800">문서 등록</h1>
                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-body">
                            <div class="table-responsive">
                            	<form action="${pageContext.request.contextPath}/sl/sales/document/registDocumentOk.do" name="registForm" method="post" encType="multipart/form-data">
	                                <table class="table table-bordered" id="dataTable">
	                                    <tbody>
											<tr>
												<th>문서종류  <span class="req">*</span></th>
												<td>
													<select class="form-control" name="doType" id="doType">
														<option value="">선택</option>
														<option value="견적서">견적서</option>
														<option value="발주서">발주서</option>
														<option value="납품확인서">납품확인서</option>
														<option value="세금계산서">세금계산서</option>
														<option value="기타">기타</option>
													</select>
												</td>
												<th>문서명  <span class="req">*</span></th>
												<td><input type="text" class="form-control" name="doName" id="doName"></td>
											</tr>
											<tr>
												<th>작성자  <span class="req">*</span></th>
												<td colspan="3"><input type="text" class="form-control" name="doWriter" id="doWriter"></td>
											</tr>
											<tr>
												<th>비고</th>
												<td colspan="3"><textarea name="doNote"></textarea></td>
											</tr>
											<tr>
												<th>파일업로드</th>
												<td colspan="3">
													<label class="file_label" for="input_file">업로드</label>
													<input type="text" class="form-control file-name-form" id="fileName" readonly="readonly">
													<input type="file" name="uploadFile" id="input_file" style="display: none;">
												</td>
											</tr>
										</tbody>
	                                </table>
                                </form>
                                <div class="btn_bottom_wrap">
									<button type="submit" class="btn_ok" onclick="fn_regist_document()" style="border:none;">확인</button>
									<span class="btn_cancel" onclick="location.href='${pageContext.request.contextPath}/sl/sales/document/documentList.do'">취소</span>
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
	function fn_regist_document(){
		if($('#doType').val() == ''){
			alert("문서 종료를 확인 바랍니다.");
			return;
		}
		
		if($('#doName').val() == ''){
			alert("문서명을 확인 바랍니다.");
			return;
		}
		
		if($('#doWriter').val() == ''){
			alert("작성자를 확인 바랍니다.");
			return;
		}
		
		registForm.submit();
	}
	
	$(function() {
		$('#salesMenu').addClass("active");
		$('#sales').addClass("show");
		$('#documentList').addClass("active");
		
		let msg = '${msg}';
		if(msg) {
			alert(msg);
		}
		
		$('#input_file').change(function(){
			$('#fileName').val($('#input_file').val().split('\\')[2]);
		});
	});
	</script>
</body>

</html>