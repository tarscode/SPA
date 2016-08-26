# encoding:utf-8
=begin
类名:Point（交点类）
功能：组织空间中交点信息
作者：刘洋
日期：2016.3.25
备注：
=end
class Point
  attr_accessor :id#id
  attr_accessor :coordinate#坐标
  attr_accessor :fatherId#父节点
  attr_accessor :level#节点级别
  attr_accessor :planeId#镜像点的面id
  attr_accessor :cubeId#镜像点的物体的id
  attr_accessor :child#子节点数组id
  def initialize(initCoordinate,initFather,initPlane,initCube)
    @coordinate = initCoordinate
    @fatherId = initFather
    @planeId = initPlane
    @cubeId = initCube
  end
end
