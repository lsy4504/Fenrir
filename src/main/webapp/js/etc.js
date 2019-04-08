/**
 * 편의 시설 관련 js 입니다 .
 */
$('#check_btn').on('click',function(){
			map.getLayers().forEach(function(layer) {
				if (layer.get('name') == "cluster") {
					removeList.push(layer);
				}
			});
			removeLayer(removeList);
			var checked=[];
			$('input[name=check]:checked').each(function(){
				var tableName;
				var select=$(this).val();
				switch (select){
					case 'movie':
						console.log(select)
						tableName='geumbang:movie';
						break;
					case 'food':	
						tableName='geumbang:food_1';
						break;
					case 'school':
						tableName='geumbang:school_1';
						break;
						
				}
				var url=geoServer+'wfs?service=WFS&version=1.1.0&request=GetFeature&srsname=EPSG:3857&typename='+tableName+'&outputFormat=application/json&maxfeatures=10000';
				
				var etcCluster =etc_Cluster(url,select)
				console.log(etcCluster);
				map.addLayer(etcCluster);
				etcCluster.set('name','cluster')
				
				
			})
		})
		function etc_Cluster (url,select){
			console.log("??")
			var etcCluster= new ol.layer.Vector({
				source: new ol.source.Cluster({
					distance: parseInt(distance.value, 10),
					source: new ol.source.Vector({
						url:function(extent){
							return url;
						},
						format: new ol.format.GeoJSON()
					})
				}),
				style: function(feature){
					console.log('test')
					return clusterStyle(feature,select);
				}
			}) 
			
			return etcCluster;
		}
		
		
			var i=1;
		function clusterStyle(feature,select){
			
			console.log(feature);
			console.log(select);
			var feature=feature;
			var size=feature.get('features').length;
			
// 			var style = styleCache[size];
// 			if (!style) {
			var year;
			var date;
			feature.get('features').forEach(function(feature){
				date=String((feature.get('date')));
				date=(date.substring(0,4));
				switch (date){
				case '2016':
					year=16;
					break;
				case '2017':
					year=18;
					break;
				case '2018':
					year=18;
					break;
				default:
					year=15;
					break;
				}
			});
			select+=year;
				style = new ol.style.Style({
					image : etc_iconStyle(select),
					text : new ol.style.Text({
						text : date,
						fill : new ol.style.Fill({
							color : 'black'
						})
					})
				});
// 				styleCache[size] = style;
				return style;
		}
		function etc_iconStyle(select){
			var src='./img/' +select+'.png';
			var movieIconStyle =  new ol.style.Icon(({
				anchor:[0.5,46],
				anchorXUnits:'fraction',
				anchorYUnits:'pixels',
				src:src
				
			}))
			return movieIconStyle;
		}