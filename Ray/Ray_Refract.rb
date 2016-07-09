# encoding: utf-8
=begin
项目: SPA
类名/模块名:
文件: Ray_Refract.rb
功能:
输入:
输出:
作者:刘洋
日期:16/6/20
时间:下午5:31
备注:
=end
require File.join(File.expand_path(".."), '/Space/Space_Intersect')
require File.join(File.expand_path(".."), '/Space/Space_Base')
require File.join(File.expand_path(".."), '/Loss/Loss_Direct')
require File.join(File.expand_path(".."), '/Loss/Loss_Refract')
require File.join(File.expand_path(".."), '/Ray/Ray_Direct')
module Ray_Refract
  #折射计算主函数
  def refract(ne, ue, cubeArray, signal)
    beginPoint = ne.coordinate
    endPoint = ue.coordinate
    p "Module: Ray_Refract Method: refract"
    refractPointArray = [beginPoint] #折射点数组
    refractSignalValue = signal.strength #折射信号值
    preRefractPoint = beginPoint #默认前一个反射点为起始点
    sortCubeArray = interSortCube(beginPoint, endPoint, cubeArray)
    if sortCubeArray.length == 0 then
      directPath = Ray_Direct.direct(ne, ue, signal) #直射传播
      return directPath
    end
    #遍历物体
    sortCubeArray.each do |cube|
      planeHash = Hash.new
      pointHash = Hash.new
      #遍历物体的每个平面
      cube.plane.each do |plane|
        interPoint = Space_Intersect.intersect(beginPoint, endPoint, plane)
        pointResult = Space_Intersect.verifyPoint(beginPoint, endPoint, interPoint)
        if pointResult == 0 then
          pointDistance = Space_Base.pointDistance(beginPoint, interPoint)
          p "pointDistance #{pointDistance} #{beginPoint} #{interPoint}"
          planeHash[pointDistance] = plane
          pointHash[pointDistance] = interPoint
        end
      end
      if planeHash.length < 2 #跳过反射点所在物体
        next
      end
      p "planeHash #{planeHash}"
      planeHash = planeHash.sort #折射面排序
      pointHash = pointHash.sort #折射点排序
      planeHashArray = planeHash.to_a
      pointHashArray = pointHash.to_a
      inRefractPoint = pointHashArray[0][1] #入折射点
      outRefractPoint = pointHashArray[1][1] #出折射点
      inRefractPlane = planeHashArray[0][1] #折射入射面
      partDirectDistance = Space_Base.pointDistance(preRefractPoint, inRefractPoint) #前一个物体的出折射点和当前物体的入折射点之间的距离
      refractPointDistance = Space_Base.pointDistance(inRefractPoint, outRefractPoint) #入折射点和出折射点之间的距离
      refractPointArray.push(inRefractPoint) #入折射点加进折射点数组
      refractPointArray.push(outRefractPoint) #出折射点加进折射点数组
      partDirectSignalValue = Loss_Direct.direct(refractSignalValue, partDirectDistance, signal.frequency) #部分直射损耗
      refractAngle = Space_Base.linePlaneAngle(preRefractPoint, inRefractPoint, inRefractPlane.equation) #计算折射入射角
      refractSignalValue = Loss_Refract.refract(partDirectSignalValue, signal.frequency, refractAngle, inRefractPlane, refractPointDistance) #物体内折射损耗
      preRefractPoint = outRefractPoint #将前一个反射点设为当前物体的出折射点
    end
    refractPointArray.push(endPoint)
    endPointDistance = Space_Base.pointDistance(preRefractPoint, endPoint) #最后一段直射距离
    refractSignalValue = Loss_Direct.direct(refractSignalValue, endPointDistance, signal.frequency) #信号强度
    refractDelay = Space_Base.pathDelay(refractPointArray, refractPointArray.length) #折射时延
    refractPath = [refractSignalValue, refractDelay, refractPointArray] #折射路径
    return refractPath
  end


  module_function :refract

  #计算与直线相交的物体,并按照距离排序
  def interSortCube(beginPoint, endPoint, cubeArray)
    p "Module: Ray_Refract Method: interSortCube"
    cubeHash = Hash.new
    sortCubeArray = Array.new
    cubeArray.each do |cube|
      cube.plane.each do |plane|
        interPoint = Space_Intersect.intersect(beginPoint, endPoint, plane)
        pointResult = Space_Intersect.verifyPoint(beginPoint, endPoint, interPoint)
        if pointResult == 0 then
          pointDistance = Space_Base.pointDistance(beginPoint, interPoint)
          if pointDistance.nan? == true then
            p "Module: Ray_Refract Method: interSortCube Nan pointDistance: #{pointDistance}"
            pointDistance = 0 #处理NaN,Bug修复后可删除
          end
          cubeHash[pointDistance] = cube
          break
        end
      end
    end
    cubeHash = cubeHash.sort
    cubeHashArray = cubeHash.to_a
    cubeHashArray.each do |hashArray|
      sortCubeArray.push(hashArray[1])
    end
    return sortCubeArray
  end

  module_function :interSortCube

end