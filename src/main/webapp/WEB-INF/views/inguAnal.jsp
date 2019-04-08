<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:url value="/" var="path"></c:url>
<table id="ingu_table" class="display" style=" font-size: 15px;">
	<thead>
		<tr>
			<th>읍면동 명</th>
			<c:forEach items="${yearArr }" var="year">
				<th>${year}</th>
			</c:forEach>
			<c:forEach items="${yearPerArr }" var="yearPer">
				<th>${yearPer}</th>
			</c:forEach>
			<th><input type="checkbox" id='inguAllSelect' /><span id="inguSapn">전체 선택</span></th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${inguList}" var="ingu">
			<tr value="${ingu.emd_nm}">
				<td>${ingu.emd_nm}</td>
				<c:if test="${not empty ingu.ingu_14}">
					<td>${ingu.ingu_14}</td>
				</c:if>

				<c:if test="${not empty ingu.ingu_15}">
					<td>${ingu.ingu_15}</td>
				</c:if>
				<c:if test="${not empty ingu.ingu_16}">
					<td>${ingu.ingu_16}</td>
				</c:if>
				<c:if test="${not empty ingu.ingu_17}">
					<td>${ingu.ingu_17}</td>
				</c:if>
				<c:if test="${not empty ingu.ingu_18}">
					<td>${ingu.ingu_18}</td>
				</c:if>
				<c:if test="${not empty ingu.per_14_15}">
					<td>${ingu.per_14_15}</td>
				</c:if>
				<c:if test="${not empty ingu.per_15_16}">
					<td>${ingu.per_15_16}</td>
				</c:if>
				<c:if test="${not empty ingu.per_16_17}">
					<td>${ingu.per_16_17}</td>
				</c:if>
				<c:if test="${not empty ingu.per_17_18}">
					<td>${ingu.per_17_18}</td>
				</c:if>
				<td><input type="checkbox" value="${ingu.emd_nm}"
					name='dataBtn' name='check' class='inguCheck' /></td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<input type="hidden" value="${start}" class='start'>
<input type="hidden" value="${end}" class='end'>
<script>
$('#inguAllSelect').on('change',function(){
	var flag=$(this).parent().text();
	console.log(flag)
	$("#ingu_table tbody tr").toggleClass('selected');
	if(flag=="전체 선택"){
	$('.inguCheck').attr('checked',true)
		$("#inguSapn").text('전체 해제');
	}else{
	$('.inguCheck').attr('checked',false)
		$("#inguSapn").text('전체 선택');
	}
})
			var emdArry=[];
$(function(){
		$('#inguGrapBtn').on('click',function(){
// 			$('.inguCheck:checked').each(function(){
// 				emdArry.push($(this).val());
// 			});
			if(emdArry.length>0){
				
			swal({
				  title: "지가 데이터 그래프 조회",
				  text: "조회할 데이터 목록 :"+emdArry+"이 맞습니까?",
				  icon: "warning",
				  buttons: true,
				  dangerMode: true,
				})
				.then((willDelete) => {
				  if (willDelete) {
				    swal("OK를 누르시면 진행합니다!", {
				      icon: "success",
				    }).then((value)=>{
				    	openIngu(emdArry);
				    	//이부분에서 시각화 데이터 가져오시면 됩니다 키워드 : 렁이
				    });
				  } else {
				    swal("조회할 데이터를 다시 선택하세요!");
				  }
				});
			
			}else{
				swal({
					  title: "에러!!",
					  text: "1개 이상의 데이터를 선택해주세요!",
					  icon: "warning",
					  button: "OK",
					});
			}
		})
	})
		$('#ingu_table tbody').on( 'click', 'tr', function () {
	        $(this).toggleClass('selected');
	        var flag=$(this).children().last().children().is(":checked");
	        if(flag){
	        console.log($(this).children().last().children().attr('checked',false));
	        var idx=emdArry.indexOf($(this).children().first().text());
	        emdArry.splice(idx,1);
	        }else{
	        	emdArry.push($(this).children().first().text());
	        console.log($(this).children().last().children().attr('checked',true));
	        	
	        }
	    } );
	
	var openWin;
	function openIngu(emdArry){
		console.log("여기는인구")
		var start=$(".start").val();
		var end=$(".end").val();
		console.log("a")
		$.ajax({
			url:"${path}ingu/inguGrap.do?emdArry="+emdArry+"&start="+start+"&end="+end,
			success:function(data){
				$('#inguGrap').html(data);
				$("#inguModalClose").click();
			}		
		})
	}

</script>