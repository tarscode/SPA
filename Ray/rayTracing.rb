# encoding:utf-8
=begin
函数名：reflect
输入：源点坐标、场点坐标、平面类对象数组
输出：反射点坐标数组
功能：计算一次反射的反射点
作者：刘洋
日期：2016.3.20
备注：无
=end
require File.join(File.expand_path(".."), '/IO/SPA_Read')
require File.join(File.expand_path(".."), '/IO/SPA_Write')
require File.join(File.expand_path(".."), '/Data/Data_Convert')
require File.join(File.expand_path(".."), '/Ray/Ray_Refract')
require File.join(File.expand_path(".."), '/Ray/Ray_Reflect')
require File.join(File.expand_path(".."), '/Entity/Path')
require File.join(File.expand_path(".."), '/Data/Data_Review')
require File.join(File.expand_path(".."), '/Data/Data_Test')
require 'benchmark'

def rayTracing
  p "rayTracing"
  #生成终端数据
  #ueData = Data_Test.ue(10)
  #SPA_Write.ueWrite(ueData)
  #创建日志文件,OSX环境
  SPA_Write.createFile(2)
  #数据文件名
  planeFile = File.expand_path("..")+"/Doc/Space_Small.txt";
  neFile = File.expand_path("..")+"/Doc/NetElement.txt";
  ueFile = File.expand_path("..")+"/Doc/UserEquipment.txt";
  singalFile = File.expand_path("..")+"/Doc/Signal.txt";
  #获取数据
  planeArray = SPA_Read.plane(planeFile) #平面数组
  neArray = SPA_Read.ne(neFile) #网元数组
  ueArray = SPA_Read.ue(ueFile) #终端数组
  signalArray = SPA_Read.signal(singalFile) #信号数组
  #平面数据转换成物体数据
  cubeArray = Data_Convert.planeToCube(planeArray)
  #创建路径数组
  pathArray = Array.new
  #网元-终端距离文件写入
  SPA_Write.ueDistance(neArray, ueArray)
  #总径计算
  ueArray.each do |ue|
    neArray.each do |ne|
      #获取信号
      signal = Data_List.signalById(ne.id, signalArray)
      #折射计算
      refractPath = Ray_Refract.refract(ne, ue, cubeArray, signal)
      #反射计算
      #reflectPathArray = Array.new
      reflectPathArray = Ray_Reflect.reflect(ne, ue, cubeArray, signal)
      reflectPathArray.push(refractPath)
      #转换后删除空的数组
      reflectPathArray = Data_Convert.deleteNilPath(reflectPathArray)

      #不为空的路径加入路径数组
      if reflectPathArray.length !=0 then
        pathArray = pathArray + Data_Convert.convertPath(ne, ue, reflectPathArray)
      end
    end
  end
  #删除低于信号阀值的路径
  effectPathArray = Data_Convert.effectPath(pathArray)

  signalPathArray = Data_Convert.pathToSignalPath(effectPathArray)

  spacePathArray = Data_Convert.pathToSpacePath(effectPathArray)
  #空间径合法性验证
  #spacePathArrayResult = Data_Test.spacePath(spacePathArray)
  #p "空间径合法性验证: #{spacePathArrayResult}"
  #写入信号路径
  SPA_Write.spacePathWrite(spacePathArray)
  #写入空间路径
  SPA_Write.signalPathWrite(signalPathArray)
  return pathArray
end

p Benchmark.realtime {
  rayTracing
  p "运行时间:"
}
