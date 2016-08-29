# encoding: utf-8
=begin
项目: SPA
类名/模块名:
文件: SPA_Read.rb
功能:
输入:
输出:
作者:刘洋
日期:16/6/17
时间:上午9:36
备注:
=end
require File.join(File.expand_path(".."), '/Entity/Plane')
require File.join(File.expand_path(".."), '/Entity/NetElement')
require File.join(File.expand_path(".."), '/Entity/Sign')
require File.join(File.expand_path(".."), '/Entity/UserEquipment')
require File.join(File.expand_path(".."), '/Entity/Point')
require File.join(File.expand_path(".."), '/Entity/Cube')
module SPA_Read
  #读取平面
  def plane(filename)
    planeArray = Array.new
    file = File.open(filename)
    planeId = 1
    file.each_line do |line|
      lineArray = line.split() #将每一行字符串以空格作为分隔符进行分离并保存到数组中
      for i in 0..lineArray.size
        lineArray[i] = lineArray[i].to_f
      end
      plane = Plane.new
      plane.id = 100000+planeId #平面编号
      planeId = planeId+1 #编号自增
      plane.equation = lineArray[0, 4] #前四个表示为平面方程
      plane.point = [lineArray[4, 3], lineArray[7, 3], lineArray[10, 3], lineArray[13, 3]] #凸点坐标数组
      plane.material = lineArray[16] #平面材质
      #plane.type = lineArray[17]#平面类型
      planeArray.push(plane)
    end
    file.close
    return planeArray
  end

  module_function :plane
  #读取平面物体
  def planeCube(filename)
    planeArray = Array.new
    cubeArray = Array.new
    planeId = 100000
    cubeId = 10000
    file = File.open(filename)
    file.each_line do |line|
      size = line.to_s.to_i
      cube = Cube.new
      cubeId = cubeId + 1
      cube.id = cubeId
      cube.plane = Array.new
      for i in 0..size-1
        tempLine = file.readline
        lineArray = tempLine.split() #将每一行字符串以空格作为分隔符进行分离并保存到数组中
        for j in 0..lineArray.size
          lineArray[j] = lineArray[j].to_f
        end
        plane = Plane.new
        planeId = planeId+1 #编号自增
        plane.id = planeId #平面编号
        plane.equation = lineArray[0, 4] #前四个表示为平面方程
        plane.type = lineArray[4].to_s.to_i#平面点的数量
        pointArray = Array.new
        for index in 0..plane.type-1
          pointArray.push(lineArray[5+index*3,3])
        end
        plane.material = lineArray[lineArray.size-3].to_s.to_i #平面材质
        plane.area = lineArray[lineArray.size-2].to_s.to_f#平面材质
        plane.point = pointArray #平面的点
        cube.plane[i]=plane
        p lineArray
        p lineArray.length
        p plane
        planeArray.push(plane)
      end
      cubeArray.push(cube)
    end
    return [planeArray,cubeArray]
  end

  module_function :planeCube

  #读取终端
  def ue(filename)
    ueArray = Array.new
    file = File.open(filename)
    file.each_line do |line|
      lineArray = line.split() #将每一行字符串以空格作为分隔符进行分离并保存到数组中
      for i in 0..lineArray.size
        lineArray[i] = lineArray[i].to_f
      end
      ue = NetElement.new
      ue.id = lineArray[0].to_i
      ue.coordinate = lineArray[1, 3]
      ueArray.push(ue)
    end
    file.close
    return ueArray
  end

  module_function :ue

  #读取网元
  def ne(filename)
    neArray = Array.new
    file = File.open(filename)
    file.each_line do |line|
      lineArray = line.split() #将每一行字符串以空格作为分隔符进行分离并保存到数组中
      for i in 0..lineArray.size
        lineArray[i] = lineArray[i].to_f
      end
      ne = NetElement.new
      ne.id = lineArray[0].to_i
      ne.coordinate = lineArray[1, 3]
      ne.signal = lineArray[4]
      ne.type = lineArray[5]
      neArray.push(ne)
    end
    file.close
    return neArray
  end

  module_function :ne

  #读取信号
  def signal(filename)
    signalArray = Array.new
    file = File.open(filename)
    file.each_line do |line|
      lineArray = line.split() #将每一行字符串以空格作为分隔符进行分离并保存到数组中
      for i in 0..lineArray.size
        lineArray[i] = lineArray[i].to_f
      end
      signal = Sign.new
      signal.id = lineArray[0]
      signal.strength= lineArray[1]
      signal.frequency = lineArray[2]
      signal.data= lineArray[3]
      signalArray.push(signal)
    end
    file.close
    return signalArray
  end

  module_function :signal

  #读取源点
  def point(filename)
    pointArray = Array.new
    file = File.open(filename)
    file.each_line do |line|
      lineArray = line.split()
      for i in 0..lineArray.size
        lineArray[i] = lineArray[i].to_i
      end
      point = Point.new(lineArray[1, 3], lineArray[4], lineArray[6], lineArray[7])
      point.id = lineArray[0]
      point.level = lineArray[5]
      pointArray.push(point)
    end
    file.close
    return pointArray
  end

  module_function :point
end
