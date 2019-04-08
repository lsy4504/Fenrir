<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<h3>
	<a href="javascript:void(0)" class="closebtn" id='inguGrapClose'
		style="right: 0%; position: absolute; top: 0;">&times;</a>
</h3>
<div id="inguChart" style="width:800px; height: 300px;"></div>

<script type="text/javascript">
$("#inguGrapClose").on('click',function(){
	console.log("aa")
	$("#inguGrap").html("")
})
var emdName=[];
var jigaData14=[];
var jigaData15=[];
var jigaData16=[];
var jigaData17=[];
var jigaData18=[];
var emdCagr=[];
console.log('${emdList}')
<c:forEach items="${emdList}" var="ingu" varStatus="status" >
	emdName.push('${ingu.emd_nm}');
	emdCagr.push('${ingu.cagr}')
	<c:if test="${not empty ingu.ingu_14}">
		jigaData14.push('${ingu.ingu_14}');
	</c:if>
	<c:if test="${not empty ingu.ingu_15}">
	jigaData15.push('${ingu.ingu_15}');
	</c:if>
	<c:if test="${not empty ingu.ingu_16}">
	jigaData16.push('${ingu.ingu_16}');
	</c:if>
	<c:if test="${not empty ingu.ingu_17}">
	jigaData17.push('${ingu.ingu_17}');
	</c:if>
	<c:if test="${not empty ingu.ingu_18}">
	jigaData18.push('${ingu.ingu_18}');
	</c:if>
</c:forEach>
var cagrObj={
		name:'연평균 증감률',
		type:'bar',
		data:emdCagr,
		
		 barWidth: 30
}
var dataOBJ={
		jiga14:jigaData14,
		jiga15:jigaData15,
		jiga16:jigaData16,
		jiga17:jigaData17,
		jiga18:jigaData18
};
console.log(dataOBJ.jiga${1+start-1});
console.log(cagrObj);
var yearData=[];
var objArr=[];
 <c:forEach items="${yearArr}" var="year" varStatus="status" >
yearData.push('${year}');
yearData.push('연평균 증감률');
console.log(dataOBJ.jiga${status.count+start-1})
var obj={
		 		name:"${year}",
		 		yAxisIndex: 1,
		            type:'line',
		            data:dataOBJ.jiga${status.count+start-1},
		            markPoint: {
		                data: [
		                    {type: 'max', name: '最大值'},
		                    {type: 'min', name: '最小值'}
		                ]
		            }
	}
	objArr.push(obj);
</c:forEach> 
	objArr.push(cagrObj);
console.log(objArr);
var inguChart = echarts.init(document.getElementById('inguChart'));
var option = {
	    title: {
	        text: '인구 그래프'
	        
	    },
	    tooltip: {
	        trigger: 'axis'
	    },
	    legend: {
	        data:yearData
	    },
	    toolbox: {
	        show: true,
	        feature: {
	            dataZoom: {
	                yAxisIndex: 'none'
	            },
	            dataView: {readOnly: false},
	            magicType: {type: ['line', 'bar']},
	            restore: {},
	            saveAsImage: {}
	        }
	    },
	    xAxis:  {
	        type: 'category',
	        boundaryGap: true,
	        data: emdName
	    },
	    yAxis:[{
	    	type:'value',
	    	name:'연평균 증감률',
	    	axisLabel: {
	            formatter: '{value}%'
	        },barSize:0.2
	        },
	        {
	        type: 'value',
	        name:'인구',
	        axisLabel: {
	            formatter: '{value}명 '
	        }
	    	}
	    	
	    	
	    ],
	    series:objArr
	};

	inguChart.setOption(option);
</script>

