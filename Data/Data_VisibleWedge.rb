# encoding: utf-8
=begin
项目: SPA
类名/模块名:
文件: Data_VisibleWedge.rb
功能:
输入:
输出:
作者:宋世伟
日期:16/6/24
时间:下午2:13
备注:
=end
require File.join(File.expand_path(".."), '/Entity/Path')
require File.join(File.expand_path(".."), '/Entity/Cube')
require File.join(File.expand_path(".."), '/IO/SPA_Read')

module Data_VisibleWedge
  def wedgeArray (cube)

    wedgeArray = Array.new #可见劈数组
    #cubeArray.each do |cube|
      for i in 0 ..4
        for j in i+1..5
          if compare1(cube.plane[i],cube.plane[j]).length!= 0 then
          wedgePoint=compare1(cube.plane[i], cube.plane[j])
          wedge =[wedgePoint, cube.plane[i], cube.plane[j]]
          wedgeArray.push(wedge)

          end
        end
      end
    #end
  #  p wedgeArray
    return wedgeArray
  end


module_function :wedgeArray

def compare1(plane_A, plane_B)
  wedgePoint=Array.new
  for k in 0..3
    for l in 0..3
      if plane_A.point[k]==plane_B.point[l] then
        wedgePoint.push(plane_A.point[k])

      end
    end


  end
  return wedgePoint
end
  module_function :compare1
end



#p wedgeArray(cubeArray)