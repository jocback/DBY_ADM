<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/xhtml; charset=utf-8" />
 	<script type="text/JavaScript">
 	var result = '${upResult.result}';
 	var msg = '${upResult.msg}';
 	var CKEditorFuncNum = '${upResult.CKEditorFuncNum}';
 	var fileFullNm = '${upResult.unqFileNm}';
 	fileFullNm = fileFullNm.replace("//","/");
 	
 	if(result == "success"){
 		window.parent.CKEDITOR.tools.callFunction(CKEditorFuncNum, fileFullNm);
 	}else{
 		alert(msg);
 	}
	</script>
</head>
<body>
</body>
</html>
