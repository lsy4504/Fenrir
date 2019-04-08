<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html >
<html>
<head>

<c:url value="/" var="path" />
<!-- bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-slider/10.6.1/css/bootstrap-slider.css" />
<!-- customCss -->
<link href="${path }/css/main.css" rel="stylesheet">
<link href="${path }/css/left.css" rel="stylesheet">
<link href="${path }/css/slider.css" rel="stylesheet">
<!-- map css  -->
<link href="${path }/css/tooltip.css" rel="stylesheet">
<link href="${path }/css/popup.css" rel="stylesheet">
<link href="https://unpkg.com/ol-contextmenu/dist/ol-contextmenu.min.css" rel="stylesheet">
<link href="${path }/css/contextmenu.css" rel="stylesheet">
<link rel='stylesheet' href='${path }/js/ol.css' type='text/css'>
<!--dataTable  -->
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.css">
<!--google font  -->
<link href="https://fonts.googleapis.com/css?family=Jua" rel="stylesheet">  
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
	integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
	crossorigin="anonymous"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-slider/10.6.1/bootstrap-slider.js"></script>
<script
	src="https://cdn.polyfill.io/v2/polyfill.min.js?features=requestAnimationFrame,Element.prototype.classList,URL"></script>
<script src="${path }/js/proj4js-2.3.14.js"></script>
<script src="${path}/js/ol-debug.js"></script>
 
<script type="text/javascript" src="${path}/js/leftMenu.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.js"></script>
<script src="https://cdn.datatables.net/buttons/1.5.1/js/dataTables.buttons.min.js"></script> 

<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script> 

<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/pdfmake.min.js"></script> 

<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/vfs_fonts.js"></script> 

<script src="https://cdn.datatables.net/buttons/1.5.1/js/buttons.html5.min.js"></script> 

<script src="https://cdn.datatables.net/buttons/1.5.1/js/buttons.print.min.js"></script>




<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	select {
	
	    width: 200px; /* 원하는 너비설정 */
	    padding: .8em .5em; /* 여백으로 높이 설정 */
	    font-family: inherit;  /* 폰트 상속 */
	    font-size:13px;
	    border: 1px solid #999;
	    border-radius: 0px; /* iOS 둥근모서리 제거 */
	    -webkit-appearance: none; /* 네이티브 외형 감추기 */
	    -moz-appearance: none;
	    appearance: none;
	    margin-bottom: 5px;
	}
</style>	 
</head>
<body>
	<div class="left" id="left" style="z-index: 1023">
		<jsp:include page="/form/left.jsp"></jsp:include>
	</div>
	<div id="main" >
		<span
			style="font-size: 30px; cursor: pointer; z-index: 1024; position: absolute; left: 50px;"
			onclick="openNav()" flag='0' id='side'>&#9776;</span>
	</div>
	<div class="right">
		<div class='right_emd'>
			<input type="button" value="행정" class="btn btn-default"
				style="width: 50px; height: 50px;" flag='.emd_info' legend='emd' />
		</div>
		<div class='emd_info' style="height: 100px;">
			<input type="button" value="2초" id="emdTime" class="btn btn-info" style="margin-bottom: 10px;"><br>
			<input id="emd_info" type="range" data-provide="slider"
				data-slider-ticks="[1, 2, 3,4,5]"
				data-slider-ticks-labels='["2014년 ", "2015년", "2016년","2017년","2018년"]'
				data-slider-min="1" data-slider-max="5" data-slider-step="1"
				data-slider-value="1" data-slider-tooltip="hide" />
		</div>

		<div class='right_jijuckdo'>
			<input type="button" value="지가" class="btn btn-default"
				style="width: 50px; height: 50px;" flag='.emd_jiga' legend='jijuck'/>
		</div>
		<div class='right_heat'>
			<input type="button" value="인구" class="btn btn-default"
				style="width: 50px; height: 50px;" flag='.heat_ingu' />
		</div>
		<div class="emd_jiga">
			<select id='year' >
				<c:forEach items="${yearList}" var="year">
					<option value='${year.url}'>${year.year}</option>
				</c:forEach>
			</select> 
			<select id='emd_Name'>
				<c:forEach items="${emdList}" var="emd">
					<option value='${emd}'>${emd}</option>
				</c:forEach>
			</select> <input type="button" value="검색" id='emdBtn' class="btn btn-info"/>
		</div>
		<div class='heat_ingu'>
		<input type="button" value="2초" id="inguTime" class="btn btn-info" style="margin-right: 15px;">
			<input id="heat_ingu" type="range" data-provide="slider"
				data-slider-ticks="[1, 2, 3,4,5]"
				data-slider-ticks-labels='["2014년 ", "2015년", "2016년","2017년","2018년"]'
				data-slider-min="1" data-slider-max="5" data-slider-step="1"
				data-slider-value="1" data-slider-tooltip="hide" style="margin-left: 5px;"/> <br> <br>
			<label>radius
				size</label> <input id="radius" type="range" min="1" max="50" class="slider"
				step="1" value="5" /> <label>blur size</label> <input id="blur"
				type="range" min="1" max="50" class="slider" step="1" value="15" />
		</div>
		<div class='right_etc'>
			<input type="button" value="주변" class="btn btn-default" style="width: 50px; height: 50px;" flag='.etc_div'/>
		</div>
		<div class='etc_div'>
			<div class="checks etrans">
				<input type="checkbox" id='school_chk' name='check' value="school">
				<label for='school_chk'>학교</label>
				<input type="checkbox" id='movie_chk' name='check' value="movie">
				<label for='movie_chk'>영화관</label>
				<input type="checkbox" id='food_chk' name='check' value="food">
				<label for='food_chk'>휴게음식점</label>
				<input type="button" value="검색" id='check_btn' class="btn btn-info"/>
				<label>cluster distance</label> <input id="distance" type="range"
				min="0" max="100" class="slider" step="1" value="40" /> 
			</div>
			
		</div>
		<div class='right_reset'>
			<input type="button" value="리셋" class="btn btn-default"
				style="width: 50px; height: 50px;" flag="reset"/>
		</div>
	</div>
	<div class='measureDiv'>
		<div class='right_length'>
			<input type="button" value="거리" class="btn btn-default"
				style="width: 50px; height: 50px;" func='LineString' />
		</div>
		<div class='right_area'>
			<input type="button" value="면적" class="btn btn-default"
				style="width: 50px; height: 50px;" func='Polygon' />
		</div>
	</div>
	
	
	<jsp:include page="/form/content.jsp"></jsp:include>
	
	<script type="text/javascript">
// 	$(document).ready( function () {
    	
// 	} );

		var removeList = [];

		$(function() {
			$('.heat_ingu').toggle();
			$('.emd_info').toggle();
			$('.emd_jiga').toggle();
			$('.etc_div').toggle();
			$('.right').on('click', '.btn', function() {
				var onName = $(this).attr('flag');
				var legend = $(this).attr('legend');
				console.log(onName);
				 
				if(onName=="reset"){
					map.getLayers().forEach(function(layer) {
						console.log(layer.get('name'))
						var layerName=layer.get('name');
						if (layerName != null) {
							if(layerName=='makerLayer'){
								layer.getSource().getFeatures().forEach(function(feature){
									layer.getSource().removeFeature(feature)
								});
								return;
							}else{
								removeList.push(layer);
								
							}
						}
					});
					removeLayer(removeList);
					console.log('초기화완료!')
				}else{
					if (onName) {
						$(onName).toggle();
						console.log($(onName))
						if(legend=='emd' || legend=="jijuck"){
							var img=' <img alt="" src="./img/'+legend+'.png" class="img-thumbnail">';
							$(".legend").html(img);
							console.log($("#legendDiv").html());
							$('.closeLegend').css('display','block');
							$(this).attr('legend','close');
							
						}else if(legend=='close'){
							var leVar
								console.log("avc");
							if(onName==".emd_info"){
								console.log("??");
								leVar='emd';
							}
							else{
								leVar='jijuck';
							}
							console.log("뭐임??")
							$(".legend").html("");
							$('.closeLegend').css('display','none');
							$(this).attr('legend',leVar);
							
						}
					} 
				}
			});

		})
		function removeLayer(removeList) {
			$(".legend").html("");
			$('.closeLegend').css('display','noen');
			var end = removeList.length;
			for (var i = 0; i < end; i++) {
				var layer = removeList[i];
				map.removeLayer(layer);
			}
			remeveList = [];
			$('.ol-overlay-container').remove();
			map.removeInteraction(draw);
			//var features = data.features;
			drawSource.getFeatures().forEach(function(feature){
				console.log(feature)
				drawSource.removeFeature(feature);
				})
		}

		
		
	</script>

	
</body>
</html>