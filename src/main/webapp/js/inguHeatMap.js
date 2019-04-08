/**
 * 인구 히트맵을 위한 js 파일
 */

var distance = document.getElementById('distance');
var blur = document.getElementById('blur');
var radius = document.getElementById('radius');
var heatMap = null;
// 인구에 관한 테이블명 배열
var heatArr=['geumbang:ingu_14','geumbang:ingu_15','geumbang:ingu_16','geumbang:ingu_17','geumbang:ingu_18'];
var heatUrl;
$('#inguTime').on('click', function() {
	console.log('인구타임')
	var cnt = 0;
	setInterval(function() {
		if (cnt == 5) {
			return;
		}
		getInguLayerFunc(heatArr[cnt]);
		cnt++;
	}, 1850);
});
	  //인구 input range에 체인지 이벤트 등록 .
		$("#heat_ingu").on('change',function(){
			var inguCluster;
			console.log("이상하네?")
			var year=$(this).val();
			console.log(heatArr[year]);
			if(heatUrl!=null && heatUrl==heatArr[year-1]){
				return;
			}
			
			heatUrl=heatArr[year-1];
			getInguLayerFunc(heatUrl);
			
		})
function getInguLayerFunc(heatUrl){
			var removeLayers=[];
			map.getLayers().forEach(function(layer){
				if(layer.get('name')=='heat' || layer.get('name')=='inguCluster'){
					console.log("삭제되고있니?")
					console.log(layer)
					removeLayers.push(layer);
				}
			})
			removeLayer(removeLayers);
			var url=geoServer+'wfs?service=WFS&version=1.1.0&request=GetFeature&srsname=EPSG:3857&typename='+heatUrl+'&outputFormat=application/json&maxfeatures=10000';
			console.log(url);
			
			heatMap= new ol.layer.Heatmap(
					{
						source : new ol.source.Vector(
								{
									url :function(extent) {
										return url;
									},
									format : new ol.format.GeoJSON()
								}),
								blur : parseInt(15, 10),
								radius : parseInt(3, 10)
					});
			
			console.log(heatMap);
			inguCluster=new ol.layer.Vector({
				source:new ol.source.Cluster({
					distance: parseInt(distance.value, 10),
					source:heatMap.getSource()
				}),
				style:function(feature){
					var ingu=0;
					feature.get('features').forEach(function(feature){
						ingu+=parseInt(feature.get('val'));
					});
					var size;
					if (ingu<=4000){
						size=18;
					}else if(ingu>4000){
						size=25;
					}
					var style=new ol.style.Style({
						image:new ol.style.Circle({
							radius:size,
							stroke:new ol.style.Stroke({
								color:'#fff'
							}),
							fill:new ol.style.Fill({
								color:'black'
							})
						
						}),
						text: new ol.style.Text({
							text:String(ingu)+'명',
							fill:new ol.style.Fill({
								color:'white'
							}),
							font:'15px bold'
						})
					})
					return style;
				},
				maxResolution:38,
				minResolution:0
				
			})
			view.setZoom(11);
			map.addLayer(heatMap);
			map.addLayer(inguCluster);
			heatMap.set('name','heat');
			inguCluster.setZIndex(1000);
			inguCluster.set('name','inguCluster');
			
		}		
//히트맵 관련 이벤트 함수 
blur.addEventListener('input', function() {
	heatMap.setBlur(parseInt(blur.value, 10));
});

radius.addEventListener('input', function() {
	heatMap.setRadius(parseInt(radius.value, 10));
});