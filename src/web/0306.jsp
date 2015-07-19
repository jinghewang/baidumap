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
  map.addEventListener("click", function(e){
      alert(e.point.lng + ", " + e.point.lat);
  });

  var myP1 = new BMap.Point(109.514391, 18.264731);    //起点-三亚
  var waypoints = [new BMap.Point(119.275342, 26.130281),new BMap.Point(121.47229, 31.262899)];//福州，上海
  var myP3 = new BMap.Point(116.404449,39.920423);    //终点-北京

  var myPoints = [];
  myPoints = myPoints.concat(myP1);
  myPoints = myPoints.concat(waypoints);
  myPoints = myPoints.concat(myP3);

  //http://localhost:8080/static/img/fly.png
  var myIcon = new BMap.Icon("http://localhost:8080/static/img/plane.png", new BMap.Size(128, 128), {    //小车图片
    //offset: new BMap.Size(0, -5),    //相当于CSS精灵
    imageOffset: new BMap.Size(0, 0)    //图片的偏移量。为了是图片底部中心对准坐标点。
  });

  //label
  var lab1 = new BMap.Label("三亚",{position:myP1});        //创建3个label
  var lab3 = new BMap.Label("北京",{position:myP3});
  map.addOverlay(lab1);
  map.addOverlay(lab3);

  var driving2 = new BMap.DrivingRoute(map, {renderOptions:{map: map, autoViewport: true}});    //驾车实例
  driving2.search(myP1, myP3,{waypoints:waypoints});    //显示一条公交线路
  //driving2.search(myP2, myP3);    //显示一条公交线路

  //00
  var curve = new BMapLib.CurveLine(myPoints, {strokeColor:"blue", strokeWeight:3, strokeOpacity:0.5}); //创建弧线对象
  map.addOverlay(curve); //添加到地图中
  curve.enableEditing();
  var points = curve.getPath();


  var run = function (){
    var driving = new BMap.DrivingRoute(map);    //驾车实例
    driving.search(myP1, myP3,{waypoints:waypoints});

    driving.setSearchCompleteCallback(function(){
      var routes_num = driving.getResults().getPlan(0).getNumRoutes();
      var pts = [];
      for(var i=0;i<routes_num;i++){
        var pt = driving.getResults().getPlan(0).getRoute(i).getPath();
        pts = pts.concat(pt);
        //console.info(pts.length);
      }

      //替换内容
      pts = points;
      //var pts = driving.getResults().getPlan(0).getRoute(0).getPath();    //通过驾车实例，获得一系列点的数组
      var paths = pts.length;    //获得有几个点

      var carMk = new BMap.Marker(pts[0],{icon:myIcon});
      map.addOverlay(carMk);
      i=0;
      function resetMkPoint(i){
        carMk.setPosition(pts[i]);
        if(i < paths){
          setTimeout(function(){
            i+=3;
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

