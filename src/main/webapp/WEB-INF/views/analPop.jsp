<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html >
<html>
<head>
<meta charset="UTF-8">
<c:url value="/" var="path"></c:url>

<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-slider/10.6.1/css/bootstrap-slider.css" />
	<link href="${path }css/main.css" rel="stylesheet">
	<link href="${path }css/left.css" rel="stylesheet">
	<link href="${path }css/tooltip.css" rel="stylesheet">
	<link href="${path }css/popup.css" rel="stylesheet">
	<link href="${path }css/rSlider.min.css" rel="stylesheet">
	<link rel='stylesheet' href='${path }js/ol.css' type='text/css'>
	<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
 	<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-slider/10.6.1/bootstrap-slider.js"></script>
	<script src="https://cdn.polyfill.io/v2/polyfill.min.js?features=requestAnimationFrame,Element.prototype.classList,URL"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
	<script src="${path }js/proj4js-2.3.14.js"></script>
	<script src="${path}js/ol-debug.js"></script>
	<script src="${path}js/rSlider.min.js"></script>
	<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/echarts/4.2.1/echarts.js"></script>
	<style type="text/css">
		.analGrap1{
			position: absolute;
			left:40%;
			top: 5%;
		}
	
	</style>
</head>
<body>

<div style="width: 500px;height: 500px;" id="map"></div>
<div class="slider-container"  style="width: 250px; margin: 15px;" id="slider_container" >
    	<input type="text" id="slider" class="slider" />
    	<input type="button" value="검색" id="submit" class="btn btn-info"> 
</div>
<div id="over"></div>
<input type="hidden" id="analStartYear">
<input type="hidden" id="analEndYear">
<div id="analGrap1" style="width: 1000px; height: 500px;" class='analGrap1'>
</div>
<div id="inguChart1" style="width:1000px; height: 500px;"></div>
<div id="my1" style="width:900px; height: 300px;"></div>
<script src="${path}js/rSlider.min.js"></script>
<script type="text/javascript">
var geoServer='${myURL}';
function styleFunc(emd_nm){
	console.log(emd_nm)
var nonStyle=new ol.style.Style({
	fill:new ol.style.Fill({
		color:'#35c6ff'
	}),
	stroke:new ol.style.Stroke({
		color:'#b701ff',
		width:1
	}),
	text : new ol.style.Text({
		font:"10px bold",
		text : String(emd_nm),
		fill : new ol.style.Fill({
			color : 'black'
		}),
		textAlign:'center'
	})
})
return nonStyle;
}
var view =  new ol.View({
	// 			projection:'EPSG:5174',
	
	center : ol.proj.transform([ 127.3, 36.5 ],
			'EPSG:4326', 'EPSG:3857'),
	zoom :10
});

	var map = new ol.Map({
		  view: view,
		  layers:[],
		  target: 'map',
		  controls : ol.control.defaults()
			.extend(
					[ new ol.control.FullScreen(),
							new ol.control.ZoomSlider() ])
		});
	
	var overlayer;
	var analEmdWfs=new ol.layer.Vector({
		 source:new ol.source.Vector({
			 url : function(extent) {
					return geoServer+'wfs?service=WFS&version=1.1.0&request=GetFeature&srsname=EPSG:3857&typename=geumbang:pop&outputFormat=application/json&maxfeatures=10000'
				},
			format : new ol.format.GeoJSON()
		 }),
			style:function(feature){
				console.log(feature)
				var emd_nm=feature.getProperties().emd_nm;
				var style=styleFunc(emd_nm);
				console.log(style)
				addOverLay(feature);
				return style;
			}
		
		 
	 });
	 map.addLayer(analEmdWfs);
	 analEmdWfs.set('name','anal');
	 console.log('aa')
function addOverLay(feature){
		 var coord=feature.getProperties().center.coordinates;
		 var emd_nm=feature.getProperties().emd_nm;
		 var element="<div id='"+emd_nm+"' class='cagrInfoDiv'><p style='font-size: 8px; font-weight: bold; margin-bottom: 0;'>"+emd_nm+"</p>"
			+"</div>";
		$("#over").html(element);
		console.log(document.getElementById(emd_nm))
		overlayer= new ol.Overlay({
			element:document.getElementById(emd_nm),
			positioning: 'center-center',
			position:coord
		});
		console.log(coord)
		map.addOverlay(overlayer);
		$("#over").html("");
	 }
function addLayera(){
	map.getLayers().forEach(function(layer){
		console.log(layer)
		
		})

}
var init = function () {                
		    var slider = new rSlider({
		        target: '#slider',
		        values: [2014, 2015, 2016, 2017, 2018],
		        range: true,
		        set: [2017, 2018],
		        onChange: function (vals) {
		            console.log(vals);
		            var yearArry=[];
		            yearArry=(vals.split(','))
		            //여기서부터하시면됩니다.
		            $('#analStartYear').val(yearArry[0]);
		            $('#analEndYear').val(yearArry[1]);
		           
		        }
		    });
		    
		};
		window.onload = init; 
		    addLayera()
	var clickStyle=new ol.style.Style({
		fill:new ol.style.Fill({
			color:'#e9e753',
			opacity:0.6
		}),
		stroke:new ol.style.Stroke({
			color:'#f22008',
			width:1
		})
	});	
	var selFeatures=[];
	map.on('click',function(evt){
		console.log(evt)
		
		var feature=map.forEachFeatureAtPixel(evt.pixel,function(feature){
			return feature;
		});
		console.log()
		var emd_nm=feature.getProperties().emd_nm;
		console.log(emd_nm)
		var flag=$.inArray(emd_nm,selFeatures);
		if(flag==-1){
			selFeatures.push(emd_nm);
			feature.setStyle(clickStyle);
		}else{
			feature.setStyle(styleFunc(emd_nm));
			selFeatures.splice(flag,1);
		}
		console.log(selFeatures)
		
	})
	
	$('#submit').on('click',function(){
		var startYear=$('#analStartYear').val().substr(2,4);
        var endYear=$('#analEndYear').val().substr(2,4);
		$.ajax({
			url:"${path}anal/getSelectData.do?selFeatures="+selFeatures,
			data:{
				start:startYear,
				end:endYear
			},
			success:function(data){
				$("#analGrap1").html(data)
			}
		})
	})
</script>        



   

</body>
</html>