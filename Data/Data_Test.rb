# encoding: utf-8
=begin
项目: SPA
类名/模块名:
文件: Data_Test.rb
功能:
输入:
输出:
作者:刘洋
日期:16/6/29
时间:下午3:21
备注:
=end
module Data_Test
  def ue(num)
    ueArray = Array.new
    for i in 1..num
      prng = Random.new(i)
      id = 10000+i
      #小场景
      x = prng.rand(0.0...17800.0)
      y = prng.rand(0.0...6400.0)
      z = prng.rand(0.0...6300.0)
      #大场景
      #x = prng.rand(0.0...41800.0)
      #y = prng.rand(0.0...12400.0)
      #z = prng.rand(0.0...7300.0)
      ue =[id, x, y, z]
      ueArray.push(ue)
    end
    return ueArray
  end

  module_function :ue
  #目前不好使
  def spacePath(spacePathArray)
    spacePathArray.each do |path|
      n = path.length
      beginPoint = path[0]
      endPoint = path[n - 1]
      x1, y1, z1=beginPoint
      x2, y2, z2=endPoint
      a, b, c = x1-x2, y1-y2, z1-z2
      for i in 0..n-2
        a2, b2, c2 = path[i][0]-path[i-1][0], path[i][1]-path[i-1][1], path[i][2]-path[i-1][2]
        if (a*a2<0||b*b2<0||c*c2<0)
          p "空间径非法顺序 #{i} #{path[i]} #{path[i-1]}"
          return false
        end
      end
    end
    return true
  end

  module_function :spacePath
end

