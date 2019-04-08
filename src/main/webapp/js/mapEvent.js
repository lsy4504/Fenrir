/**
 * map 클릭 이벤트 관련 js입니다.
 */
map.on('singleclick', function(evt) {
	console.log("맵클릭관련")
	console.log(evt)
	displayFeatureInfo(evt)
})
// 특정 피쳐에 마우스가 이동하면 툴팁 나오게하기 위한 이벤트
// map.on('pointermove',function(evt){
// if(evt.dragging){
// info.tooltip('hide');
// return;
// }
// displayFeatureInfo(map.getEventPixel(evt.originalEvent));
// });
// 함수
var overlay;
var displayFeatureInfo = function(evt) {
	var pixel = evt.pixel;
	var feature = map.forEachFeatureAtPixel(pixel, function(feature) {
		return feature;
	});
	if (feature) {
		console.log(feature.get('icon'));
		overlay = new ol.Overlay({
			element : container,
			autoPan : true,
			autoPanAnimation : {
				duration : 250
			}
		});
		if (feature.get('icon') == "icon") {
			content.innerHTML = feature.get('name');
			console.log(content)
			
		}else if (feature.get('name') == undefined) {
			console.log('a')
			return;
		} else if(feature.get('name')=='jijuckdo'){
			content.innerHTML = '<div style="width:300px; height: 70px; font-size:12px">'+
								'<table class="table table-hover"><tr><th>지번 :</th><td>'+feature.get('jibun')+'</td></tr>'+
								'<tr><th>지가(평당) :</th><td> '+feature.get('jiga')+'원</td></tr></table></div>';
		}else if(feature.get('name')=='happy'){
			feature.get('features').forEach(function(feature){
				content.innerHTML =feature.get('html');
				})
			
		}
	
		container.style.display = 'block';
		var coordinate = evt.coordinate;
		var hdms = ol.coordinate.toStringHDMS(ol.proj.transform(coordinate,
				'EPSG:3857', 'EPSG:4326'));
		overlay.setPosition(coordinate);
		map.addOverlay(overlay)
	} else {
		info.tooltip('hide');
	}
	console.log(feature)

};
closer.onclick = function() {
	overlay.setPosition(undefined);
	closer.blur();
	return false;
};
// 툴팁 정보가져오기

var info = $('#info');
info.tooltip({
	animation : false,
	trigger : 'manual'
});