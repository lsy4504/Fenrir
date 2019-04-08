/**
 * 인구와 지가 데이터테이블 모달과 피쳐를 그려주기위한 js
 */
//연평균 데이터를 담아주기위한 변수 (div 담을 예정)
var cagrInfoOverlay;
	
	/**
	 *@param feature
	 *@return style
	 * 읍면동 연평균 증가율를 가져와 스타일을 지정해주고 그 스타일을 반환해주는 함수 
	 */
function emdCagrStyleFucn(feature){
	var cagr=feature.get('cagr');
	var emd_nm=feature.get('emd_nm');
	console.log(cagr)
	var fill=null;
	if(cagr<=0){
		fill='rgba(224,255, 145,0.55)';
	}else if(0<cagr&&cagr<=5){
		console.log("aa")
		fill='rgba(246, 223, 9,0.55)';
	}else if(5<cagr&&cagr<=20){
		console.log("??")
		fill='rgba(255, 105, 31,0.55)';
	}else if(20<cagr&&cagr<=60){
		fill='rgba(255, 158, 1,0.55)';
	}else if(60<cagr){
		fill='rgba(255, 0, 0,0.55)';
	}
	var style=new ol.style.Style({
		fill:new ol.style.Fill({
			color:fill,
			opacity:0.55
		}),
		stroke:new ol.style.Stroke({
			color:'#232323',
			width:1,
			lineJoin:'bevel'
		}),
		text:new ol.style.Text({
			font:"10px bold",
			fill:new ol.style.Fill({color:"#ffffff"}),
			text:emd_nm+"<br>"+cagr+"%"
		})
	
	})
	return style;
}
/**
 * @param startYear
 * @param endYear
 * @param url(인구,지가)
 * @returns
 * 시작년도와 끝년도를와 url을 받아와 (인구,지가)를 구분하여 ajax 요청을 날리기 위한 함수
 * 
 */	
function dataAjaxFunc(startYear,endYear,url){
	map.getLayers().forEach(function(layer) {
		if (layer.get('name')=='dataLayer') {
			console.log('ss')
			map.removeLayer(layer);
		}
	});
	var dataLayer;
	
	var tableName="geumbang:stats_";
	if(url=="jiga"){
		tableName+="emd_"+startYear+"_"+endYear;
	}else{
		tableName+="ingu_"+startYear+"_"+endYear;
	}
	console.log(tableName)
	var features=[];
	var iconFeatures=[];
	$.ajax({
		url:geoServer+"wfs?service=WFS&version=1.1.0&request=GetFeature&srsname=EPSG:3857&typename="+tableName+"&outputFormat=application/json&maxfeatures=10000",
		dataType:'json',
		asunc:false,
		success:function(data){
			$.each(data.features,function(i,list){
				var feature=new ol.Feature({
					geometry:new ol.geom.MultiPolygon(list.geometry.coordinates),
					emd_nm:list.properties.emd_nm,
					cagr:list.properties.cagr
				});
				var style=emdCagrStyleFucn(feature);
				feature.setStyle(style);
				features.push(feature) ;
				var emd_nm=feature.get('emd_nm');
				var cagr=feature.get('cagr');
				var coord=list.properties.st_centroid.coordinates;
			/*
			 * var iconFeature = new ol.Feature({ geometry: new
			 * ol.geom.Point(iconCoord), name: info, population: 4000,
			 * rainfall: 500 });
			 */
				var element="<div id='"+emd_nm+"' class='cagrInfoDiv'><p style='font-size: 13px; font-weight: bold; margin-bottom: 0;'>"+emd_nm+"</p>"
							+"<p style='font-size: 17px; font-weight: bold; margin-bottom: 0;'>"+cagr+"%</p></div>";
				$("#cagrInfoDiv").append(element);
				console.log(document.getElementById(emd_nm))
				 cagrInfoOverlay= new ol.Overlay({
					element:document.getElementById(emd_nm),
					positioning: 'center-center',
					position:coord
				});
				map.addOverlay(cagrInfoOverlay);
				console.log(cagrInfoOverlay)
				
			});
			dataLayer=new ol.layer.Vector({
							source:new ol.source.Vector({}),
						});
			console.log(features);
			console.log(iconFeatures);
			dataLayer.getSource().addFeatures(features);
			dataLayer.getSource().addFeatures(iconFeatures);
			map.addLayer(dataLayer);
			dataLayer.set('name','dataLayer');
			map.getView().setZoom(13);
			
		}
	})
}
	
$(function(){
		//지가 버튼의 클릭 이벤트 ajax로 요청을 보내 데이터를 받아와서 세팅해줌
		$('#jigaBtn').on('click',function(){
			var legend=$(this).attr('legend');
			if(legend){
			
				console.log("뿌야")
				var img=' <img alt="" src="./img/'+legend+'.png" class="img-thumbnail"> ';
				$(".legend").html(img)
				$('.closeLegend').css('display','block');
			}
			var startYear=$('#jigaStartYear').val().substr(2,4);
            var endYear=$('#jigaEndYear').val().substr(2,4);
            var url=$(this).attr('url');
            dataAjaxFunc(startYear,endYear,url)		            
			 $.ajax({	
	            	url:webServer+"jiga/list.do",
	            	data:{
	            		startYear:startYear,
	            		endYear:endYear
	            	},
	            	success:function(data){
	            		$('#emdJigaModalBody').html(data);
	            		swal({
	            			  title: "지가 변동 입니다",
	            			  text: "확인 버튼을 클릭해주세요!",
	            			  icon: "success",
	            			  button:{
	            				  
	            				  okBtn:"확인"
	            			  },
	            		}).then(function(value){
	            			if(value){
	            				$("#emdJigaModal").modal();
	            				$('#table_id').DataTable({
	            					dom: 'Bfrtip',
	            					  buttons: [
	            					           'copy', 'csv', 'excel', 'pdf', 'print'
	            					        ],
	            					        language: {
	            					            buttons: {
	            					                selectAll: "Select all items",
	            					                selectNone: "Select none"
	            					            }
	            					        }
	            				});
	            			}
	            			
	            		});
	            	}
	            	
	            })
		})
		/**
		 * 인구 데이터 테이블 세팅하기위한 이벤트
		 */
		$('#inguBtn').on('click',function(){
			var startYear=$('#inguStartYear').val().substr(2,4);
            var endYear=$('#inguEndYear').val().substr(2,4);
            var url=$(this).attr('url');
            var legend=$(this).attr('legend');
			if(legend){
				console.log(legend);
				var img=' <img alt="" src="./img/'+legend+'.png"  class="img-thumbnail">';
				$(".legend").html(img)
				$('.closeLegend').css('display','block');
			}
            dataAjaxFunc(startYear,endYear,url)		
			 $.ajax({
	            	url:webServer+"ingu/list.do",
	            	data:{
	            		startYear:startYear,
	            		endYear:endYear
	            	},
	            	success:function(data){
	            		$('#inguModalBody').html(data);
	            		swal({
	            			  title: "인구 변동 입니다",
	            			  text: "확인 버튼을 클릭해주세요!",
	            			  icon: "success",
	            			  button:{
	            				  
	            				  okBtn:"확인"
	            			  },
	            		}).then((value)=>{
	            			if(value){
	            				$("#inguModal").modal();
	            				$('#ingu_table').DataTable({
	            					dom: 'Bfrtip',
	            					  buttons: [
	            					           'copy', 'csv', 'excel', 'pdf', 'print'
	            					        ],
	            					        language: {
	            					            buttons: {
	            					                selectAll: "Select all items",
	            					                selectNone: "Select none"
	            					            }
	            					        }
	            				});
	            			}
	            			
	            		});
	            	}
	            	
	            })
		});
});