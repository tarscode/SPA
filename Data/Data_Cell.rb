# encoding: utf-8
=begin
项目: SPA
类名/模块名:
文件: Data_cell.rb
功能:
输入:
输出:
作者:刘洋
日期:17/4/6
时间:下午4:37
备注:
=end
include Math
module Data_Cell
  def getCellPointArray(centerPoint)
    x1,y1,z1 = centerPoint
    pointArray = Array.new
    r = 100*1000
    for i in 0..5
      x2 = x1+r*Math.cos(i*PI/3)
      y2 = y1+r*Math.sin(i*PI/3)
      z2 = 25*1000
      point = [x2, y2, z2]
      pointArray.push(point)
    end
    p pointArray
  end

  module_function :getCellPointArray
end

Data_Cell.getCellPointArray([0,0,0])
