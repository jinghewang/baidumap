<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2015/7/17
  Time: 17:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
  <title>添加/删除覆盖物</title>
  <jsp:include page="tiles/main_head.jsp"></jsp:include>
  <style>
    .test{
      list-style: none;
      list-style-position: inside;
    }
    .test li{
      float: left;
    }
  </style>
</head>
<body>
<ul class="test">
  <li><input type='button' value='开始' onclick='run();' /></li>
  <li><input type='button' value='开始2' onclick='run2();' /></li>
</ul>
<div class="allmap" style="float: left" id="allmap"></div>
</body>
</html>
<script type="text/javascript">
  var map = new BMap.Map("allmap");
  map.centerAndZoom(new BMap.Point(116.404, 39.915), 13);
  map.addControl(new BMap.NavigationControl());               // 添加平移缩放控件
  map.addControl(new BMap.ScaleControl());                    // 添加比例尺控件
  map.addControl(new BMap.OverviewMapControl());              //添加缩略地图控件

  var myP1 = new BMap.Point(106.521436,29.532288);    //起点-重庆
  var myP2 = new BMap.Point(108.983569,34.285675);    //终点-西安
  var myIcon = new BMap.Icon("http://developer.baidu.com/map/jsdemo/img/Mario.png", new BMap.Size(32, 70), {    //小车图片
    //offset: new BMap.Size(0, -5),    //相当于CSS精灵
    imageOffset: new BMap.Size(0, 0)    //图片的偏移量。为了是图片底部中心对准坐标点。
  });
  var driving2 = new BMap.DrivingRoute(map, {renderOptions:{map: map, autoViewport: true}});    //驾车实例
  driving2.search(myP1, myP2);    //显示一条公交线路

  window.run = function (){
    var driving = new BMap.DrivingRoute(map);    //驾车实例
    driving.search(myP1, myP2);
    driving.setSearchCompleteCallback(function(){
      var pts = driving.getResults().getPlan(0).getRoute(0).getPath();    //通过驾车实例，获得一系列点的数组
      var paths = pts.length;    //获得有几个点

      var carMk = new BMap.Marker(pts[0],{icon:myIcon});
      map.addOverlay(carMk);
      i=0;
      function resetMkPoint(i){
        carMk.setPosition(pts[i]);
        if(i < paths){
          setTimeout(function(){
            i+=100;
            resetMkPoint(i);
          },100);
        }
      }
      setTimeout(function(){
        resetMkPoint(5);
      },100)

    });
  }

  setTimeout(function(){
    run();
  },1500);
</script>
