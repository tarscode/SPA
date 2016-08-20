# encoding:utf-8
=begin
类名:Point（交点类）
功能：组织空间中交点信息
作者：刘洋
日期：2016.3.25
备注：
=end
class Point
  attr_accessor :coordinate#坐标
  attr_accessor :father#父节点
  attr_accessor :child#子节点数组
  attr_accessor :plane#镜像点的面
  attr_accessor :cube#镜像点的物体
  def initialize(initCoordinate,initFather,initPlane,initCube)
    @coordinate = initCoordinate
    @father = initFather
    @plane = initPlane
    @cube = initCube
  end
end
