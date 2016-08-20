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
module Ray_Reflect
  def reflect(ne, ue, cubeArray, signal)
    beginPoint = ne.coordinate
    endPoint = ue.coordinate
    p "Module: Ray_Reflect Method: reflect"
    reflectPathArray = Array.new #反射路径数组
    cubeArray.each do |cube|
      cube.plane.each do |plane|
        mirrorPoint = Space_Base.mirrorPoint(beginPoint, plane.equation) #求源点的镜像点
        reflectPoint = Space_Intersect.intersect(mirrorPoint, endPoint, plane)
        pointResult = Space_Intersect.verifyPoint(mirrorPoint, endPoint, reflectPoint)
        if pointResult == 0 then
          p "Module: Ray_Reflect Method: reflect 未验证反射点 "+reflectPoint.to_s
          if verifyReflectPlane(beginPoint, reflectPoint, cube, plane) == true then
            p "Module: Ray_Reflect reflectPoint: #{reflectPoint}"
            reflectCubeArray = deleteCube(cube.id, cubeArray)
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
            reflectPathArray.push(reflectPath)
            reflectCubeArray.insert(0, cube) #添加回反射物体
          end
        end
      end
      #cubeArray.push(tempCube) #加回当前物体
    end
    return reflectPathArray
  end

  module_function :reflect

  #计算多次反射
  def multiReflect(ne, ue, cubeArray, signal)
    beginPoint = ne.coordinate
    endPoint = ue.coordinate
    cubeArray.each do |cube1|
      cube1.plane.each do |plane1|
        mirrorPoint1 = Space_Base.mirrorPoint(beginPoint, plane1.equation) #求源点的镜像点
        cubeArray.each do |cube2|
          cube2.plane.each do |plane2|
            mirrorPoint2 = Space_Base.mirrorPoint(mirrorPoint1, plane2.equation) #求源点的镜像点
            reflectPoint2 = Space_Intersect.intersect(mirrorPoint2, endPoint, plane2)
            pointResult2 = Space_Intersect.verifyPoint(mirrorPoint1, endPoint, reflectPoint2)
            if pointResult2 == 0 then
              if verifyReflectPlane(endPoint, reflectPoint2, cube2, plane2) == true then

              end
            end
          end
        end
      end
    end
  end


  module_function :multiReflect

  #计算镜像点
  def mirrorPoint(ne, cubeArray)
    beginPoint = ne.coordinate
    mirrorPointArray = Array.new
    cubeArray.each do |cube|
      cube.plane.each do |plane|
        mirrorPoint = Space_Base.mirrorPoint(beginPoint, plane.equation) #求源点的镜像点
        mirrorPointArray.push(mirrorPoint)
      end
    end
  end

  module_function :mirrorPoint

  #判断反射面的有效性
  def verifyReflectPlane(beginPoint, reflectPoint, cube, reflectPlane)
    p "Module: Ray_Reflect Method: verifyReflectPlane 物体平面数量 "+cube.plane.length.to_s
    p "Module: Ray_Reflect Method: verifyReflectPlane"
    cube.plane.each do |plane|
      p "Module: Ray_Reflect Method: verifyReflectPlane "+plane.id.to_s
      if plane == reflectPlane then
        next
      end
      p "Module: Ray_Reflect Method: verifyReflectPlane "+plane.id.to_s
      interPoint = Space_Intersect.intersect(beginPoint, reflectPoint, plane)
      pointResult = Space_Intersect.verifyPoint(beginPoint, reflectPoint, interPoint)
      if pointResult == 0 then
        return false
      end
    end
    return true
  end

  module_function :verifyReflectPlane

  #删除当前的物体
  def deleteCube(id, cubeArray)
    p "Module: Ray_Reflect Method: deleteCube"+cubeArray.length.to_s
    cubeArray.each do |cube|
      if cube.id == id
        cubeArray.delete(cube)
        break
      end
    end
    p "Module: Ray_Reflect Method: deleteCube after "+cubeArray.length.to_s
    return cubeArray
  end

  module_function :deleteCube
end
