# encoding: utf-8
=begin
项目: SPA
类名/模块名:
文件: Ray_Difract.rb
功能:
输入:
输出:
作者:宋世伟
日期:16/6/24
时间:下午11:13
备注:
=end
include Math
require File.join(File.expand_path(".."), '/Entity/Path')
require File.join(File.expand_path(".."), '/Entity/Sign')
require File.join(File.expand_path(".."), '/Loss/Loss_Reflect')
require File.join(File.expand_path(".."), '/Loss/Loss_Refract')
require File.join(File.expand_path(".."), '/Ray/Ray_Refract')
require File.join(File.expand_path(".."), '/Loss/Loss_Diffract')
require File.join(File.expand_path(".."), '/Data/Data_VisibleWedge')
require File.join(File.expand_path(".."), '/Space/Space_Base')
require File.join(File.expand_path(".."), '/Space/SPA_DifPoint')
module Ray_Difract
  def difract(ne, ue, cubeArray, signal)
    beginPoint=ne.coordinate
    endPoint=ue.coordinate
    p "Module: Ray_Difract sod: difract"
    difPathArray = Array.new #绕射路径数组
    difCubeArray = Ray_Refract.interSortCube(beginPoint, endPoint, cubeArray)
    if difCubeArray.length ==0 then
      return nil; #无绕射路径
    end
    p "difCubeArray #{difCubeArray.length}"
    if difCubeArray.length !=0 then
      difCubeArray.each do |cube|
        wedgeArray=Data_VisibleWedge.wedgeArray(cube)
        wedgeArray.each do |wedge|
          p wedge[0]
          diFrPoint1= Space_DifPoint.diffractionPoint(beginPoint, endPoint, wedge[0]) #求绕射点坐标

          diFrPoint=Space_Intersect.intersectDif(beginPoint, endPoint, wedge[0], diFrPoint1)

          pointResult1 = Space_Intersect.verifyPoint(beginPoint, endPoint, diFrPoint)
          pointResult2 = Space_Intersect.difRactPoint(diFrPoint, endPoint, diFrPoint, cube)
          if pointResult1 == 0 && pointResult2==0 then
            difCubeArray = deleteCube(cube.id, cubeArray)
            diFractUe=UserEquipment.new
            diFractUe.coordinate=diFrPoint
            preDifPath = Ray_Refract.refract(ne, diFractUe, difCubeArray, signal)
            preDifSignal = preDifPath[0]

            s1=Space_Base.pointDistance(beginPoint, diFrPoint)/1000*1.0

            s2=Space_Base.pointDistance(endPoint, diFrPoint)/1000*1.0

            v=PI/2
            angle1=Space_Base.linePlaneAngle(beginPoint, diFrPoint, wedge[1].equation)

            angle2=Space_Base.linePlaneAngle(beginPoint, diFrPoint, wedge[2].equation)

            angle3=Space_Base.lineLineAngle(beginPoint, diFrPoint, wedge[0][0], wedge[0][1])

            rn=Loss_Reflect.reflectCoe(signal.strength, signal.frequency, angle1, wedge[1])

            r0=Loss_Reflect.reflectCoe(signal.strength, signal.frequency, angle1, wedge[2])

            difSignalValue=Loss_DifLoss.diffractionEe(s1, s2, v, angle1, angle2, angle3, signal.frequency, preDifSignal, signal.strength, rn, r0)

            difSignal = Sign.new
            difSignal.id = signal.id
            difSignal.strength = difSignalValue

            difSignal.frequency = signal.frequency
            diFractNe=NetElement.new
            diFractNe.coordinate=diFrPoint
            nextDifPath = Ray_Refract.refract(diFractNe, ue, difCubeArray, difSignal)

            difDelay = preDifPath[1]+nextDifPath[1]
            reDifSignalValue = nextDifPath[0]
            reDifPointArray = preDifPath[2]+nextDifPath[2].drop(1)
            reDifPath = [reDifSignalValue, difDelay, reDifPointArray]
            difPathArray.push(reDifPath)
            difCubeArray.insert(0, cube)
          end
        end
      end
    end

    return difPathArray
  end

  module_function :difract
  #删除当前的物体
  def deleteCube(id, cubeArray)
    p "Module: Ray_Reflect Method: deleteCube"
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
