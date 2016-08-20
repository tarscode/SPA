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
require File.join(File.expand_path(".."), '/Ray/Ray_Init')
require File.join(File.expand_path(".."), '/Entity/Point')
require 'benchmark'
require 'logger'

def rayTracing
  #创建日志文件
  loggerFile = File.new(File.expand_path("..")+"//Log//logger.txt", "w+")
  $logger = Logger.new(loggerFile)
  #数据文件名
  planeFile = File.expand_path("..")+"/Doc/Space_Small.txt";
  neFile = File.expand_path("..")+"/Doc/NetElement.txt";
  #获取数据
  planeArray = SPA_Read.plane(planeFile) #平面数组
  neArray = SPA_Read.ne(neFile) #网元数组
  #平面数据转换成物体数据
  cubeArray = Data_Convert.planeToCube(planeArray)

  ne = neArray[0]
  p Ray_Init.initPointTree(ne,cubeArray)
end

p Benchmark.realtime {
  rayTracing
  p "运行时间:"
}