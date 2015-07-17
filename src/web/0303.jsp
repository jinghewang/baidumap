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
<div class="allmap" style="float: left" id="container"></div>
</body>
</html>
<script type="text/javascript">
  var map = new BMap.Map("container");
  map.centerAndZoom(new BMap.Point(116.404, 39.915), 13);
  map.addControl(new BMap.NavigationControl());               // 添加平移缩放控件
  map.addControl(new BMap.ScaleControl());                    // 添加比例尺控件
  map.addControl(new BMap.OverviewMapControl());              //添加缩略地图控件

  var myP1 = new BMap.Point(106.521436,29.532288);    //起点-重庆
  var myP2 = new BMap.Point(108.983569,34.285675);    //终点-西安
  var myP3 = new BMap.Point(116.404449,39.920423);    //终点-北京
  var myIcon = new BMap.Icon("http://developer.baidu.com/map/jsdemo/img/Mario.png", new BMap.Size(32, 70), {    //小车图片
    //offset: new BMap.Size(0, -5),    //相当于CSS精灵
    imageOffset: new BMap.Size(0, 0)    //图片的偏移量。为了是图片底部中心对准坐标点。
  });

  var run2 =function(){
    //弧线
    var points = [myP1,myP2,myP3];
    var curve = new BMapLib.CurveLine(points, {strokeColor:"blue", strokeWeight:3, strokeOpacity:0.5}); //创建弧线对象
    map.addOverlay(curve); //添加到地图中
    curve.enableEditing(); //开启编辑功能

    setTimeout(function(){
      map.setViewport([myP1,myP2,myP3]);          //调整到最佳视野
    },1000);
  }


  var run = function (){
    map.clearOverlays();                        //清除地图上所有的覆盖物
    var driving = new BMap.DrivingRoute(map);    //创建驾车实例
    driving.search(myP1, myP2);                 //第一个驾车搜索
    driving.search(myP2, myP3);                 //第二个驾车搜索
    driving.setSearchCompleteCallback(function(){
      var pts = driving.getResults().getPlan(0).getRoute(0).getPath();    //通过驾车实例，获得一系列点的数组

      var polyline = new BMap.Polyline(pts);
      map.addOverlay(polyline);

      var m1 = new BMap.Marker(myP1);         //创建3个marker
      var m2 = new BMap.Marker(myP2);
      var m3 = new BMap.Marker(myP3);
      map.addOverlay(m1);
      map.addOverlay(m2);
      map.addOverlay(m3);
/*      m1.setAnimation(BMAP_ANIMATION_BOUNCE);
      m2.setAnimation(BMAP_ANIMATION_BOUNCE);
      m3.setAnimation(BMAP_ANIMATION_BOUNCE);*/

      var lab1 = new BMap.Label("起点",{position:myP1});        //创建3个label
      var lab2 = new BMap.Label("途径点",{position:myP2});
      var lab3 = new BMap.Label("终点",{position:myP3});
      map.addOverlay(lab1);
      map.addOverlay(lab2);
      map.addOverlay(lab3);


      setTimeout(function(){
        map.setViewport([myP1,myP2,myP3]);          //调整到最佳视野
      },1000);

    });
  }
</script>

