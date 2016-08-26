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

  def grid()
    point1 = [200, 1700, 0]
    point2 = [5200, 6200, 0]
    dx = (point2[0]- point1[0])/10.0
    dy = (point2[1]- point1[1])/10.0
    z = 200.0
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

  module_function :grid

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
end

