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
</head>
<body>
<div id="allmap"></div>
</body>
</html>
<script type="text/javascript">
  // 百度地图API功能
  var map = new BMap.Map("allmap");
  var point = new BMap.Point(116.404, 39.915);
  map.centerAndZoom(point, 15);
  //--
  map.addControl(new BMap.NavigationControl());               // 添加平移缩放控件
  map.addControl(new BMap.ScaleControl());                    // 添加比例尺控件
  map.addControl(new BMap.OverviewMapControl());              //添加缩略地图控件

  //marker
  var marker = new BMap.Marker(point);  // 创建标注
  map.addOverlay(marker);               // 将标注添加到地图中
  marker.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画

  //--
  //创建小狐狸
  var pt = new BMap.Point(116.417, 39.909);
  var myIcon = new BMap.Icon("http://developer.baidu.com/map/jsdemo/img/fox.gif", new BMap.Size(300,157));
  var marker2 = new BMap.Marker(pt,{icon:myIcon});  // 创建标注
  map.addOverlay(marker2);              // 将标注添加到地图中

</script>

