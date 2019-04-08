/**
 * 컨텍스트 메뉴 커스텀. js 
 */
var makerLayer=new ol.layer.Vector({
	source:new ol.source.Vector({}),
})
makerLayer.set('name','makerLayer');
map.addLayer(makerLayer);


var contextmenu_items = [
  {
    text: 'Move to Center',
    classname: 'bold',
    icon: 'img/center.png',
    callback: MoveToCenterFunc
  },
  {
    text: 'Some Actions',
    icon: 'img/view_list.png',
    items: [
      {
        text: 'Center map here',
        icon: 'img/center.png',
        callback: MoveToCenterFunc
      },
      {
        text: 'Add a Marker',
        icon: 'img/pin_drop.png',
        callback: marker
      }
    ]
  },
  {
    text: 'Add a Marker',
    icon: 'img/pin_drop.png',
    callback: markerRegist
  },{
	  text:'Save As Maker',
	  callback: saveMakerFunc
  },{
	  text:'Load As Maker',
	  callback: loadMakerFunc
  },
  '-' // this is a separator
  ,{
	  text:'Zoom In',
	  icon:'img/zoomIn.png',
	  callback:zoomInFunc
  },{
	  text:'Zoom Out',
	  icon:'img/zoomOut.png',
	  callback:zoomOutFunc
  }
];

var removeMarkerItem = {
  text: 'Remove this Marker',
  classname: 'marker',
  callback: removeMarker
};
var loadFeatureItem={
	text: 'Remove this Marker',
	classname: 'marker',
	callback: removeLoadMarkerFunc		
};

var contextmenu = new ContextMenu({
  width: 180,
  items: contextmenu_items
});
map.addControl(contextmenu);


contextmenu.on('open', function (evt) {
  var feature = map.forEachFeatureAtPixel(evt.pixel, function (ft, l) {
    return ft;
  });
  if (feature && feature.get('type') === 'removable') {
    contextmenu.clear();
    removeMarkerItem.data = {
      marker: feature
    };
    contextmenu.push(removeMarkerItem);
  }else if(feature && feature.get('type') === 'loadFeature'){
	  contextmenu.clear();
	  loadFeatureItem.data = {
		marker: feature
	  };
	  contextmenu.push(loadFeatureItem);
  } else {
    contextmenu.clear();
    contextmenu.extend(contextmenu_items);
  }
});

map.on('pointermove', function (e) {

  var pixel = map.getEventPixel(e.originalEvent);
  var hit = map.hasFeatureAtPixel(pixel);

  if (e.dragging) return;

  map.getTargetElement().style.cursor = hit ? 'pointer' : '';
});

// from https://github.com/DmitryBaranovskiy/raphael
function elastic(t) {
  return Math.pow(2, -10 * t) * Math.sin((t - 0.075) * (2 * Math.PI) / 0.3) + 1;
}

function MoveToCenterFunc(obj) {
	var centerMove=ol.animation.pan({
	    duration: 2000,
	    source: /** @type {ol.Coordinate} */ (view.getCenter())
	  });
	  map.beforeRender(centerMove);
	  view.setCenter(ol.proj.transform([ 127.3, 36.5 ], 'EPSG:4326', 'EPSG:3857'));
	  view.setZoom(12)
}

function removeMarker(obj) {
	console.log(obj)
	makerLayer.getSource().removeFeature(obj.data.marker);
}
var makerRegistID;
var makerRegistContent;
function markerRegist(obj){
	swal("ID를입력해주세요:", {
		  content: "input",
		}).then((value) => {
			makerRegistID= value;
		  swal('마커 내용을 입력해주세요:',{
			  content:"input",
		  }).then((value)=>{
			  makerRegistContent=value;
			  swal({
				  title: "입력 정보 확인",
				  text: "ID :"+makerRegistID+", 내용 :"+makerRegistContent+"를 등록합니다.",
				  icon: "warning",
				  buttons: true,
				  dangerMode: true,
				})
				.then((willDelete) => {
				  if (willDelete) {
				    swal("등록되었습니다.", {
				      icon: "success",
				    });
				    console.log(makerRegistID)
					console.log(makerRegistContent)
					marker(obj);
				  } else {
				    swal("다시입력해주세요!");
				    makerRegistID='';
				    makerRegistContent='';
				  }
				});
		  })
		});
	
}
function marker(obj) {
	
	var coord4326 = ol.proj.transform(obj.coordinate, 'EPSG:3857', 'EPSG:4326'),
    template = 'Coordinate is ({x} | {y})',
    iconStyle = new ol.style.Style({
    image: new ol.style.Icon({ scale: .6, src: 'img/pin_drop.png' }),
    text: new ol.style.Text({
          offsetY: 25,
          text: makerRegistContent,
          font: '15px Open Sans,sans-serif',
          fill: new ol.style.Fill({ color: '#111' }),
          stroke: new ol.style.Stroke({ color: '#eee', width: 2 })
        })
      }),
      feature = new ol.Feature({
        type: 'removable',
        geometry: new ol.geom.Point(obj.coordinate),
        content:makerRegistContent,
        id:makerRegistID
      });

  feature.setStyle(iconStyle);
  makerLayer.getSource().addFeature(feature);
}
function zoomInFunc(obj){
	var zoom=view.getZoom();
	view.setZoom(zoom+1)
	console.log("Zoom IN")
}
function zoomOutFunc(obj){
	var zoom=view.getZoom();
	view.setZoom(zoom-1)
	console.log("Zoom Out")
}
function saveMakerFunc(obj){
	var makerFeatures=makerLayer.getSource().getFeatures();
	var featuresObj=[];
	$.each(makerFeatures,function(i,feature){
		var coord=feature.getGeometry().getCoordinates();
		console.log(feature);
		var coord5174=ol.proj.transform(coord, 'EPSG:3857','EPSG:5174');
		console.log(coord5174+"aa")
		var data={
				"geom":coord5174,
				"id":feature.get('id'),
				"content":feature.get('content')
		}
		console.log(data)
		featuresObj.push(data);
	})	
	console.log(featuresObj)
	var jsonData=JSON.stringify(featuresObj)
	console.log(jsonData);
	$.ajax({
		url:webServer+'maker/insert.do',
		method:'post',
		dataType:'json',
		contentType:'application/json',
		data:jsonData,
		success:function(data){
			if(data){
				swal("저장 완료!");
			}else{
				swal("저장 실패");
			}
		}
	
	});
	
}
var loadMakerLayer;
function loadMakerFunc(){
	var inputId;
	swal("ID를입력해주세요:", {
		  content: "input",
		}).then((value) => {
			console.log(inputId);
			inputId= value;
			loadMakerLayer = new ol.layer.Vector({
				source : new ol.source.Vector({
					url : function(extent) {
							return geoServer+"wfs?service=WFS&version=1.1.0&request=GetFeature&srsname=EPSG:3857&typename=geumbang:maker&outputFormat=application/json&maxfeatures=10000&cql_filter=id='"
							+inputId+"'";
							},
					format : new ol.format.GeoJSON()
						}),
				style:function(feature){
					feature.set('type','loadFeature');
					feature.set('id',inputId);
					var style=new ol.style.Style({
					    image: new ol.style.Icon({ scale: .6, src: 'img/pin_drop.png' }),
					    text: new ol.style.Text({
					          offsetY: 25,
					          text: feature.get('content'),
					          font: '15px Open Sans,sans-serif',
					          fill: new ol.style.Fill({ color: '#111' }),
					          stroke: new ol.style.Stroke({ color: '#eee', width: 2 })
					        })
					     })
						return style;
					}
			
				
			});
				//emd info 에 센터로이드 넣어서 가져와서 해보장
				map.addLayer(loadMakerLayer)
				loadMakerLayer.set('name','loadMakerLayer');
		 })
	
}
function removeLoadMarkerFunc(obj){
	var userId=obj.data.marker.get('id');
	var userContent=obj.data.marker.get('content');
	swal({
		  title: userContent+" 마커를 삭제하시겠습니까?",
		  text: "삭제하면 데이터를 복구 할수 없습니다.",
		  icon: "warning",
		  buttons:{
			  cansle:'취소',
			  data:'데이터 삭제',
			  feature:'마커 삭제'
		  }
		}).then((value) => {
			  switch (value) {
			  
			    case "cansle":
			      break;
			 
			    case "data":
			      ajaxMakerRemove(userId,userContent,obj);
			      break;
			 
			    default:
			    	loadMakerLayer.getSource().removeFeature(obj.data.marker);
			    	removeMarker(obj);
			  };
	})
		console.log(obj)
};

function ajaxMakerRemove(userId,userContent,obj){
	$.ajax({
		url:webServer+"maker/delete.do",
		method:'post',
		data:{
			id:userId,
			content:userContent
		},
		success:function(data){
			if(data){
				swal("삭제 완료", "정상적으로 삭제 되었습니다.!", "success");
				loadMakerLayer.getSource().removeFeature(obj.data.marker);
			}else{
				swal("삭제 실패", "예상치 못한 오류로 실패하였습니다..!", "warning");
			}
		}
	
	});
}
