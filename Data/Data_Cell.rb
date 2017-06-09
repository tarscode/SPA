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
    x1, y1, z1 = centerPoint
    pointArray = Array.new
    r = 100*1000
    id = 0
    for i in 0..5
      id = id + 1
      x2 = x1+r*Math.cos(i*PI/3)
      y2 = y1+r*Math.sin(i*PI/3)
      z2 = 25*1000
      point = [id, x2, y2, z2]
      pointArray.push(point)
      p i.to_s+' '+x2.to_s+' '+y2.to_s+' '+z2.to_s
    end
    return pointArray
  end

  module_function :getCellPointArray

  def getIndoorCellPointArray()
    id = 101
    pointArray = Array.new
    ne1 = [15*1000, 15*1000, 2.5*1000]
    ne2 = [45*1000, 35*1000, 2.5*1000]
    ne3 = [75*1000, 15*1000, 2.5*1000]
    ne4 = [105*1000, 30*1000, 2.5*1000]
    for i in 1..4
      z = (3*(i-1)+2.5)*1000
      point1 = [id, ne1[0], ne1[1], z]
      point2 = [id+1, ne2[0], ne2[1], z]
      point3 = [id+2, ne3[0], ne3[1], z]
      point4 = [id+3, ne4[0], ne4[1], z]
      id = id+4
      pointArray.push(point1)
      pointArray.push(point2)
      pointArray.push(point3)
      pointArray.push(point4)
    end
    return pointArray
  end

  module_function :getIndoorCellPointArray

  def ue(allnum)
    id = 10000;
    ueArray = Array.new
    num = 2*allnum/3
    outnum = allnum - num
    for i in 1..num
      prng = Random.new(i)
      id = id+1
      x = prng.rand(0.0...120*1000)
      y = prng.rand(0.0...50*1000.0)
      if i>1 && i<num/4 then
        z = 1.5*1000
      end
      if i>=num/4 && i<2*num/4 then
        z = 4.5*1000
      end
      if i>2*num/4 && i<3*num/4 then
        z = 7.5*1000
      end
      if i>=3*num/4 then
        z = 10.5*1000
      end
      ue =[id, x, y, z]
      ueArray.push(ue)
    end

    for i in 1..outnum
      prng = Random.new(i)
      id = id+1
      x = prng.rand((60-70)*1000...(60+70)*1000)
      y = prng.rand((60-70)*1000...(60+70)*1000)
      z = 1.5*1000
      ue =[id, x, y, z]
      ueArray.push(ue)
    end

    return ueArray
  end

  module_function :ue

end

#Data_Cell.getCellPointArray([0, 0, 0])
p Data_Cell.getIndoorCellPointArray()
