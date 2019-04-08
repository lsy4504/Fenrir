/**
 * 분석관련 js
 */
//팝업창을 띄워주기 위한 이벤트 

//분석에 쓸 맵을 가져오기위한 함수 사용 x
/**
 * 분석에 사용할 함수 사용 x
 */
function analMapFunc() {
	var analView = new ol.View({
		// projection:'EPSG:5174',

		center : ol.proj.transform([ 127.1, 36.5 ], 'EPSG:4326', 'EPSG:3857'),
		zoom : 11
	// projection:koreanProj1
	// extent:ol.proj.transformExtent([4,46,16,56],'EPSG:5181',epsg5181)
	});
	var analMap = new ol.Map({
		view : analView,
		layers : [],
		target : 'analMap',
		controls : ol.control.defaults().extend(
				[ new ol.control.FullScreen(), new ol.control.ZoomSlider() ])
	});
	var analEmdWfs = new ol.layer.Vector(
			{
				source : new ol.source.Vector(
						{
							url : function(extent) {
								return geoServer+'wfs?service=WFS&version=1.1.0&request=GetFeature&srsname=EPSG:3857&typename=geumbang:sejong_emd_17&outputFormat=application/json&maxfeatures=10000'
							},
							format : new ol.format.GeoJSON()
						})
			})
	analMap.addLayer(analEmdWfs);

}