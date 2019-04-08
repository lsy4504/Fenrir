/**
 * 지적도 js입니다 .
 *
 */
/**
 * 년도와 특정동의 지적도  
 */
var selJijuckdoLayer;
var cnt=1;
$('#emdBtn').on('click',function() {
	map.removeLayer(selJijuckdoLayer)
	var emdName = $('#emd_Name').val();
	var url = $('#year').val();
	var features = [];
	selJijuckdoLayer = new ol.layer.Vector({
		source : new ol.source.Vector({
			url : function(extent) {
					return geoServer+"wfs?service=WFS&version=1.1.0&request=GetFeature&srsname=EPSG:3857&typename="+url+"&outputFormat=application/json&maxfeatures=300000&cql_filter=emd_nm LIKE'"
							+ emdName + "'";
					},
			format : new ol.format.GeoJSON()
			}),
			style:function(feature){
				feature.set('name','jijuckdo');
				return jijuckdoStyleFunc(feature);
			},
			maxResolution:20,
			minResolution:0
			
		});
		selJijuckdoLayer.set('name', 'emdJigaInfo');
		//emd info 에 센터로이드 넣어서 가져와서 해보장
		map.addLayer(selJijuckdoLayer);
		
		


		$.ajax({
					url : geoServer+"wfs?service=WFS&version=1.1.0&request=GetFeature&srsname=EPSG:3857&typename=geumbang:emd_14_5174&outputFormat=application/json&maxfeatures=10000&cql_filter=emd_nm LIKE'"
							+ emdName + "'",
					dataType : 'json',
					success : function(data) {
						console.log(data.features[0].properties.center.coordinates);
						var coord = data.features[0].properties.center.coordinates
						var lonlat = ol.proj.transform(
								coord, 'EPSG:3857',
								'EPSG:4326');
						var center = ol.proj.transform([
								lonlat[0], lonlat[1] ],
								'EPSG:4326', 'EPSG:3857');
						view.setCenter(center);
						view.setZoom(15)
					}
				});

});
function jijuckdoStyleFunc(feature){
	var jiga=feature.get('jiga');
	var jibun=feature.get('jibun');
	var fill;
	if(jiga <10000){
		fill='rgb(255, 219, 219,0.4)';
	}else if(jiga>=10000 && jiga <30000){
		fill='#ffc3c3';
	}else if(jiga>=30000 && jiga <70000){
		fill='#ff7171';
	}else if(jiga>=70000 && jiga <120000){
		fill='#ff4141';
	}else if(jiga>=120000 && jiga <200000){
		fill='#ff1919';
	}else if(jiga>=200000){
		fill='#b40000';
	}
	var style=new ol.style.Style({
		fill: new ol.style.Fill({
			color:fill,
		}),
		stroke:new ol.style.Stroke({
			color:'rgba(35, 35, 35,0.2)',
			width:1,
			lineJoin : 'bevel'
		})
	})
	return style;
}
function baseJijuckdoFunc(){
	
}
