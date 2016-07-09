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
include Math
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
  def mirrorPoint(point,planeEquation)
    x0,y0,z0 = point
    a,b,c,d = planeEquation
    t = -2*(a*x0+b*y0+c*z0+d)/(a*a+b*b+c*c)
    x1 = t*a+x0
    y1 = t*b+y0
    z1 = t*c+z0
    mirrorPoint =[x1,y1,z1]
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

  #计算路径传播时延
  def pathDelay(path,n)
    speed = 300000000000.0
    len = 0.0
    for i in 0..n-2
      len = len + pointDistance(path[i],path[i+1])
      #p "点顺序:#{path[i]}"
      #p "局部距离:#{pointDistance(path[i],path[i+1])}"
      #p "部分求和距离:#{len}"
    end

    len2 =  pointDistance(path[0],path[n-1])
      p "--------------距离差异-------------"
      p "实际距离:#{len2}"
      p "数组路径距离:#{len}"
    delay = len*1.0/speed
    return delay;
  end

  module_function :pathDelay
end
beginPoint = [135000.0, 17000.0 ,8100.0]
endPoint = [18224.586909535756,321.4852746658525,4012.536088514577]
p Space_Base.pointDistance(beginPoint, endPoint)
p Space_Base.pathDelay([beginPoint,endPoint],2)