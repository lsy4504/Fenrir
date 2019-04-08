<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <c:url value="/" var="path" />
    <div>
	<div id='map' style="position: absolute; left: 0px; top: 0px; z-index: 2; width: 100%; height: 100%; margin: 0; padding: 0;">
	</div> 
	<div id="popup" class="ol-popup">
    	<a href="#" id="popup-closer" class="ol-popup-closer"></a>
   	 <div id="popup-content"></div>
   </div>
   </div>
   <script type="text/javascript">
	var geoServer='${myURL}';	
	var webServer='${path}/';	
	</script>
	<!--초기 네이버 맵 js  -->
   <script src="${path}/js/naverMap.js"></script>
	<!--인구 히트맵 js  -->
   <script src="${path}/js/inguHeatMap.js"></script>
   <!--읍면동 지가 js  -->
   <script src="${path}/js/emdJIga.js"></script>
   <!--맵 관련 이벤트  -->
   <script src="${path}/js/mapEvent.js"></script>
   <!--맵 그려주기 위한 js  -->
   <script src="${path}/js/mesure.js"></script>
   <!--분석용 지가 js  -->
   <script src="${path}/js/inguJigaModal.js"></script>
   
   <script src="${path}/js/anal.js"></script>
   <script src="${path}/js/etc.js"></script>
   <script src="https://unpkg.com/ol-contextmenu"></script>
	<script src="${path}/js/contextmenu.js"></script>
	<script src="${path}/js/jijuckdo.js"></script>
	<script src="${path}/js/happyCity.js"></script>
