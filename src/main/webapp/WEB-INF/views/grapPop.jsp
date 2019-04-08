<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<h3>
	<a href="javascript:void(0)" class="closebtn" id='grapClose'
		style="right: 0%; position: absolute; top: 0;">&times;</a>
</h3>
<div id="my" style="width:800px; height: 300px;"></div>

<script type="text/javascript">
$("#grapClose").on('click',function(){
	console.log("aa")
	$("#jigaGrap").html("")
})
var emdName=[];
var jigaData14=[];
var jigaData15=[];
var jigaData16=[];
var jigaData17=[];
var jigaData18=[];
var emdCagr=[];
<c:forEach items="${emdList}" var="jiga" varStatus="status" >
	emdName.push('${jiga.emd_nm}');
	emdCagr.push('${jiga.cagr}')
	<c:if test="${not empty jiga.jiga_14}">
		jigaData14.push('${jiga.jiga_14}');
	</c:if>
	<c:if test="${not empty jiga.jiga_15}">
	jigaData15.push('${jiga.jiga_15}');
	</c:if>
	<c:if test="${not empty jiga.jiga_16}">
	jigaData16.push('${jiga.jiga_16}');
	</c:if>
	<c:if test="${not empty jiga.jiga_17}">
	jigaData17.push('${jiga.jiga_17}');
	</c:if>
	<c:if test="${not empty jiga.jiga_18}">
	jigaData18.push('${jiga.jiga_18}');
	</c:if>
</c:forEach>
console.log("chabge2")
var cagrObj={
		name:'연평균 증감률',
		type:'bar',
		data:emdCagr,
		
		 barWidth: 30,
		lineStyle: {
            normal: {
                width: 10,
                shadowColor: 'rgba(0,0,0,0.4)',
                shadowBlur: 10,
                shadowOffsetY: 10
            }
        },
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
		            type:'line',
		            yAxisIndex: 1,
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
var myChart = echarts.init(document.getElementById('my'));
var option = {
	    title: {
	        text: '지가 그래프'
	        
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
	            magicType: {type: ['bar', 'line']},
	            restore: {},
	            saveAsImage: {}
	        }
	    },
	    xAxis:  {
	        type: 'category',
	        boundaryGap: true,
	        data: emdName
	    },
	    yAxis:[ {
	    	type:'value',
	    	name:'연평균 증감률',
	    	axisLabel: {
	            formatter: '{value}%'
	        },
	        barSize:0.2
	    	},
	            {
	        type: 'value',
	        name:'지가',
	        axisLabel: {
	            formatter: '{value}원 '
	        }
	    }
	    	
	    ],
	    series:objArr
	};

	myChart.setOption(option);
</script>

