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
require File.join(File.expand_path(".."), '/Entity/Cube')
require File.join(File.expand_path(".."), '/IO/SPA_Write')
require File.join(File.expand_path(".."), '/Entity/Path')
module Data_Convert
  #平面数组转换成物体数组
  def planeToCube(planeArray)
    p "模块:Data_Conver 方法:planeToCube"
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
    p prePathArray[0] == nil
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
      signalPath = [path.neId, path.ueId, path.loss, path.delay]
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
    pathArray.each do |path|
     if path == nil then
       pathArray.delete(path)
     end
    end
    return pathArray
  end

  module_function :deleteNilPath

  #删除不满足信号强度的路径
  def deleteWeakSignalPath(pathArray)
    pathArray.each do |path|
      if path[0] < -200
        pathArray = pathArray.delete(path)
      end
    end
    return pathArray
  end
  module_function :deleteWeakSignalPath

end
