/**
 * 읍면동 년도별 평균지가를 받아오는 js입니다
 */
// 읍면동의 기본 아이콘 스타일
var iconStyle = new ol.style.Style({
	image : new ol.style.Icon(({
		anchor : [ 0.5, 46 ],
		anchorXUnits : 'fraction',
		anchorYUnits : 'pixels',
		src : './img/icon.png'
	}))
});

// 읍면동의 테이블면을 미리 배열로 지정하여 사용
var emdArr = [ 'geumbang:emd_14_5174', 'geumbang:emd_15_5174',
		'geumbang:emd_16_5174', 'geumbang:emd_17_5174', 'geumbang:emd_18_5174' ];
// 읍면동 레이어를 담을 변수 선언
var vectorLayer;

/* 읍면동 연도별 json 형식으로 받아와서 아
 * 이콘까지 뛰어주기위한 이벤트. */

var emdUrl;
// emd_info( input range)의 체인지 이벤트 등록
$('#emd_info').on('change', function() {
	console.log($(this).val())
	var year = $(this).val() - 1;
	//emdUrl에 값이 있고 기존의 emdUrl과 값이 같으면 리턴
	if (emdUrl != null && emdUrl == emdArr[year]) {
		return;
	}
	emdUrl = emdArr[year];
	emdYearJigaFunc(emdUrl)

})
//인터벌을 이용하여 3초마다 값을 변경하여 wfs를 받아옴 
$('#emdTime').on('click', function() {
	var cnt = 0;
	setInterval(function() {
		if (cnt == 5) {
			return;
		}
		emdYearJigaFunc(emdArr[cnt]);
		cnt++;
	}, 1850);
});
/**
 * @pram: 읍면동의 테이블명
 * @return: x
 * 테이블명을 입력받아 기존의 emd라는 이름을 갖고 있는 레이러를 삭제후
 * ajax로 요청을 보내서 피처를 그려주고 레이러로 등록하는 과정.
 */
function emdYearJigaFunc(emdUrl) {
	map.getLayers().forEach(function(layer) {
		if (layer.get('name') == 'emd') {
			console.log('과연?')
			map.removeLayer(layer);
		}
	});

	var vectorSource = new ol.source.Vector();
	var features = [];
	var iconFeatures = [];
	// getLayer(url);
	$.ajax({
		url : geoServer+ 'wfs?service=WFS&version=1.1.0&request=GetFeature&srsname=EPSG:3857&typename='
			+ emdUrl+ '&outputFormat=application/json&maxfeatures=10000',
		dataType : 'json',
		async : false,
		success : function(data) {
				$.each(data.features, function(i, list) {
					var feature = new ol.Feature({
					geometry : new ol.geom.MultiPolygon(
							list.geometry.coordinates),
					jiga : list.properties.jiga
				});
				var style = emdStyleFunc(feature);
				feature.setStyle(style);
				var iconCoord = list.properties.center.coordinates;
				var iconInfo = list.properties;
				var info= '<div style="width:300px; height: 130px; font-size:12px">'+
					'<table class="table table-hover"><tr><th>읍면동 명 :</th><td>'+
					iconInfo.emd_nm+'</tr><tr><th>인구 수 :</th><td>'+ iconInfo.ingu + 
					'명</td></tr><tr><th>지가(평당) :</th><td>'+iconInfo.jiga+'원</td></tr><tr>'+
						  '<th>면적 :</th><td> '+iconInfo.area+'</td></tr></table></div>';
				var iconFeature = new ol.Feature({
					geometry : new ol.geom.Point(iconCoord),
					name : info,
					population : 4000,
					rainfall : 500,
					icon : "icon"
				});
				iconFeature.setStyle(iconStyle);
			
				console.log(feature);
				features.push(feature);
				iconFeatures.push(iconFeature);
					})
					vectorLayer = new ol.layer.Vector({
						source : new ol.source.Vector({})
					})

					vectorLayer.getSource().addFeatures(features)
					vectorLayer.getSource().addFeatures(iconFeatures)
					console.log(vectorLayer)

					map.addLayer(vectorLayer);
					view.setZoom(12);
					vectorLayer.set('name', 'emd');
				}
	});
}
/**
 * 
 * @param feature
 * @returns style
 * 지가별로 스타일을 다르게 주기위한 함수.
 */
function emdStyleFunc(feature) {
	var jiga = feature.get('jiga');
	var fill;
	if (0 <= jiga && jiga <= 41700) {
		fill = 'rgba(255,247,1,0.55)';
	} else if (41700 < jiga && jiga <= 75565) {
		fill = 'rgba(255,149,1,0.55)';
	} else if (75565 < jiga && jiga <= 103997) {
		fill = 'rgba(255,69,1,0.55)';
	} else if (103997 < jiga && jiga <= 47553) {
		fill = 'rgba(212,32,32,0.55)';
	} else {
		fill = 'rgba(114,0,15,0.55)';
	}
	var style = new ol.style.Style({
		fill : new ol.style.Fill({
			color : fill,
			opacity : 0.6
		}),
		stroke : new ol.style.Stroke({
			color : '#232323',
			width : 1,
			lineJoin : 'bevel'
		})
	})
	return style;
}
