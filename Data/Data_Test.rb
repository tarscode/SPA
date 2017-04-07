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

  def grid()
    point1 = [5450, 750, 0]
    point2 = [10350, 6150, 0]
    dx = (point2[0]- point1[0])/10.0
    dy = (point2[1]- point1[1])/10.0
    #z = 4500.0
    z = 1500.0
    pointArray = Array.new
    id =10000
    for i in 0..5
      for j in 0..5
        id =id +1
        point = [id, point1[0]+dx*i, point1[1]+dy*j, z]
        pointArray.push(point)
      end
    end
    return pointArray
  end

  module_function :grid

  def grid100()
    point1 = [5450, 750, 0]
    point2 = [10350, 6150, 0]
    dx = (point2[0]- point1[0])/10.0
    dy = (point2[1]- point1[1])/10.0
    z = 4500.0
    #z = 1500.0
    pointArray = Array.new
    id =10000
    for i in 0..9
      for j in 0..9
        id =id +1
        point = [id, point1[0]+dx*i, point1[1]+dy*j, z]
        pointArray.push(point)
      end
    end
    return pointArray
  end

  module_function :grid100

  def gridzte()
    dx = 100.0
    x = 600.0
    y = 27800.0
    z = 1500.0
    pointArray = Array.new
    id =10000
    for i in 0..105
        id =id +1
        point = [id, x+dx*i, y, z]
        pointArray.push(point)
    end
    return pointArray
  end

  module_function :gridzte
  #一楼二楼整个空间覆盖
  def spaceGrid()
    point1 = [350, 1200, 0]
    point2 = [15000, 6000, 0]
    dx = (point2[0]- point1[0])/30.0
    dy = (point2[1]- point1[1])/10.0
    z1 = 4500.0
    z2 = 1200.0
    pointArray = Array.new
    id =10000
    for i in 0..29
      for j in 0..9
        id =id +1
        point = [id, point1[0]+dx*i, point1[1]+dy*j, z1]
        id =id +1
        point2 = [id, point1[0]+dx*i, point1[1]+dy*j, z2]
        pointArray.push(point)
        pointArray.push(point2)
      end
    end
    return pointArray
  end

  module_function :spaceGrid

  def cubeTest(cubeArray)
    $logger.info("Module:Data_Test cubeSize:"+cubeArray.length.to_s)
    cubeArray.each do |cube|
      $logger.info("Module:Data_Test cube:"+cube.id.to_s)
    end
  end

  module_function :cubeTest

  def cubeCenter(cube)
    size = cube.plane.length
    xx, yy, zz =0, 0, 0
    for i in 0..size-1
      pointArray = cube.plane[i].point
      x, y, z = 0, 0, 0
      pointArray.each do |point|
        x=x+point[0]
        y=y+point[1]
        z=z+point[2]
      end
      xx = xx+x/4.0
      yy =yy+ y/4.0
      zz= zz+z/4.0
    end
    xx = xx*1.0/size
    yy = yy*1.0/size
    zz = zz*1.0/size
    centerPoint = [xx, yy, zz]
    return centerPoint
  end

  module_function :cubeCenter

  def cubeQueryByPoint(searchPoint, cubeArray)
    idArray = Array.new
    cubeArray.each do |cube|
      planeArray = cube.plane
      pointArray = Array.new
      planeArray.each do |plane|
        pointArray = pointArray+plane.point
      end
      pointArray.each do |point|
        x = point[0]-searchPoint[0]
        y = point[1]-searchPoint[1]
        z = point[2]-searchPoint[2]
        if x>-0.1&&x<0.1&&y>-0.1&&y<0.1&&z>-0.1&&z<0.1 then
          idArray.push(cube.id)
          break
        end
      end
    end
    return idArray
  end

  module_function :cubeQueryByPoint

  def cubeQueryByPlane(planeId, cubeArray)
    planeArr = Array.new
    cubeArray.each do |cube|
      planeArray = cube.plane
      planeArray.each do |plane|
        if plane.id == planeId then
          planeArr.push(cube.id)
        end
      end
    end
    return planeArr
  end

  module_function :cubeQueryByPlane

  #计算首径覆盖数目大于等于4的终端覆盖率
  def countFirstPath(firstPathArray)
    number = 0
    firstPathArray.each do |path|
      if path[3] > 3 then
        number=number+1
      end
    end
    return number*1.0/firstPathArray.length
  end

  module_function :countFirstPath

  #计算终端接收到4个不同网元信号的覆盖率
  def countFourPath(signalPath)
    fourPathHash = Hash.new
    signalPath.each do |path|

    end

  end
  module_function :countFourPath

end

