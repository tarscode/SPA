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
#require File.join(File.expand_path(".."), '/IO/SPA_Read')
#配置全局项目路径
$SPA_Path = '/Users/liuyang/Documents/Github/SPA'
require File.join($SPA_Path, '/IO/SPA_Read')
require File.join($SPA_Path, '/IO/SPA_Write')
require File.join($SPA_Path, '/IO/SPA_File')
#require File.join($SPA_Path, '/IO/IO_Server')
require File.join($SPA_Path, '/Data/Data_Convert')
require File.join($SPA_Path, '/Ray/Ray_Refract')
require File.join($SPA_Path, '/Ray/Ray_Reflect')
require File.join($SPA_Path, '/Ray/Ray_Difract')
require File.join($SPA_Path, '/Entity/Path')
require File.join($SPA_Path, '/Data/Data_Review')
require File.join($SPA_Path, '/Data/Data_Test')
require File.join($SPA_Path, '/Data/Data_Cell')
require 'benchmark'
require 'logger'

def rayTracing
  #创建日志文件
  loggerFile = File.new($SPA_Path+'//Log//logger.txt', "w+")
  $logger = Logger.new(loggerFile)
  $logger.level = Logger::INFO
  #检测输入文件
  SPA_File.inputFile
  p "rayTracing"
  #生成3GPP终端数据
  #ueData = Data_Cell.ue(60)
  #SPA_Write.ueWrite(ueData)
  #生成终端数据
  #ueData = Data_Test.ue(20)
  #SPA_Write.ueWrite(ueData)
  #创建网格
  #gridData = Data_Test.grid()
  #SPA_Write.ueWrite(gridData)
  #生成100组数据
  #gridData = Data_Test.grid100()
  #SPA_Write.ueWrite(gridData)
  #中兴数据对比
  #gridData = Data_Test.gridzte()
  #SPA_Write.ueWrite(gridData)

  #spaceGridData = Data_Test.spaceGrid()
  #SPA_Write.ueWrite(spaceGridData)
  #创建日志文件,OSX环境
  SPA_Write.createFile(2)
  #数据文件名
  planeFile = $SPA_Path+"/Doc/Space_Curve.txt";
  neFile = $SPA_Path+"/Doc/NetElement.txt";
  ueFile = $SPA_Path+"/Doc/UserEquipment.txt";
  signalFile = $SPA_Path+"/Doc/Signal.txt";
  pointFile = $SPA_Path+"/Doc/PointTree.txt";
  #获取数据
  planeCubeArray = SPA_Read.planeCube(planeFile) #平面数组
  planeArray = planeCubeArray[0]
  cubeArray = planeCubeArray[1]
  neArray = SPA_Read.ne(neFile) #网元数组
  ueArray = SPA_Read.ue(ueFile) #终端数组
  signalArray = SPA_Read.signal(signalFile) #信号数组
  #创建路径数组
  pathArray = Array.new
  multiReflectPathArray = Array.new
  #网元-终端距离文件写入
  SPA_Write.ueDistance(neArray, ueArray)
  reflectPathArray = Array.new
  #初始化
  Data_Init.planeInit(planeArray)
  Data_Init.cubeInit(cubeArray)
  Data_Init.ueInit(ueArray)
  Data_Init.signalInit(signalArray)
  #数据输出
  SPA_Write.cubeWrite(cubeArray) #物体及平面数据文件
  #数据测试
  #Data_Test.cubeTest(cubeArray)
  #cubeId = Data_Test.cubeQueryByPlane(10001,cubeArray)[0]
  #cubeId = Data_Test.cubeQueryByPoint([10400, 6200, 6200], cubeArray)[0]
  #写入源点
  #pointArray = Data_Init.initPointTree(neArray,cubeArray)
  #SPA_Write.treeWrite(pointArray)
  #读取源点
  pointArray = SPA_Read.point(pointFile)
  levelPointThreeArray = Data_Convert.levelThreePointArray(pointArray)
  Data_Init.pointInit(pointArray)
  #总径计算
  ueArray.each do |ue|
    neArray.each do |ne|
      #获取信号
      signal = Data_List.signalById(ne.id, signalArray)
      #折射计算
      refractPath = Ray_Refract.refract(ne, ue, cubeArray, signal)
      #绕射计算
      difractPath = Ray_Difract.difract(ne, ue, cubeArray, signal)
      #反射计算
      reflectPathArray = Ray_Reflect.reflect(ne, ue, cubeArray, signal)
      p reflectPathArray
      reflectPathArray.push(refractPath)
      if difractPath != nil && difractPath.length !=0 then
      #p "difractPath#{difractPath}"
        reflectPathArray=reflectPathArray+difractPath
      end
      #转换后删除空的数组
      reflectPathArray = Data_C


      onvert.deleteNilPath(reflectPathArray)

      #不为空的路径加入路径数组
      if reflectPathArray != nil && reflectPathArray.length !=0 then
        pathArray = pathArray + Data_Convert.convertPath(ne, ue, reflectPathArray)
      end
    end
  end

  #计算多次反射
  ueArray.each do |ue|
    multiReflectPathArray = Ray_Reflect.multiReflect(ue, cubeArray, levelPointThreeArray)
    pathArray = pathArray + multiReflectPathArray
  end

  #删除低于信号阀值的路径
  #effectPathArray = Data_Convert.effectPath(pathArray)
  #包含不满足信号强度的全部路径
  effectPathArray = pathArray

  signalPathArray = Data_Convert.pathToSignalPath(effectPathArray)
  spacePathArray = Data_Convert.pathToSpacePath(effectPathArray)
  #计算首径
  firstPathHash = Data_Convert.firstPath(effectPathArray)
  firstPathArray = Data_Convert.hash2Array(firstPathHash)
  #计算首径覆盖率
  p Data_Test.countFirstPath(firstPathArray)
  SPA_Write.firstPathWrite(firstPathArray)
  #计算多径
  multiPathHash = Data_Convert.multiPath(effectPathArray)
  multiPathArray = Data_Convert.hash2Array(multiPathHash)
  SPA_Write.multiPathWrite(multiPathArray)
  #写入信号路径
  SPA_Write.spacePathWrite(spacePathArray)
  #写入空间路径
  SPA_Write.signalPathWrite(signalPathArray)
  p "SPA end"
end

p Benchmark.realtime {
  rayTracing
  p "运行时间:"
}
