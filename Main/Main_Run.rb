# encoding: utf-8
=begin
项目: SPA
类名/模块名:
文件: Main_Run.rb
功能:
输入:
输出:
作者:刘洋
日期:16/7/26
时间:下午4:12
备注:
=end
require File.join(File.expand_path(".."), '/IO/SPA_Read')
require File.join(File.expand_path(".."), '/IO/SPA_Write')
require File.join(File.expand_path(".."), '/IO/SPA_File')
require File.join(File.expand_path(".."), '/Data/Data_Convert')
require File.join(File.expand_path(".."), '/Ray/Ray_Refract')
require File.join(File.expand_path(".."), '/Ray/Ray_Reflect')
require File.join(File.expand_path(".."), '/Ray/Ray_Difract')
require File.join(File.expand_path(".."), '/Entity/Path')
require File.join(File.expand_path(".."), '/Data/Data_Review')
require File.join(File.expand_path(".."), '/Data/Data_Test')
require File.join(File.expand_path(".."), '/Data/Data_Init')
require File.join(File.expand_path(".."), '/Entity/Point')
require 'benchmark'
require 'logger'

def mainRun
  #创建日志文件,OSX环境
  SPA_Write.createFile(2)
  #生成终端数据
  #ueData = Data_Test.ue(1)
  #SPA_Write.ueWrite(ueData)
  #创建日志文件
  loggerFile = File.new(File.expand_path("..")+"//Log//logger.txt", "w+")
  $logger = Logger.new(loggerFile)
  #数据文件名
  planeFile = File.expand_path("..")+"/Doc/Space_Curve.txt";
  neFile = File.expand_path("..")+"/Doc/NetElement.txt";
  pointFile = File.expand_path("..")+"/Doc/PointTree.txt";
  ueFile = File.expand_path("..")+"/Doc/UserEquipment.txt";
  singalFile = File.expand_path("..")+"/Doc/Signal.txt";
  #获取数据
  planeCubeArray = SPA_Read.planeCube(planeFile) #平面数组
  planeArray = planeCubeArray[0]
  cubeArray = planeCubeArray[1]
  neArray = SPA_Read.ne(neFile) #网元数组
  ueArray = SPA_Read.ue(ueFile) #终端数组
  signalArray = SPA_Read.signal(singalFile) #信号数组
  #初始化
  Data_Init.planeInit(planeArray)
  Data_Init.cubeInit(cubeArray)
  Data_Init.signalInit(signalArray)
  #数据测试

  #写入源点
  pointArray = Data_Init.initPointTree(neArray,cubeArray)
  SPA_Write.treeWrite(pointArray)
  #读取源点
  pointArray = SPA_Read.point(pointFile)
  Data_Init.pointInit(pointArray)
  p $pointHash[101]
  pointArray = Data_Convert.levelThreePointArray(pointArray)
  spacePathArray = Ray_Reflect.multiReflect(ueArray[0],nil,nil,pointArray)
  #写入信号路径
  SPA_Write.spacePathWrite(spacePathArray)
end

p Benchmark.realtime {
  mainRun
  p "运行时间:"
}