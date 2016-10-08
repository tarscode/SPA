# encoding:utf-8
=begin
函数名：diffractionPoint
输入：源点坐标数组
      场点坐标数组
      劈位置所处的横纵坐标
输出：绕射点点坐标数组
功能：计算绕射点坐标
作者：宋世伟
日期：2016.6.15
备注：
=end
include Math
require File.join($SPA_Path,'/Space/Space_Base')
module Space_DifPoint
def diffractionPoint(beginPoint,endPoint,wedge)
    x1,y1,z1 = beginPoint
    x2,y2,z2 = endPoint
    #xd,yd,zd= wedge
    precision=0.0000000001
  x01 ,y01, z01 =wedge[0]
  x02 ,y02, z02 =wedge[1]
    wedge[0],wedge[1]=wedge
    x0=(x01-x02).abs
    y0=(y01-y02).abs
    z0=(z01-z02).abs
    if x0<precision&&y0<precision then
    z00=z2+(z1-z2)*((Space_Base.distance(endPoint,wedge[0][0,3],wedge[1][0,3]))/(Space_Base.distance(beginPoint,wedge[0][0,3],wedge[1][0,3])+Space_Base.distance(endPoint,wedge[0][0,3],wedge[1][0,3])))*1.0
    y00=y02+y0*(z00-z02)/z0
    x00=x02+x0*(z00-z02)/z0
    end
    if x0<precision&&z0<precision then
      y00=y2+(y1-y2)*((Space_Base.distance(endPoint,wedge[0][0,3],wedge[1][0,3]))/(Space_Base.distance(beginPoint,wedge[0][0,3],wedge[1][0,3])+Space_Base.distance(endPoint,wedge[0][0,3],wedge[1][0,3])))*1.0
      z00=z02+z0*(y00-y02)/y0
      x00=x02+x0*(y00-y02)/y0
      end
    if y0<precision&&z0<precision then
      x00=x2+(x1-x2)*((Space_Base.distance(endPoint,wedge[0][0,3],wedge[1][0,3]))/(Space_Base.distance(beginPoint,wedge[0][0,3],wedge[1][0,3])+Space_Base.distance(endPoint,wedge[0][0,3],wedge[1][0,3])))*1.0
      y00=y02+y0*(x00-x02)/x0
      z00=z02+x0*(x00-x02)/x0
    end

    diffractionPoint =[x00,y00,z00]

    return diffractionPoint

end
module_function :diffractionPoint
end



