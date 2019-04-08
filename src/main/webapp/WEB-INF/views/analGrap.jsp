<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div id="analGrap" style="width:1000px; height: 300px;"></div>
<div id="my" style="width:1000px; height: 300px;"></div>
<script>
var myChart = echarts.init(document.getElementById('my'));
var analChart = echarts.init(document.getElementById('analGrap'));
var dataList=[];
var emdNameList=[];
var yearData=[];
	var jigaData14=[];
	var jigaData15=[];
	var jigaData16=[];
	var jigaData17=[];
<c:forEach items="${jigaDataList}" var="emd"  >
	<c:if test="${not empty emd.per_14_15}">
	jigaData14.push('${emd.per_14_15}');
	</c:if>
	<c:if test="${not empty emd.per_15_16}">
	jigaData15.push('${emd.per_15_16}');
	</c:if>
	<c:if test="${not empty emd.per_16_17}">
	jigaData16.push('${emd.per_16_17}');
	</c:if>
	<c:if test="${not empty emd.per_17_18}">
	jigaData17.push('${emd.per_17_18}');
	</c:if>
</c:forEach>
var jigaPerOBJ={
		jiga14:jigaData14,
		jiga15:jigaData15,
		jiga16:jigaData16,
		jiga17:jigaData17
};
	var inguData14=[];
	var inguData15=[];
	var inguData16=[];
	var inguData17=[];
<c:forEach items="${inguEmdList}" var="emd"  >
	<c:if test="${not empty emd.per_14_15}">
	inguData14.push('${emd.per_14_15}');
	</c:if>
	<c:if test="${not empty emd.per_15_16}">
	inguData15.push('${emd.per_15_16}');
	</c:if>
	<c:if test="${not empty emd.per_16_17}">
	inguData16.push('${emd.per_16_17}');
	</c:if>
	<c:if test="${not empty emd.per_17_18}">
	inguData17.push('${emd.per_17_18}');
	</c:if>
</c:forEach>
var inguPerOBJ={
		ingu14:inguData14,
		ingu15:inguData15,
		ingu16:inguData16,
		ingu17:inguData17
};
console.log(inguPerOBJ)
<c:forEach items="${analDataList}" var="emd" varStatus="status" >
	var jigaData=[];
	var inguData=[];
	<c:if test="${not empty emd.jiga_14}">
	jigaData.push("${emd.jiga_14}")
	</c:if>
	<c:if test="${not empty emd.jiga_15}">
	jigaData.push('${emd.jiga_15}');
	</c:if>
	<c:if test="${not empty emd.jiga_16}">
	jigaData.push('${emd.jiga_16}');
	</c:if>
	<c:if test="${not empty emd.jiga_17}">
	jigaData.push('${emd.jiga_17}');
	</c:if>
	<c:if test="${not empty emd.jiga_18}">
	jigaData.push('${emd.jiga_18}');
	</c:if>
	<c:if test="${not empty emd.ingu_14}">
	inguData.push("${emd.ingu_14}")
	</c:if>
	<c:if test="${not empty emd.ingu_15}">
	inguData.push('${emd.ingu_15}');
	</c:if>
	<c:if test="${not empty emd.ingu_16}">
	inguData.push('${emd.ingu_16}');
	</c:if>
	<c:if test="${not empty emd.ingu_17}">
	inguData.push('${emd.ingu_17}');
	</c:if>
	<c:if test="${not empty emd.ingu_18}">
	inguData.push('${emd.ingu_18}');
	</c:if>
emdNameList.push('${emd.emd_nm}')

var jigaObj={
			name:"${emd.emd_nm}",
            type:'bar',
            data:jigaData
	}	
	 var inguObj={
			name:"${emd.emd_nm}",
            type:'line',
            data:inguData,
            yAxisIndex: 1
            
	} 
	
console.log(jigaData);
console.log(inguData);
dataList.push(jigaObj);
dataList.push(inguObj);
</c:forEach>
console.log(emdNameList);
var start="${start}";
var perArr=[];
var yearArr2=[];
<c:forEach items="${yearArr}" var="year" varStatus="status" >
yearData.push('${year}');
yearArr2.push('${year} 지가')
yearArr2.push('${year} 인구')

 if(!${status.last}){
		
	console.log("jigaPerOBJ.jiga${status.count+start-1}")
	console.log("몇번이나나올까?")
var obj={
 		name:"${year} 지가" ,
            type:'line',
            data:jigaPerOBJ.jiga${status.count+start-1},
            markPoint: {
                data: [
                    {type: 'max', name: '最大值'},
                    {type: 'min', name: '最小值'}
                ]
            },
            markLine: {
                data: [
                    {type: 'average', name: '平均值'}
                ]
            }
} 
 var obj2={
 		name:"${year} 인구",
            type:'line',
            data:inguPerOBJ.ingu${status.count+start-1},
            markPoint: {
                data: [
                    {type: 'max', name: '最大值'},
                    {type: 'min', name: '最小值'}
                ]
            },
            markLine: {
                data: [
                    {type: 'average', name: '平均值'}
                ]
            }
} 
perArr.push(obj);
 perArr.push(obj2);
}
</c:forEach>
console.log(perArr)
console.log(dataList)
var option = {
  
    tooltip : {
        trigger: 'axis'
    },
    legend: {
        data:emdNameList
    },
    toolbox: {
        show : true,
        feature : {
            dataView : {show: true, readOnly: false},
            magicType : {show: true, type: ['line', 'bar']},
            restore : {show: true},
            saveAsImage : {show: true}
        }
    },
    calculable : true,
    xAxis : [
        {
            type : 'category',
            data : yearData
        }
    ],
    yAxis : [
        {
            type : 'value',
            	name:'지가',
    	        axisLabel: {
    	            formatter: '{value}원'
    	        }
        },{
        	type : 'value',
        	name:'인구',
	        axisLabel: {
	            formatter: '{value}명'
	        }
        }
        
    ],
    series :dataList
    
};
var option1 = {
	    title: {
	        text: '전년대비 증감률'
	        
	    },
	    tooltip: {
	        trigger: 'axis'
	    },
	    legend: {
	        data:yearArr2
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
	        boundaryGap: false,
	        data: emdNameList
	    },
	    yAxis:[ {
	        type: 'value',
	        name:'성장률',
	        axisLabel: {
	            formatter: '{value}%'
	        }
	    }
	    	
	    	
	    ],
	    series:perArr
	};

	myChart.setOption(option1); 
	analChart.setOption(option);
</script>