<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
.modal-backdrop {
	position: fixed;
	top: 0;
	right: 0;
	bottom: 0;
	left: 0;
	z-index: 100;
	background-color: #000;
}
.cagrInfoDiv {
	border-radius: 7px;
	background: rgba(92, 73, 244,0.7);
	color: white;
	width: 60px;
	height: auto;
	padding-left: 8px;
}

.tablinks {
	font-size: 20px;
}

.dt-button {
	color: #fff;
	background-color: #5bc0de;
	border-color: #46b8da;
}
</style>
<c:url value="/" var="path" />
<link href="${path }/css/tab.css" rel="stylesheet">
<link href="${path }/css/rSlider.min.css" rel="stylesheet">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/echarts/4.2.1/echarts.js"></script>

<div id='mySidenav' class='sidenav'>

	<div class="div-logo">
	<a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
		<img alt="" src="${path}/img/logo.png" class="logo">
	</div>
	<div class="tab">
		<button class="tablinks" onclick="openCity(event, 'jiga')"
			id="defaultOpen" style="text-align: center;">지가</button>
		<button class="tablinks" onclick="openCity(event, 'ingu')"
			id="inguOpen" style="text-align: center;">인구</button>
		<button class="tablinks" onclick="openCity(event, 'anal')"
			id="analOpen" style="text-align: center;">통계</button>
		<button class="tablinks" onclick="openCity(event, 'happy')"
			id="happyOpen" style="text-align: center;">분양</button>
	</div>
	<div id="London" class="tabcontent">
		<h2>London</h2>
		<p>London is the capital city of England.</p>
	</div>
	<div id="ingu" class="tabcontent">
		<h2>인구</h2>
		<p>선택한 년도의 읍면동 인구를 보여줍니다.</p>
		<br> <br>
		<div class="slider-container" style="width: 250px;"
			id="slider_container">
			<input type="text" id="slider1" class="slider" />
		</div>
		<input type="button" id="inguBtn" value="조회" url='ingu'
			class="btn btn-info" legend='cagr'>
	</div>

	<div id="jiga" class="tabcontent">
		<h2>지가</h2>
		<p>선택한 년도의 읍면동 지가를 보여줍니다.</p>
		<br> <br>
		<div class="slider-container" style="width: 250px;"
			id="slider_container">
			<input type="text" id="slider" class="slider" />
		</div>
		<input type="button" id="jigaBtn" value="조회" url='jiga'
			class="btn btn-info" legend='cagr'>
	</div>
	<div id="anal" class="tabcontent">
		<h2>통계</h2>
		<p>조회 버튼을 누르면 새로운 팝첩창이 진행됩니다.</p>
		<input type="button" id="analBtn" value="조회" class="btn btn-info">
	</div>
	<div id="happy" class="tabcontent">
		<h2>분양</h2>
		<p>세종시의 행복도시 권역별로 표시됩니다.</p>
		<p>조회 버튼을 누르면 권역별 19년 입주현황이 표시됩니다.</p>
		<input type="button" id="happyBtn" value="조회" class="btn btn-info">
	</div>



	<input type="hidden" id="jigaStartYear"> <input type="hidden"
		id="jigaEndYear"> <input type="hidden" id="inguStartYear">
	<input type="hidden" id="inguEndYear"> <input type="hidden"
		id="analStartYear"> <input type="hidden" id="analEndYear">
</div>

<div class="modal fade" id="emdJigaModal" style="z-index: 1050;">
	<div class="modal-dialog" style="width: 1250px;">
		<div class="modal-content">

			<div class="modal-header">
				<h4 class="modal-title">지가 데이터</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>

			<!-- Modal body -->
			<div class="modal-body" id='emdJigaModalBody'>Modal body..</div>

			<!-- Modal footer -->
			<div class="modal-footer">
				<button type="button" id="grap" class='btn btn-warning'>그래프</button>
				<button type="button" class="btn btn-danger" data-dismiss="modal"
					id="modalClose">Close</button>
			</div>

		</div>
	</div>
</div>
<div class="modal fade" id="inguModal" style="z-index: 1050;">
	<div class="modal-dialog" style="width: 1250px;">
		<div class="modal-content">

			<div class="modal-header">
				<h4 class="modal-title">인구 데이터</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>

			<!-- Modal body -->
			<div class="modal-body" id='inguModalBody'>Modal body..</div>

			<!-- Modal footer -->
			<div class="modal-footer">
				<button type="button" id="inguGrapBtn" class='btn btn-warning'>그래프</button>
				<button type="button" class="btn btn-danger" data-dismiss="modal"
					id="inguModalClose">Close</button>
			</div>

		</div>
	</div>
</div>

<div class="modal fade" id="analModal" style="z-index: 1050;">
	<div class="modal-dialog">
		<div class="modal-content" style="width: 2000px; height: 1000px;">
			<div class="modal-header">
				<h4 class="modal-title">차트차트</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
			<!-- Modal body -->
			<div class="modal-body" id='analModalBody'
				style="width: 1500px; height: 700px;">
				<div id="analMap" style="width: 300px; height: 500px;"></div>
				<div>우리는 우리입니다 제발</div>
			</div>

			<!-- Modal footer -->
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal"
					id="analModalClose">Close</button>
			</div>
		</div>
	</div>
</div>

<div id="jigaGrap" class="jigaGrap"></div>
<div id="inguGrap" class="inguGrap"></div>
<div class="cagrInfoDiv" id="cagrInfoDiv"></div>
<div class="legendDiv" id="legendDiv">
	<a href="javascript:void(0)" class="closeLegend" style="font-size: 30px; display: none;">×</a>
	<div class='legend'>
	</div>
</div>

<%-- 	<script src="${path}js/rs.js"></script> --%>


<script src="${path}/js/rSlider.min.js"></script>
<script>
	/**
	 * r슬라이더 세팅 
	 */
	 var slider ;
	function jigaS() {
		if(slider==null){
			
		slider = new rSlider({
			target : '#slider',
			values : [ 2014, 2015, 2016, 2017, 2018 ],
			range : true,
			set : [ 2017, 2018 ],
			onChange : function(vals) {
				console.log(vals);
				var yearArry = [];
				yearArry = (vals.split(','))
				//여기서부터하시면됩니다.
				$('#jigaStartYear').val(yearArry[0]);
				$('#jigaEndYear').val(yearArry[1]);

			}
		});
		}

	};
	var slider1;
	function inguS() {
		if (slider1 == null) {

			slider1 = new rSlider({
				target : '#slider1',
				values : [ 2014, 2015, 2016, 2017, 2018 ],
				range : true,
				set : [ 2017, 2018 ],
				onChange : function(vals) {
					console.log(vals);
					var yearArry = [];
					yearArry = (vals.split(','))
					//여기서부터하시면됩니다.
					$('#inguStartYear').val(yearArry[0]);
					$('#inguEndYear').val(yearArry[1]);

				}
			});
		}
	}
	var slider2;

	/**
	 * 텝 이벤트를 위한 함수
	 */
	function openCity(evt, cityName) {
		var i, tabcontent, tablinks;
		tabcontent = document.getElementsByClassName("tabcontent");
		for (i = 0; i < tabcontent.length; i++) {
			tabcontent[i].style.display = "none";
		}
		tablinks = document.getElementsByClassName("tablinks");
		for (i = 0; i < tablinks.length; i++) {
			tablinks[i].className = tablinks[i].className
					.replace(" active", "");
		}
		document.getElementById(cityName).style.display = "block";
		evt.currentTarget.className += " active";
		if (cityName == "ingu") {
			inguS();
		}else if(cityName=="jiga"){
			jigaS();
		}else if(cityName=='happy'){
			getHappyLayerFunc()
		}

	}
	// Get the element with id="defaultOpen" and click on it
	document.getElementById("analOpen").click();
	$("#analBtn").on(
			'click',
			function() {
				var popupX = (window.screen.width / 2) - (200 / 2);

				var popupY = (window.screen.height / 2) - (300 / 2);
				var openWin;
				window.open(webServer + "anal/popUp.do", 'anal',
						'height=' + screen.height + ',width=' + screen.width + 'fullscreen=yes');
			});
	/**
	지가 데이터테이블 세팅을 위한 이벤트
	 */
	//풀리지 않는 텍스트에 배겨ㅓㅇ주기./.. 렁
	/**
		통계 그래프를 가져올 예정입니다.
	 */
	/* 		$("#analBtn").on('click',function(){
			analMapFunc();
			$("#analModal").modal(); 
			var startYear=$('#analStartYear').val().substr(2,4);
	           var endYear=$('#analEndYear').val().substr(2,4);
			$.ajax({
				url:"${path}anal/getData.do",
				data:{
					start:startYear,
					end:endYear
				},
				success:function(data){
					
	// 					$("#analModalBody").html(data)
				}
			})
		});  */
$('.closeLegend').on('click',function(){
	$('.legend').html("");
	$(this).css('display','none');
})
</script>

