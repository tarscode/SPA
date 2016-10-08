# encoding: utf-8
=begin
项目: SPA
类名/模块名:
文件: Space_Base.rb
功能:
输入:
输出:
作者:刘洋
日期:16/6/20
时间:下午5:03
备注:
=end
require File.join($SPA_Path, '/Entity/Cube')
require File.join($SPA_Path, '/Entity/Plane')
require File.join($SPA_Path, '/Entity/Point')
include Math
require 'complex'
require 'cmath'
module Space_Base
  #两点之间的距离
  def pointDistance(beginPoint, endPoint)
    if beginPoint == endPoint then
      return 0.0
    end
    x1, y1, z1 = beginPoint
    x2, y2, z2 = endPoint
    length = Math.sqrt((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1)+(z2-z1)*(z2-z1))
    return length
  end

  module_function :pointDistance

  #路径的距离
  def pathDistance(path, n)
    #可以设计成全局变量,提出一个变量模块
    len = 0.0
    for i in 0..n-2
      len = len + pointDistance(path[i], path[i+1])
    end
    return len;
  end

  module_function :pathDistance

  #计算两点之间线方程,有问题
  def lineEquation(beginPoint, endPoint)
    x1, y1, z1 = beginPoint
    x2, y2, z2 = endPoint
    a = (y2-y1)*(z2-z1)
    b = (-1)*(x2-x1)*(z2-z1)
    c = (-1)*(x2-x1)*(y2-y1)
    d = (y2-y1)*(z2-z1)*(-x1)-(x2-x1)*(z2-z1)*(-y1)-(x2-x1)*(y2-y1)*(-z1)
    line = [a, b, c, d]
    return line
  end

  #计算点关于平面的镜像点
  def mirrorPoint(point, planeEquation)
    x0, y0, z0 = point
    a, b, c, d = planeEquation
    t = -2*(a*x0+b*y0+c*z0+d)/(a*a+b*b+c*c)
    x1 = t*a+x0
    y1 = t*b+y0
    z1 = t*c+z0
    mirrorPoint =[x1, y1, z1]
    return mirrorPoint
  end

  module_function :mirrorPoint

  #计算直线和平面夹角
  def linePlaneAngle(beginPoint, endPoint, planeEquation)
    x1, y1, z1 = beginPoint
    x2, y2, z2 = endPoint
    m, n, p = x2-x1, y2-y1, z2-z1
    a, b, c = planeEquation
    n = PI/2-asin((a*m+b*n+c*p).abs/(Math.sqrt(a*a+b*b+c*c)*Math.sqrt(m*m+n*n+p*p)))
    return n
  end

  module_function :linePlaneAngle

  #计算物体中心坐标
  def cubeCenter(cube)
    x = 0
    y = 0
    z = 0
    cube.plane.each do |plane|
      x=x+plane.point[0][0]+plane.point[1][0]+plane.point[2][0]+plane.point[3][0]
      y=y+plane.point[0][1]+plane.point[1][1]+plane.point[2][1]+plane.point[3][1]
      z=z+plane.point[0][2]+plane.point[1][2]+plane.point[2][2]+plane.point[3][2]
    end
    centerPoint = [x*1.0/12, y*1.0/12, z*1.0/12]
    return centerPoint
  end

  module_function :cubeCenter

  #计算平面中心坐标
  def planeCenter(plane)
    x, y, z = 0, 0, 0
    pointArray = plane.point
    len = pointArray.length
    for i in 0..len-1
      x = x + pointArray[i][0]
      y = y + pointArray[i][1]
      z = z + pointArray[i][2]
    end
    centerPoint = [x*1.0/len, y*1.0/len, z*1.0/len]
    return centerPoint
  end

  module_function :planeCenter

  #计算路径传播时延
  def pathDelay(path, n)
    #speed = 300000000000.0
    speed = 299792458000.0
    len = 0.0
    for i in 0..n-2
      len = len + pointDistance(path[i], path[i+1])
    end
    delay = len*1.0/speed
    return delay;
  end

  module_function :pathDelay

  #计算两条直线之间的夹角
  def lineLineAngle(beginPoint1, endPoint1, beginPoint2, endPoint2)
    x1, y1, z1 = beginPoint1
    x2, y2, z2 = endPoint1
    x3, y3, z3 = beginPoint2
    x4, y4, z4 = endPoint2
    a1, b1, c1 = x1-x2, y1-y2, z1-z2
    a2, b2, c2 = x3-x4, y3-y4, z3-z4
    n=Math.acos((a1*a2+b1*b2+c1*c2).abs/(Math.sqrt(a1**2+b1**2+c1**2)*Math.sqrt(a2**2+b2**2+c2**2)))
    return n
  end

  module_function :lineLineAngle

  #算积分
  def integral (a, b, n=1000)
    sum=0.0
    dx=(b-a)/n.to_f
    n.times do
      a +=dx
      sum=sum+(yield a)*dx
    end
    sum
  end

  module_function :integral

  #点到直线距离
  def distance(point, firstPoint, lastpoint)
    x1, y1, z1 =point
    x2, y2, z2 = firstPoint
    x3, y3, z3 = lastpoint
    sa =Math.sqrt((x1-x2)**2+(y2-y1)**2+(z2-z1)**2)
    sb =Math.sqrt((x1-x3)**2+(y3-y1)**2+(z3-z1)**2)
    sc =Math.sqrt((x3-x2)**2+(y3-y2)**2+(z3-z2)**2)
    h=(sa+sb+sc)/2
    s=Math.sqrt(h*(h-sa)*(h-sb)*(h-sc))
    distance =2*s/sc
    return distance
  end

  module_function :distance

  #计算镜像点数组
  def mirrorPointArray(point, cubeArray)
    mirrorPointArray = Array.new
    cubeArray.each do |cube|
      cube.plane.each do |plane|
        if plane.area < 430000 then #排除小面
          next
        end

        if plane.area > 599900 &&plane.area < 600100 then #排除小面
          next
        end

        if plane.area > 899900 &&plane.area < 900100 then #排除小面
          next
        end

        if plane.area > 499900 &&plane.area < 500100 then #排除小面
          next
        end

        if plane.area > 539900 &&plane.area < 540100 then #排除小面
          next
        end

        $logger.info("cubeId:"+cube.id.to_s)
        interPlanePoint = planeCenter(plane)
        pointResult = verifyReflectPlane(point.coordinate, interPlanePoint, cube, plane)
        if  pointResult== true then
          coordinate = mirrorPoint(point.coordinate, plane.equation) #求源点的镜像点
          mirrorPoint = Point.new(coordinate, point.id, plane.id, cube.id)
          mirrorPointArray.push(mirrorPoint)
        else
          next
        end
      end
    end
    return mirrorPointArray
  end

  module_function :mirrorPointArray

  #判断反射面的有效性
  def verifyReflectPlane(beginPoint, reflectPoint, cube, reflectPlane)
    cube.plane.each do |plane|
      $logger.info("planeId:"+plane.id.to_s)
      if plane.id == reflectPlane.id then
        $logger.info("nextId:"+plane.id.to_s)
        next
      end
      intersectPoint = Space_Intersect.intersect(beginPoint, reflectPoint, plane)
      pointResult = Space_Intersect.verifyPoint(beginPoint, reflectPoint, intersectPoint)
      $logger.info("intersectPoint:"+intersectPoint.to_s+"pointResult:"+pointResult.to_s)
      if pointResult == 0 then
        return false
      end
    end
    return true
  end

  module_function :verifyReflectPlane
end
