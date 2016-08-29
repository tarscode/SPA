# encoding: utf-8
=begin
项目: SPA
类名/模块名:
文件: Ray_Reflect.rb
功能:
输入:
输出:
作者:刘洋
日期:16/6/22
时间:下午2:13
备注:
=end
require File.join(File.expand_path(".."), '/Entity/Path')
require File.join(File.expand_path(".."), '/Entity/Sign')
require File.join(File.expand_path(".."), '/Entity/Cube')
require File.join(File.expand_path(".."), '/Loss/Loss_Reflect')
require File.join(File.expand_path(".."), '/Entity/NetElement')
require File.join(File.expand_path(".."), '/Entity/UserEquipment')
require File.join(File.expand_path(".."), '/Data/Data_Init')
module Ray_Reflect
  def reflect(ne, ue, cubeArray, signal)
    beginPoint = ne.coordinate
    endPoint = ue.coordinate
    reflectPathArray = Array.new #反射路径数组
    cubeArray.each do |cube|
      #$logger.info("Module: Ray_Reflect cube:"+cube.id.to_s)
      cube.plane.each do |plane|
        #$logger.info("Module: Ray_Reflect plane:"+plane.id.to_s+"cube:"+cube.id.to_s)
        mirrorPoint = Space_Base.mirrorPoint(beginPoint, plane.equation) #求源点的镜像点
        reflectPoint = Space_Intersect.intersect(mirrorPoint, endPoint, plane)
        pointResult = Space_Intersect.verifyPoint(mirrorPoint, endPoint, reflectPoint)
        #$logger.info("Module: Ray_Reflect"+" planeId "+plane.id.to_s+" mirrorPoint: "+mirrorPoint.to_s+" reflectPoint: "+reflectPoint.to_s+" pointResult: "+pointResult.to_s)
        if pointResult == 0 then
          #$logger.info("Module: Ray_Reflect plane1:"+plane.to_s)
          if verifyReflectPlane(beginPoint, reflectPoint, cube, plane) == true then
            #$logger.info("Module: Ray_Reflect plane2:"+plane.to_s)
            tempCubeArray = cubeArray.clone
            reflectCubeArray = deleteCube(cube.id, tempCubeArray)
            reflectUe = UserEquipment.new
            reflectUe.coordinate = reflectPoint
            preRefractPath = Ray_Refract.refract(ne, reflectUe, reflectCubeArray, signal)
            preRefractSignal = preRefractPath[0]
            inReflectAngle = Space_Base.linePlaneAngle(beginPoint, reflectPoint, plane.equation)
            reflectSignalValue = Loss_Reflect.reflect(preRefractSignal, signal.frequency, inReflectAngle, plane)
            reflectSignal = Sign.new
            reflectSignal.id = signal.id
            reflectSignal.strength = reflectSignalValue
            reflectSignal.frequency = signal.frequency
            reflectNe = NetElement.new
            reflectNe.coordinate = reflectPoint
            nextRefractPath = Ray_Refract.refract(reflectNe, ue, reflectCubeArray, reflectSignal) #变换起始点网元
            reflectDelay = preRefractPath[1]+nextRefractPath[1]
            reflectSignalValue = nextRefractPath[0]
            reflectPointArray = preRefractPath[2]+nextRefractPath[2].drop(1)
            reflectPath = [reflectSignalValue, reflectDelay, reflectPointArray]
            $logger.info("reflectPath:"+reflectPath.to_s)
            reflectPathArray.push(reflectPath)
          end
        end
      end
    end
    return reflectPathArray
  end

  module_function :reflect

  #计算多次反射
  def multiReflect(ue, cubeArray,  pointArray)
    endPoint = ue.coordinate
    multiReflectPathArray = Array.new
    pointArray.each do |levelThreePoint|
      p "Moudle:SPA_Reflect Method:multiReflect #{levelThreePoint.id}"
      reflectTwoPlane = $planeHash[levelThreePoint.planeId]
      reflectPointTwo = Space_Intersect.intersect(levelThreePoint.coordinate,endPoint,reflectTwoPlane) #求二次反射点
      pointTwoResult = Space_Intersect.verifyPoint(levelThreePoint.coordinate,endPoint,reflectPointTwo)
      if pointTwoResult == 0 then
        levelTwoPoint = $pointHash[levelThreePoint.fatherId]
        reflectOnePlane = $planeHash[levelTwoPoint.planeId]
        reflectPointOne = Space_Intersect.intersect(levelTwoPoint.coordinate,reflectPointTwo,reflectOnePlane)
        pointOneResult = Space_Intersect.verifyPoint(levelTwoPoint.coordinate,reflectPointTwo,reflectPointOne)
        if pointOneResult == 0 then
          #第一段折射路径处理
          beginPoint = $pointHash[levelTwoPoint.fatherId]#获取起始点
          signal = $signalHash[beginPoint.id] #信号对象
          preCubeArray = cubeArray.clone
          preCubeArray = deleteCube(levelTwoPoint.cubeId,preCubeArray)
          preNe = NetElement.new
          preNe.coordinate = beginPoint.coordinate
          preUe = UserEquipment.new
          preUe.coordinate = reflectPointOne
          preRefractPath = Ray_Refract.refract(beginPoint,preUe,preCubeArray,signal) #第一段折射路径
          #第二段折射路径处理
          #第三段折射路径处理
          #二次反射总路径
          multiReflectPath = [beginPoint.coordinate,reflectPointOne,reflectPointTwo,endPoint]
          multiReflectPathArray.push(multiReflectPath)
        end
      end
    end
    return multiReflectPathArray
  end

  module_function :multiReflect
  #判断反射面的有效性
  def verifyReflectPlane(beginPoint, reflectPoint, cube, reflectPlane)
    cube.plane.each do |plane|
      if plane.id == reflectPlane.id then
        next
      end
      intersectPoint = Space_Intersect.intersect(beginPoint, reflectPoint, plane)
      pointResult = Space_Intersect.verifyPoint(beginPoint, reflectPoint, intersectPoint)
      if pointResult == 0 then
        return false
      end
    end
    return true
  end

  module_function :verifyReflectPlane

  #删除当前的物体
  def deleteCube(id, cubeArray)
    cubeArray.each do |cube|
      if cube.id == id
        cubeArray.delete(cube)
        break
      end
    end
    return cubeArray
  end

  module_function :deleteCube
end
