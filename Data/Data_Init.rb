# encoding: utf-8
=begin
项目: SPA
类名/模块名:
文件: Data_Init.rb
功能:
输入:
输出:
作者:刘洋
日期:16/8/20
时间:下午8:01
备注:
=end
require File.join(File.expand_path(".."), '/Space/Space_Base')
require File.join(File.expand_path(".."), '/Entity/Cube')
require File.join(File.expand_path(".."), '/Entity/Point')
module Data_Init
  #空间平面散列表全局变量
  $planeHash = Hash.new

  #空间物体散列表全局变量
  $cubeHash = Hash.new

  #虚拟源点散列表全局变量
  $pointHash = Hash.new

  #终端散列全局变量
  $ueHash = Hash.new

  #信号全局变量
  $signalHash = Hash.new

  #生成平面散列表
  def planeInit(planeArray)
    planeArray.each do |plane|
      $planeHash[plane.id]=plane
    end
  end

  module_function :planeInit

  #生成物体散列表
  def cubeInit(cubeArray)
    cubeArray.each do |cube|
      $cubeHash[cube.id]=cube
    end
  end

  module_function :cubeInit

  #生成虚拟源点散列表
  def pointInit(pointArray)
    pointArray.each do |point|
      $pointHash[point.id]=point
    end
  end

  module_function :pointInit

  #生成终端散列表
  def ueInit(ueArray)
    ueArray.each do |ue|
      $ueHash[ue.id]=ue.coordinate
    end
  end

  module_function :ueInit

  #生成信号散列表
  def signalInit(signalArray)
    signalArray.each do |signal|
      $signalHash[signal.id] = signal
    end
  end

  module_function :signalInit

  #初始化建立虚拟源树旧版本
  def initPointTreeBefore(neArray, cubeArray)
    levelOneId = 100;
    levelTwoId = 100000;
    levelThreeId = 100000;
    pointArray = Array.new
    neArray.each do |ne|
      levelOnePoint = Point.new(ne.coordinate, -1, -1, -1)
      levelOneId = levelOneId + 1
      levelOnePoint.id = levelOneId
      levelOnePoint.level = 1
      pointLevelTwoArray = Space_Base.mirrorPointArray(levelOnePoint, cubeArray) #获取源点镜像点,即二级源点
      pointLevelTwoIdArray = Array.new
      #遍历二级源
      pointLevelTwoArray.each do |levelTwoPoint|
        levelTwoId= levelTwoId+1
        levelTwoPoint.id = (levelOneId.to_s+levelTwoId.to_s).to_i
        levelTwoPoint.level = 2
        pointLevelThreeArray = Space_Base.mirrorPointArray(levelTwoPoint, cubeArray) #获取三级源点
        pointLevelThreeIdArray = Array.new
        pointLevelThreeArray.each do |levelThreePoint|
          $logger.info("Module:Data_Init Method:initPointTree Point:#{levelThreePoint}")
          levelThreeId=levelThreeId+1
          levelThreePoint.id = (levelOneId.to_s+levelTwoId.to_s+levelThreeId.to_s).to_i
          levelThreePoint.level = 3
          pointLevelThreeIdArray.push(levelThreePoint.id)
          levelThreePoint.child = nil
          pointArray.push(levelThreePoint)
        end
        levelTwoPoint.child = pointLevelThreeIdArray
        pointLevelTwoIdArray.push(levelTwoPoint.id)
        pointArray.push(levelTwoPoint)
      end
      levelOnePoint.child = pointLevelTwoIdArray
      pointArray.push(levelOnePoint)
    end
    return pointArray
  end

  module_function :initPointTreeBefore

  #初始化建立虚拟源树
  def initPointTree(neArray, cubeArray)
    levelTwoId = 100000;
    levelThreeId = 100000;
    pointArray = Array.new
    neArray.each do |ne|
      levelOnePoint = Point.new(ne.coordinate, -1, -1, -1)
      levelOnePoint.id = ne.id
      levelOnePoint.level = 1
      pointLevelTwoArray = Space_Base.mirrorPointArray(levelOnePoint, cubeArray) #获取源点镜像点,即二级源点
      pointLevelTwoIdArray = Array.new
      #遍历二级源
      pointLevelTwoArray.each do |levelTwoPoint|
        levelTwoId= levelTwoId+1
        levelTwoPoint.id = (levelOnePoint.id.to_s+levelTwoId.to_s).to_i
        levelTwoPoint.level = 2
        pointLevelThreeArray = Space_Base.mirrorPointArray(levelTwoPoint, cubeArray) #获取三级源点
        pointLevelThreeIdArray = Array.new
        pointLevelThreeArray.each do |levelThreePoint|
          p "initPointTree#{levelThreePoint}"
          $logger.info("Module:Data_Init Method:initPointTree Point:#{levelThreePoint}")
          levelThreeId=levelThreeId+1
          levelThreePoint.id = (levelOnePoint.id.to_s+levelTwoId.to_s+levelThreeId.to_s).to_i
          levelThreePoint.level = 3
          pointLevelThreeIdArray.push(levelThreePoint.id)
          levelThreePoint.child = nil
          pointArray.push(levelThreePoint)
        end
        levelTwoPoint.child = pointLevelThreeIdArray
        pointLevelTwoIdArray.push(levelTwoPoint.id)
        pointArray.push(levelTwoPoint)
      end
      levelOnePoint.child = pointLevelTwoIdArray
      pointArray.push(levelOnePoint)
    end
    return pointArray
  end

  module_function :initPointTree

end
