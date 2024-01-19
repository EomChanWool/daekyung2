<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="header.jsp" %>
<body class="login_bg">
	<script src="/resources/conf/vendor/jquery/jquery.min.js"></script>
	<link type="text/css" rel="stylesheet" href="<c:url value='/resources/conf/css/login.css?ver=${sysTimes}' />" />
	<script>
		$(function() {
			const url = document.location.pathname;
			if(url.indexOf('main.do')==-1) {
				location.href = '${pageContext.request.contextPath}/sl/main.do';
			}
			
			let msg = '${msg}';
			if(msg.indexOf('비밀번호') != -1) {
					loginForm.password.focus();
			} else {
				loginForm.id.focus();
			}
			
			let API = '${API}';
			if(API){
				
				var id1 = '${APITIME}';
				var id2 = '${APINOTE}';
				var id3 = '${APIID}';
				var id4 = '${APIIP}';
				
				logoutApi(id1,id2,id3,id4);
			}
			
			
			if(msg) {
				alert(msg);
			}
		});
		
		
function logoutApi(id1,id2,id3,id4){
			
			var param = {
				    'crtfcKey' : "$5$API$/HjxvBFQc5Kbx7GK1o1nvZnhcCiFTnnxlUsTz5FWRg5",
				    'logDt' : id1,
				    'useSe' : id2,
				    'sysUser' : id3,
				    'conectIp' : id4,
				    'dataUsgqty' : "0"
				};

				$.ajax({
				    type : "POST",
				    url : "https://log.smart-factory.kr/apisvc/sendLogData.json",
				    cache : false,
				    timeout : 360000,
				    data : param,
				    dataType : "json",
				    beforeSend : function() {
				    },
				    success : function(data, textStatus, jqXHR) {
				        var result = data.result;
				        console.log(result);  // <-- 전송 결과 확인
				    },
				    error : function(jqXHR, textStatus, errorThrown) {
				    },
				    complete : function() {
				    }
				});
			
			
		}
		
	</script>
	
	<form name="loginForm" class="loginForm" action="${pageContext.request.contextPath}/sl/login.do" method="post">
		<div class="login_wrap">
			<div class="login">
				<div class="login_tit">
 					<span><img src="/resources/conf/images/dk2.png" style="width: 70px;"></span>
					<span class="login_txt">대경벤드</span>
				</div>
				<input type="text" name ="id" required="required" placeholder="아이디" class="adm_id">
				<input type="password" name ="password" required="required" placeholder="비밀번호" class="adm_pw">
				<button type="submit" id="loginBtn" class="btn_login">로그인</button>
			</div>
		</div>
	</form>
</body>
</html>