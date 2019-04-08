	<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	
	<html>
	<head>
	<c:url value="/" var="path"  />
	<meta charset="UTF-8">
	
	<link href="${path }css/main.css" rel="stylesheet">
	<link href="${path }css/left.css" rel="stylesheet">
	<link href="${path }css/tooltip.css" rel="stylesheet">
	<link href="${path }css/popup.css" rel="stylesheet">
	<link rel='stylesheet' href='${path }js/ol.css' type='text/css'>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	<script src="https://cdn.polyfill.io/v2/polyfill.min.js?features=requestAnimationFrame,Element.prototype.classList,URL"></script>
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
	<%-- <script type="text/javascript" src="${path }js/ol.js"></script> --%>
	<script src="${path }js/proj4js-2.3.14.js"></script>
	<link href="${path }css/rSlider.min.css" rel="stylesheet">
	<script src="${path}js/ol-debug.js"></script>
	<style type="text/css">
		.cagrInfoDiv {
			border-radius:5px;
			background: rgba(80, 88, 186,0.5);
			color: white;
			width: 60px;
			height: auto;
			padding-left: 5px;
			
		}
	</style>	
	
	<title>Insert title here</title>
	</head>
	<body>
	<div class="cagrInfoDiv">
		<p style='font-size: 17px; font-weight: bold; margin-bottom: 0;'>한번만</p>
		<p style='font-size: 25px; font-weight: bold; margin-bottom: 0;'>17%</p>
	</div>
	
	</body>
	</html>