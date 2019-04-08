<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<table id="table_id" class="display" style=" font-size: 15px;">
    <thead>
        <tr>
            	<th>읍면동 명</th>
            	<c:forEach items="${yearArr }" var="year">
            		<th>${year}</th>
            	</c:forEach>
            	<c:forEach items="${yearPerArr }" var="yearPer">
            		<th>${yearPer}</th>
            	</c:forEach>
            	<th><input type="checkbox" id='allSelect'/><span id="sapn">전체 선택</span></th>
        </tr>
    </thead>
    <tbody>
        <c:forEach items="${jigaList}" var="jiga">
        	<tr>
        		<td>${jiga.emd_nm}</td>
        		<c:if test="${not empty jiga.jiga_14}">
        			<td>${jiga.jiga_14}</td>
        		</c:if>
        		
        		<c:if test="${not empty jiga.jiga_15}">
        		<td>${jiga.jiga_15}</td>
        		</c:if>
        		<c:if test="${not empty jiga.jiga_16}">
        		<td>${jiga.jiga_16}</td>
        		</c:if>
        		<c:if test="${not empty jiga.jiga_17}">
        		<td>${jiga.jiga_17}</td>
        		</c:if>
        		<c:if test="${not empty jiga.jiga_18}">
        		<td>${jiga.jiga_18}</td>
        		</c:if>
        		<c:if test="${not empty jiga.per_14_15}">
        		<td>${jiga.per_14_15}</td>
        		</c:if>
        		<c:if test="${not empty jiga.per_15_16}">
        		<td>${jiga.per_15_16}</td>
        		</c:if>
        		<c:if test="${not empty jiga.per_16_17}">
        		<td>${jiga.per_16_17}</td>
        		</c:if>
        		<c:if test="${not empty jiga.per_17_18}">
        		<td>${jiga.per_17_18}</td>
        		</c:if>
        		<td><input type="checkbox" value="${jiga.emd_nm}" name='dataBtn' name='check' class='check' /></td>
        	</tr>
        </c:forEach>
    </tbody>
</table>
<input type="hidden" value="${start}" class='start' >
<input type="hidden" value="${end}" class='end' >
<script>
	$('#allSelect').on('change',function(){
		$("#table_id tbody tr").toggleClass('selected');
		var flag=$(this).parent().text();
		if(flag=="전체 선택"){
		$('.check').attr('checked',true)
			$("#sapn").text('전체 해제');
		}else{
		$('.check').attr('checked',false)
			$("#sapn").text('전체 선택');
		}
	})
	var emdArry=[];
	$(function(){
		$('#grap').on('click',function(){
			console.log("헐");
// 			$('.check:checked').each(function(){
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
				    	openPopUp(emdArry);
				    	//이부분에서 시각화 데이터가져오면 됩니다 키워드 : 렁이
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
	$('#table_id tbody').on( 'click', 'tr', function () {
			console.log(emdArry)
			console.log($(this).children().first().text())
			
	        $(this).toggleClass('selected');
	        var flag=$(this).children().last().children().is(":checked");
	        if(flag){
	        	console.log("??")
	        console.log($(this).children().last().children().attr('checked',false));
	        var idx=emdArry.indexOf($(this).children().first().text());
	        emdArry.splice(idx,1);
	        }else{
	        emdArry.push($(this).children().first().text());
	        	console.log("a??")
	        console.log($(this).children().last().children().attr('checked',true));
	        }
	    } );
	var openWin;
	function openPopUp(emdArry){
		var start=$(".start").val();
		var end=$(".end").val();
		console.log("a")
		window.name='parent';
// 		openWin= window.open("${path}jiga/jigaGrap.do?emdArry="+emdArry+"&start="+start+"&end="+end,'childForm','widt=570,height=350,resizable= no')
		$.ajax({
			url:"${path}jiga/jigaGrap.do?emdArry="+emdArry+"&start="+start+"&end="+end,
			success:function(data){
				$('#jigaGrap').html(data);
				$("#modalClose").click();
			}		
		})
		
	}
</script>

