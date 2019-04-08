<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<c:url value="/" var="path" />
<meta charset="UTF-8" />
<title>dd</title>
<link rel='stylesheet' href='${path }js/ol.css' type='text/css'>

<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="${path }js/proj4js-2.3.14.js"></script>

<script src="${path}js/ol-debug.js"></script>
<style>
</style>



</head>
<body>
	<div>
		<input type='button' value='WMS' class='bt' /><input type='button'
			value='WFS' class='bt' /> <input type='button' value='heat'
			class='bt' /> <input type='text' id='input1' /><input type='button'
			value='전송?' class='subBtn' />
	</div>
	<div id='map'
		style="width: 1000px; height: 1000px; background-color: blue;">
	</div>
	<form>
		<label>cluster distance</label> <input id="distance" type="range"
			min="0" max="100" step="1" value="40" /> <label>radius size</label>
		<input id="radius" type="range" min="1" max="50" step="1" value="5" />
		<label>blur size</label> <input id="blur" type="range" min="1"
			max="50" step="1" value="15" />
	</form>
	<script type="text/javaScript">
// 	Proj4js.defs["EPSG:5181"]="+proj=tmerc +lat_0=38 +lon_0=127 +k=1 +x_0=200000 +y_0=500000 +ellps=GRS80 +units=m +no_defs";
	var epsg5181="+proj=tmerc +lat_0=38 +lon_0=127 +k=1 +x_0=200000 +y_0=500000 +ellps=GRS80 +units=m +no_defs";
// 	proj4.defs("EPSG:5181",epsg5181);
// 	ol.proj.get('EPSG:5181').setExtent([-30000, -60000, 494288, 988576]);
// 	var projection = new ol.proj.Projection({
//         code: 'EPSG:5181',
//         extent:[-30000, -60000, 494288, 988576],
//         units: 'm'
//     });
// 	ol.proj.addProjection(projection)
// 	ol.proj.transform([126.947021, 37.553288], 'EPSG:5181', 'EPSG:3857');
		var distance = document.getElementById('distance');
		var blur = document.getElementById('blur');
		var radius = document.getElementById('radius');
		console.log("dd")
		console.log($('#div'))
		/*var testJson={
		aa:1,
		bb:2,
		cc:function(param){
		alert(param);
		} 
		}
		testJson.cc('aa');
		 */
	
		var map = new ol.Map({
			target : 'map',
			layers : [ new ol.layer.Tile({
				source : new ol.source.OSM()
			})

			],
			view : new ol.View({
				center : ol.proj.transform([ 126.947021, 37.553288 ],
						'EPSG:4326', 'EPSG:3857'),
				zoom : 10
// 				extent:ol.proj.transformExtent([4,46,16,56],'EPSG:5181',epsg5181)
			}),
			controls : ol.control.defaults()
					.extend(
							[ new ol.control.FullScreen(),
									new ol.control.ZoomSlider() ])

		});

		var styleCache = {};

		var wfsSample = new ol.layer.Vector(
				{
					source : new ol.source.Cluster(
							{
								distance : parseInt(distance.value, 10),
								source : new ol.source.Vector(
										{
											url : function(extent) {
												return 'http://localhost:8080/geoserver/wfs?service=WFS&version=1.1.0&request=GetFeature&srsname=EPSG:3857&typename=test:building_point&outputFormat=application/json&maxfeatures=10000'
											},
											format : new ol.format.GeoJSON()
										})
							}),
					style : function(feature) {
						console.log(feature)
						console.log("aaa")
						var size = feature.get('features').length;
						console.log(size);
						var style = styleCache[size];
						if (!style) {
							style = new ol.style.Style({
								image : new ol.style.Circle({
									radius : 10,
									stroke : new ol.style.Stroke({
										color : '#fff'
									}),
									fill : new ol.style.Fill({
										color : 'rgba(130, 207, 255,0.4)'
									})
								}),
								text : new ol.style.Text({
									text : size.toString(),
									fill : new ol.style.Fill({
										color : '#fff'
									})
								})
							});
							styleCache[size] = style;
						}
						return style;
					}
				})
		var wfsFire = new ol.layer.Vector(
				{
								/* distance : parseInt(distance.value, 10), */
								source : new ol.source.Vector(
										{
											url : function(extent) {
												return 'http://localhost:8080/geoserver/wfs?service=WFS&version=1.1.0&request=GetFeature&srsname=EPSG:3857&typename=test:store_buffer4&outputFormat=application/json&maxfeatures=10000'
											},
											format : new ol.format.GeoJSON()
										})
				})


		/*,
		style : new ol.style.Style({
			stroke : new ol.style.Stroke({
				color : 'black',
				width : 1
			}),
			fill: new ol.style.Fill({
				color: 'green',
				opacity: 0.5
			})
		})
		 */
		var heatMap = new ol.layer.Heatmap(
				{
					source : new ol.source.Vector(
							{
								url : function(extent) {
									return 'http://localhost:8080/geoserver/wfs?service=WFS&version=1.1.0&request=GetFeature&srsname=EPSG:3857&typename=test:building_point&outputFormat=application/json&maxfeatures=10000'
								},
								format : new ol.format.GeoJSON()
							}),
					blur : parseInt(blur.value, 10),
					radius : parseInt(radius.value, 10)
				});
		heatMap.getSource().on('addfeature', function(event) {

			var name = event.feature.getGeometryName();
			console.log(name);
			var magnitude = parseFloat(name.substr(2));
			event.feature.set('weight', magnitude - 5);
		})

		var wmsSample = new ol.layer.Tile({
			source : new ol.source.TileWMS({
				url : 'http://localhost:8080/geoserver/wms',
				params : {
					'LAYERS' : 'test:sgg_emd_group'
				}
			})
		});
		//map.addLayer(wfsSample);
		var mousePointerCoord = function(event) {
			var coord3857 = event.coordinate;
			var coord5181 = ol.proj.transform(coord3857, 'EPSG:3857',
					'EPSG:4326')
			//console.log('coord3857'+coord3857+',coord5181:'+coord5181);
		}
		map.on('pointermove', mousePointerCoord);
		$('.bt').on('click', function() {
			var btnVal = $(this).val();
			var arr = new Array();
			if (btnVal == "WMS") {
				console.log(map.getLayers)
				arr = map.getLayers();
				console.log(arr);
				console.log("aa");
				map.removeLayer(wfsSample);
				map.addLayer(wmsSample);

			} else if (btnVal == "WFS") {
				map.removeLayer(wmsSample);
				map.removeLayer(wfsSample);
// 				var old=wfsFire.getSource().getProjection().getCode();
// 				ol.proj.transformExtent(ol.proj.get("EPSG:3857").getExtent(),old,'EPSG:5181')
				map.addLayer(wfsFire);
// 				map.addLayer(wfsSample);
			} else {
				map.addLayer(heatMap);
			}

		})
		$('.subBtn').on('click', function() {
			var input = $('#input1').val();
			console.log(input);
			var param = "";
			switch (input) {
			case "읍면동":
				param = "admin_emd"
				break;
			case "시군구":
				param = "admin_sgg"
				break;

			}
			map.removeLayer(wmsSample);
			wmsSample = new ol.layer.Tile({
				source : new ol.source.TileWMS({
					url : 'http://localhost:8080/geoserver/wms',
					params : {
						'LAYERS' : 'test:' + param
					}
				})
			});
			map.addLayer(wmsSample);

		})
		distance.addEventListener('input', function() {
			wfsSample.getSource().setDistance(parseInt(distance.value, 10));
		});
		blur.addEventListener('input', function() {
			heatMap.setBlur(parseInt(blur.value, 10));
		});

		radius.addEventListener('input', function() {
			heatMap.setRadius(parseInt(radius.value, 10));
		});
	</script>
</body>

</html>