# encoding:utf-8
=begin
类名:Plane(平面类）
功能：组织空间中平面信息
作者：刘洋
日期：2016.3.20
备注：
=end
class Plane
  attr_accessor :id #平面编号
  attr_accessor :equation #面方程数组
  attr_accessor :point #凸点坐标
  attr_accessor :material #面材质
  attr_accessor :type #面类型
  attr_accessor :area #面类型
end
