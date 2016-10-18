# encoding: utf-8
=begin
项目: SPA
类名/模块名:
文件: Data_Convert.rb
功能:数据处理模块
输入:
输出:
作者:刘洋
日期:16/6/18
时间:下午6:59
备注:
=end
require File.join($SPA_Path, '/Entity/Cube')
require File.join($SPA_Path, '/Entity/Path')
require 'complex'
require 'cmath'
module Data_Convert
  #平面数组转换成物体数组
  def planeToCube(planeArray)
    cubeArray = Array.new
    planeNumber = planeArray.length
    cubeNumber = planeNumber/6
    for i in 0..cubeNumber-1
      cube = Cube.new
      cube.id = 10001+i
      cube.plane = [planeArray[i*6], planeArray[i*6+1], planeArray[i*6+2], planeArray[i*6+3], planeArray[i*6+4], planeArray[i*6+5]]
      cubeArray.push(cube)
    end
    return cubeArray
  end

  module_function :planeToCube
  #转换路径数组,增加网元等信息
  def convertPath(ne, ue, prePathArray)
    pathArray = Array.new
    prePathArray.each do |prePath|
      path = Path.new
      path.neId = ne.id
      path.ueId = ue.id
      path.loss = prePath[0]
      path.delay = prePath[1]
      path.pointArray = prePath[2]
      pathArray.push(path)
    end
    return pathArray
  end

  module_function :convertPath

  #转换成信号路径
  def pathToSignalPath(pathArray)
    signalPathArray = Array.new
    pathArray.each do |path|
      firstPathFlag = 0 #首径标识
      if path.pointArray.length==4 || path.pointArray.length==2 then
        firstPathFlag = 1
      end
      signalPath = [path.neId, path.ueId, path.loss, path.delay, firstPathFlag]
      signalPathArray.push(signalPath)
    end
    return signalPathArray
  end

  module_function :pathToSignalPath

  #转换成空间路径
  def pathToSpacePath(pathArray)
    spacePathArray = Array.new
    pathArray.each do |path|
      spacePath = path.pointArray
      spacePathArray.push(spacePath)
    end
    return spacePathArray
  end

  module_function :pathToSpacePath

  #删除空元素
  def deleteNilPath(pathArray)
    if pathArray == nil then
      return pathArray
    end
    pathArray.each do |path|
      if path == nil then
        pathArray.delete(path)
      end
    end
    return pathArray
  end

  module_function :deleteNilPath

  #删除不满足信号强度的路径
  def effectPath(pathArray)
    pathArray.delete_if { |path| (path.loss).real.nan? == true || path.loss.nan? == true || path.loss<-200 }
    return pathArray
  end

  module_function :effectPath

  #保留级数为3的源点
  def levelThreePointArray(pointArray)
    tmpPointArray = Array.new
    pointArray.each do |point|
      if point.level == 3 then
        tmpPointArray.push(point)
      end
    end
    return tmpPointArray
  end

  module_function :levelThreePointArray

  #首径计算
  def firstPath(pathArray)
    firstPathPointHash= Hash.new
    #初始化首径数目为0
    $ueHash.each { |key, value|
      firstPathPointHash[key] = 0
    }
    pathArray.each do |path|
      if !firstPathPointHash.has_key? path.ueId then
        firstPathPointHash[path.ueId] = 0
      end
      if path.pointArray.size == 2 || path.pointArray.size == 4 then
        firstPathPointHash[path.ueId] = firstPathPointHash[path.ueId]+1
      end
    end
    return firstPathPointHash
  end

  module_function :firstPath

  #多径计算
  def multiPath(pathArray)
    multiPathPointHash = Hash.new
    #初始化多径数目为0
    $ueHash.each { |key, value|
      multiPathPointHash[key] = 0
    }
    pathArray.each do |path|
      if multiPathPointHash[path.ueId] == nil then
        multiPathPointHash[path.ueId] = 0
      else
        multiPathPointHash[path.ueId] = multiPathPointHash[path.ueId]+1
      end
    end
    return multiPathPointHash
  end

  module_function :multiPath

  #hash转换成数组
  def hash2Array(pathHash)
    hashPathArray = Array.new
    pathHash.each { |key, value|
      hashPath = $ueHash[key]+ [value]
      hashPathArray.push(hashPath)
    }
    return hashPathArray
  end

  module_function :hash2Array

  #删除路径中的首径
  def deleteFirstPath(pathArray)
    pathArray.delete_if { |path| path.pointArray.size>4 }
    return pathArray
  end

  module_function :deleteFirstPath
end

