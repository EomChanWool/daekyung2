<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>(주) 대경벤드</title>

    <!-- Custom fonts for this template -->
    <link href="/resources/conf/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="/resources/conf/css/sb-admin-2.min.css" rel="stylesheet">

    <!-- Custom styles for this page -->
    <link href="/resources/conf/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script>
    
    
    
    $(function() {
		
    	var id1;
        var id2;
        var id3;
        var id4;
        
        setInterval(logApiGo, 137 * 60 * 1000);

		
		
		
	});
    
    function logApiGo(){
		
		
		$.ajax({
			  type:"POST",
			  url:"<c:url value='${pageContext.request.contextPath}/sl/basicInfo/member/logApi.do'/>",	  		  			  
			  dataType:"JSON",
			  data:{
				  
			  },
			  success:function(result){
				  
				  if(result.tr == true){
					  id1=result.res.logDt;
					  id2=result.res.useSe;
					  id3=result.res.sysUser;
					  id4=result.res.conectIp;
					  
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
					  
				  }else if(result.tr == false){
					  
					  console.log('폴스');
				  }
				  
				  
				  
			  },
			  error:function(request,status,error){ 
				  alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);		  
			  }
		  });
	}
    </script>

</head>
