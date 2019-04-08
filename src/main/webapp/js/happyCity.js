/**
 * 행복도시 js 관련
 */
var happyLayer;
function getHappyLayerFunc() {
	var img=' <img alt="" src="./img/happy.png" class="img-thumbnail"> ';
	$(".legend").html(img)
	$('.closeLegend').css('display','block');
	map.getLayers().forEach(function(layer) {
		if (layer.get('name') == 'happy') {
			map.removeLayer(layer);
		}
	});
	happyLayer = new ol.layer.Vector(
			{
				source : new ol.source.Vector(
						{
							url : function(extent) {
								return geoServer
										+ 'wfs?service=WFS&version=1.1.0&request=GetFeature&srsname=EPSG:3857&typename=geumbang:life&outputFormat=application/json&maxfeatures=10000'
							},
							format : new ol.format.GeoJSON()
						}),
				style:function(feature){
					
					return happyLayerStyleFunc(feature);
				}

			});
	view.setZoom(13);
	map.addLayer(happyLayer);
	happyLayer.set('name','happy');
}

function happyLayerStyleFunc(feature){
	var life_nm=feature.get('life_nm');
	var firstStr=life_nm.charAt(0);
	var fill;
	if('1'==firstStr){
		fill='rgba(255, 0, 0,0.25)'
	}else if('2'==firstStr){
		fill='rgba(255, 125,0,0.25)'
	}else if('3'==firstStr){
		fill='rgba(255, 255, 0,0.25)'
	}else if('4'==firstStr){
		fill='rgba(0, 255, 0,0.25)'
	}else if('5'==firstStr){
		fill='rgba(0, 165, 255,0.25)'
	}else if('6'==firstStr){
		fill='rgba(0, 5, 120,0.25)'
	}else{
		fill='rgba(117, 8, 160,0.25)'
	}
	var style=new ol.style.Style({
		fill:new ol.style.Fill({
			color:fill
		}),
		stroke:new ol.style.Stroke({
			color:'black',
			width:1
		}),
		text:new ol.style.Text({
			color:'black',
			text:life_nm
		})
	})
	return style;
	
}
var aptCluster;
$('#happyBtn').on('click',function(){

	map.getLayers().forEach(function(layer) {
		if (layer.get('name') == 'apt') {
			map.removeLayer(layer);
		}
	});
	aptCluster=new ol.layer.Vector({
		source:new ol.source.Cluster({
			distance: parseInt(distance.value, 10),
			source:new ol.source.Vector({
				url:function(extent){
					return geoServer+
					'wfs?service=WFS&version=1.1.0&request=GetFeature&srsname=EPSG:3857&typename=geumbang:apt&outputFormat=application/json&maxfeatures=10000';
				},
				format: new ol.format.GeoJSON()
			})
		}),
		style:function(feature){
			feature.set('name','happy');
			var cnt=0;
			feature.get('features').forEach(function(feature){
				cnt+=parseInt(feature.get('num'));
				var htmlStr='<div style="width:100%; height: 440px; font-size:12px">'+
				'<table class="table table-hover"><tr><th>사업시행자 :</th><td>'+feature.get('company')+'</td></tr>'+
				'<tr><th>대지면적/용적률 :</th><td> '+feature.get('area')+'</td></tr>'+
				'<tr><th>세대수 :</th><td> '+feature.get('num')+'세대</td></tr>'+
				'<tr><th>입주예정 월 :</th><td> '+feature.get('indate')+'</td></tr>'+
				'<tr><th>동수/층수 :</th><td> '+feature.get('dongnum')+'/'+feature.get('floor')+'</td></tr>'+
				'<tr><th>주차장 :</th><td> '+feature.get('parking')+'</td></tr>'
				+'<tr><td colspan=2><img src="'+feature.get('img')+'" style="width:300px; height=300px;"></td>'
				+'</table></div>';
				feature.set('html',htmlStr);
			});
			var style=new ol.style.Style({
				image:new ol.style.Circle({
					radius:32,
					stroke:new ol.style.Stroke({
						color:'#fff'
					}),
					fill:new ol.style.Fill({
						color:'rgba(0, 0, 255,0.7)'
					})
					
				}),
				text: new ol.style.Text({
					text:String(cnt)+"세대",
					fill:new ol.style.Fill({
						color:'white'
					}),
					font:'16px bold'
				})
			})
			return style;
		},
		maxResolution:38,
		minResolution:0
		
	});
	map.addLayer(aptCluster);
	aptCluster.set('name','apt');
	view.setZoom(13);
})