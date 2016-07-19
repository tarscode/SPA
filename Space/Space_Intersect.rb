# encoding: utf-8
=begin
项目: SPA
类名/模块名:
文件: Space_Intersect.rb
功能:
输入:
输出:
作者:刘洋
日期:16/6/20
时间:下午4:53
备注:
=end
require File.join(File.expand_path(".."), '/IO/SPA_Write')
module Space_Intersect
  def intersect(beginPoint, endPoint, plane)
    x1, y1, z1 = beginPoint
    x2, y2, z2 = endPoint #直线起点和终点坐标赋值
    (u1, v1, w1), (u2, v2, w2), (u3, v3, w3), (u4, v4, w4) = plane.point #平面凸点坐标赋值
    a, b, c, d = plane.equation #平面方程系数赋值
    l, m, n = x2-x1, y2-y1, z2-z1 #计算方向向量
    r = l*a+m*b+n*c
    intersectPoint = [x1, y1, z1] #设置默认返回

    #验证平面方程合法性
    equationValue = verifyEquation(plane)
    #直线和平面垂直则返回直线起点坐标
    if r == 0 then
      return intersectPoint
    end
    #计算t的分子和分母
    t1 = (a*x1+b*y1+c*z1+d)*1.0
    t2 = (a*x2+b*y2+c*z2+d)
    if t1 == 0 then
       x,y,z = x1,y1,z1 #起点在平面上
    elsif t2 == 0 then
      x,y,z = x2,y2,z2 #终点在平面上
    else
      t = t1/t2 #系数t计算,注意乘以1.0,否则取整数
      x, y, z = (x1-t*x2)/(1-t), (y1-t*y2)/(1-t), (z1-t*z2)/(1-t) #直线和平面相交点计算结果坐标
    end
    #SPA_Write.baseWrite("平面", plane.id.to_s)
    SPA_Write.baseWrite("平面方程合法性",equationValue.to_s)
    #SPA_Write.baseWrite("t:",t.to_s)
    #SPA_Write.baseWrite("分子:",(a*x2+b*y2+c*z2+d).to_s)
    #SPA_Write.baseWrite("交点坐标", x.to_s+" "+y.to_s+" "+z.to_s)
    #如果相交坐标在平面外，返回直线终点坐标
    intersectPoint = [x2, y2, z2]

    if x>u1&&x>u2&&x>u3&&x>u4 then
      return intersectPoint
    end

    if x<u1&&x<u2&&x<u3&&x<u4 then
      return intersectPoint
    end

    if y>v1&&y>v2&&y>v3&&y>v4 then
      return intersectPoint
    end

    if y<v1&&y<v2&&y<v3&&y<v4 then
      return intersectPoint
    end

    if z>w1&&z>w2&&z>w3&&z>w4 then
      return intersectPoint
    end

    if z<w1&&z<w2&&z<w3&&z<w4 then
      return intersectPoint
    end
    #相交点在直线两个端点外直接返回终点坐标
    if x>x1&&x>x2 then
      return intersectPoint
    end

    if x<x1&&x<x2 then
      return intersectPoint
    end

    if y>y1&&y>y2 then
      return intersectPoint
    end
    if y<y1&&y<y2 then
      return intersectPoint
    end

    if z>z1&&z>z2 then
      return intersectPoint
    end

    if z<z1&&z<z2 then
      return intersectPoint
    end

    #通过全部合法性测试，相交点在平面内
    intersectPoint = [x, y, z]
    return intersectPoint
  end

  module_function :intersect

  #验证线面交点合法性
  def verifyPoint(beginPoint, endPoint, interPoint)
    x1, y1, z1 = beginPoint
    x2, y2, z2 = endPoint
    x3, y3, z3 = interPoint
    if x1==x3&&y1==y3&&z1==z3 then
      return 1 #无交点
    elsif x2==x3&&y2==y3&&z2==z3 then
      return 1 #无交点
    else
      return 0 #有交点
    end
  end

  module_function :verifyPoint

  #验证平面方程合法性
  def verifyEquation(plane)
    (u1, v1, w1), (u2, v2, w2), (u3, v3, w3), (u4, v4, w4) = plane.point #平面凸点坐标赋值
    a, b, c, d = plane.equation #平面方程系数赋值
    pointValue1 = a*u1+b*v1+c*w1+d
    pointValue2 = a*u2+b*v2+c*w2+d
    pointValue3 = a*u3+b*v3+c*w3+d
    pointValue4 = a*u4+b*v4+c*w4+d
    if pointValue1<0.1&&pointValue1>-0.1&&pointValue2<0.1&&pointValue2>-0.1&&pointValue3<0.1&&pointValue3>-0.1&&pointValue4<0.1&&pointValue4>-0.1
      return 0 #平面方程合法
    else
      return 1 #平面方程非法
    end
  end

  module_function :verifyEquation

  #判定绕射点是否在劈上
  def intersectDif(beginPoint, endPoint, wedge,difPoint)
    x1, y1, z1 = beginPoint
    x2, y2, z2 = endPoint #直线起点和终点坐标赋值
    (u1, v1, w1), (u2, v2, w2) = wedge #劈坐标赋值
    x, y, z= difPoint #绕射点坐标赋值
    l1, m1, n1 = x2-x1, y2-y1, z2-z1 #计算方向向量
    l2, m2, n2 = u2-u1, v2-v1, z2-z1
    r = l1*l2+m1*m2+n1*n2
    intersectPoint = [x1, y1, z1] #设置默认返回

    #验证平面方程合法性
    #equationValue = verifyEquation(plane)
    #直线和平面垂直则返回直线起点坐标
    if r == 0 then
      return intersectPoint
    end
    #如果相交坐标在平面外，返回直线终点坐标
    intersectPoint = [x2, y2, z2]

    if x>u1&&x>u2 then
      return intersectPoint
    end

    if x<u1&&x<u2 then
      return intersectPoint
    end

    if y>v1&&y>v2 then
      return intersectPoint
    end

    if y<v1&&y<v2 then
      return intersectPoint
    end

    if z>w1&&z>w2 then
      return intersectPoint
    end

    if z<w1&&z<w2 then
      return intersectPoint
    end
    #相交点在直线两个端点外直接返回终点坐标
    if x>x1&&x>x2 then
      return intersectPoint
    end

    if x<x1&&x<x2 then
      return intersectPoint
    end

    if y>y1&&y>y2 then
      return intersectPoint
    end
    if y<y1&&y<y2 then
      return intersectPoint
    end

    if z>z1&&z>z2 then
      return intersectPoint
    end

    if z<z1&&z<z2 then
      return intersectPoint
    end

    #通过全部合法性测试，相交点在线段内
    intersectPoint = [x, y, z]
    return intersectPoint
  end
  module_function :intersectDif

  #判定绕射点合法性
  def difRactPoint(beginpoint,endpoint,diFrPoint,cube)
    # p "test3#{cube.plane}"
    for i in 0..5
      j=0
      difRactPoint1=intersect(beginpoint,diFrPoint,cube.plane[i])
      difRactPoint2=intersect(endpoint,diFrPoint,cube.plane[i])
      if (difRactPoint1!=beginpoint&&difRactPoint1!=diFrPoint)||(difRactPoint2!=endpoint&&difRactPoint2!=diFrPoint)
        j=j+1
      else
        j=j+0
      end
    end
    if j==0
      return 0
    else
      return  1
    end
  end
  module_function :difRactPoint
end