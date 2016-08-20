# encoding: utf-8
=begin
项目: SPA
类名/模块名:
文件: Ray_Init.rb
功能:
输入:
输出:
作者:刘洋
日期:16/8/16
时间:下午4:59
备注:
=end
require File.join(File.expand_path(".."), '/Entity/Cube')
require File.join(File.expand_path(".."), '/Entity/Point')
require File.join(File.expand_path(".."), '/Space/Space_Base')
module Ray_Init
  #计算镜像点数组
  def mirrorPointArray(point, cubeArray)
    mirrorPointArray = Array.new
    cubeArray.each do |cube|
      cube.plane.each do |plane|
        coordinate = Space_Base.mirrorPoint(point.coordinate, plane.equation) #求源点的镜像点
        mirrorPoint = Point.new(coordinate, point, plane, cube)
        mirrorPointArray.push(mirrorPoint)
      end
    end
    return mirrorPointArray
  end

  module_function :mirrorPointArray

  #初始化建立虚拟源树
  def initPointTree(ne, cubeArray)
    beginPoint = Point.new(ne.coordinate, nil, nil, nil)
    pointLevelOneArray = mirrorPointArray(beginPoint, cubeArray) #获取源点镜像点,即二级源点
    beginPoint.child = pointLevelOneArray
    pointLevelOneArray.each do |point|
      p "init"
      pointLevelTwoArray = mirrorPointArray(point, cubeArray) #获取三级源点
      point.child = pointLevelTwoArray
    end
    return beginPoint
  end

  module_function :initPointTree
end
