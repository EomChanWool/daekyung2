<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<%@ include file="../../header.jsp" %>

<body id="page-top">
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/echarts@5.4.1/dist/echarts.min.js"></script>
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

                        <!-- Nav kpi - User Information -->
                        <%@ include file="../../menu/logout/nav_user.jsp" %>

                    </ul>

                </nav>
                <!-- End of Topbar -->

                <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading -->
                    <h1 class="h3 mb-2 text-gray-800">절단공정정보관리</h1>

                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
							<div class="search">
								<form name ="listForm" class="listForm" action="${pageContext.request.contextPath}/sl/collectInfo/cutting/cuttingList.do" method="post">
									<input type="hidden" name="csIdx">
									<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
									<input type="text" class="form-control bg-light border-0 small" name="searchKeyword"
						    									value="${searchVO.searchKeyword}" placeholder="품명을 입력해 주세요"
						    									style="background-color:#eaecf4; width: 25%; float: left;">
						    		<select class="btn btn-secondary dropdown-toggle searchCondition" name="searchCondition" id="searchCondition">
						    			<option value="" <c:if test="${searchVO.searchCondition eq ''}">selected="selected"</c:if>>전체</option>
						    			<option value="2023" <c:if test="${searchVO.searchCondition eq '2023'}">selected="selected"</c:if>>2023년</option>
						    			<option value="2024" <c:if test="${searchVO.searchCondition eq '2024'}">selected="selected"</c:if>>2024년</option>
						    			<option value="2025" <c:if test="${searchVO.searchCondition eq '2025'}">selected="selected"</c:if>>2025년</option>
						    			<option value="2026" <c:if test="${searchVO.searchCondition eq '2026'}">selected="selected"</c:if>>2026년</option>
						    		</select>
						    		
						    		<select class="btn btn-secondary dropdown-toggle searchCondition" name="searchCondition2" id="searchCondition2">
							    		<option value="">선택</option>
							    		<c:forEach begin="1" end="12" varStatus="status">
							    			<option value="${status.count}" <c:if test="${searchVO.searchCondition2 eq status.count}">selected="selected"</c:if>>${status.count}월</option>
							    		</c:forEach>
						    		</select>
						    	</form>
						    	<a href="#" class="btn btn-info btn-icon-split" onclick="fn_search_cutting()" style="margin-left: 0.3rem;">
	                                <span class="text">검색</span>
	                            </a>
						    	<a href="#" class="btn btn-success btn-icon-split" onclick="fn_searchAll_cutting()">
	                                <span class="text">당월</span>
	                            </a>
	                            <a href="#" class="btn btn-primary btn-icon-split" onclick="fn_regist_cutting()" style="float: right;">
	                                <span class="text">등록</span>
	                            </a>
							</div>
                        </div>
                        <div id="graph" style="width: 100%; height:300px;"></div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable"  >
                                    <thead>
                                        <tr>
                                        	<th>설비</th>
                                            <th>품명</th>
											<th>절단모델</th>
											<th>반경</th>
											<th>두께</th>
											<th>갭 설정</th>
											<th>생산량</th>
											<th>배길이</th>
											<th>작업시간</th>
											<th>동작시간</th>
											<th>수정/삭제</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    	<c:forEach var="result" items="${cuttingList}" varStatus="status">
	                                   		<tr>
	                                            <td>${result.eqSensorid}</td>
												<td>${result.csProdName}</td>
												<td>${result.csModel}</td>
												<td>${result.csRadius}</td>
												<td>${result.csThickness}</td>
												<td>${result.csGap}</td>
												<td>${result.csQty}</td>
												<td>${result.csLong}</td>
												<c:if test="${empty result.csWorkTime}"><td>없음</td></c:if>
												<c:if test="${not empty result.csWorkTime}"><td>${result.csWorkTime}초</td></c:if>
												
												<td><fmt:formatDate value="${result.csRegDate}" pattern="yyyy-MM-dd HH:mm"/></td>
												<td style="padding: 5px 0px;">
	                                            	<a href="#" class="btn btn-warning btn-icon-split" onclick="fn_modify_cs_go('${result.csIdx}')">
				                                        <span class="text">수정</span>
				                                    </a>
				                                    <a href="#" class="btn btn-danger btn-icon-split" onclick="fn_delete_cs('${result.csIdx}')">
				                                        <span class="text">삭제</span>
				                                    </a>
	                                            </td>
	                                            
	                                        </tr>
                                    	</c:forEach>
                                    	<c:if test="${empty cuttingList}"><tr><td colspan='11'>결과가 없습니다.</td><del></del></c:if>
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
		
		function fn_search_cutting(){
			listForm.pageIndex.value = 1;
			listForm.submit();
		}
		
		function fn_searchAll_cutting(){
			listForm.searchKeyword.value = "";
			listForm.searchCondition.value = "";
			listForm.searchCondition2.value = "";
			listForm.pageIndex.value = 1;
			listForm.submit();
		}
		
		function fn_regist_cutting(){
			listForm.action = "${pageContext.request.contextPath}/sl/collectInfo/cutting/registCutting.do";
			listForm.submit();
		}
		
		function fn_modify_cs_go(idx){
			listForm.csIdx.value = idx;
			listForm.action = "${pageContext.request.contextPath}/sl/collectInfo/cutting/modifyCutting.do";
			listForm.submit();
		}
		
		function fn_delete_cs(csData09){
			if(confirm('해당 내역을 삭제하시겠습니까?')) {
				listForm.csData09.value = csData09;
				listForm.action = "${pageContext.request.contextPath}/sl/collectInfo/cutting/deleteCutting.do";
				listForm.submit();
			}
		}
		
		$(function() {
			$('#collectInfoMenu').addClass("active");
			$('#collectInfo').addClass("show");
			$('#cuttingList').addClass("active");
			
			let msg = '${msg}';
			if(msg) {
				alert(msg);
			}
			
			$('#searchCondition').change(function(){
				listForm.submit();
			});
			$('#searchCondition2').change(function(){
				listForm.submit();
			});
			
			
			window.onresize = function() {
				location.reload();
			}
		});
			
	
		var chartDom = document.getElementById('graph');
		var myChart = echarts.init(chartDom);
		var option;
		
		let date = [];

		let OutputData = [];
		
		let viewData = [];
		
		
		for(var i=1;i<=31;i++){
			date.push(i+"일");
			OutputData.push(0);
			viewData.push(0);
		}
		
		<c:forEach items="${sensorData}" var="list">
		OutputData[${list.days-1}] = ${list.workTime};
		</c:forEach> 
		
		
		
		
		
		option = {
		  animation: false,
		  xAxis: {
		    type: 'category',
		    name: '일별',
		    data: date
		  
		  },
		  yAxis: {
		    type: 'value',
		    name: '작업시간(초)'
		  },
		  tooltip: {
			    trigger: 'axis', 
			    formatter: function (params) {
			      var xValue = params[0].name;
			      var yValue = params[0].value;
			      return '<span style="font-weight: bold; letter-spacing: 4.7px;">작동시간(초):</span>' + yValue;
			    }
			  },
		  series: [
		    {
		      data: OutputData,
		      type: 'line',
		      smooth: true
		    }
		  ]
		};

		option && myChart.setOption(option);
		
	</script>
</body>

</html>