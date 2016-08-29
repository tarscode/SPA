# encoding: utf-8
=begin
项目: SPA
类名/模块名:
文件: SPA_Write.rb
功能:写文件模块
输入:
输出:
作者:刘洋
日期:16/6/17
时间:下午9:51
备注:
=end
module SPA_Write
  #创建日志文件
  def createFile(mode)
    time = Time.new
    if mode == 1
      #Windows环境路径
      @@logFile = File.new(File.expand_path("..")+'\\Log\\log'+time.year.to_s+time.month.to_s+time.day.to_s+".txt", "w+")
      @@pathFile = File.new(File.expand_path("..")+'\\Log\\path'+time.year.to_s+time.month.to_s+time.day.to_s+".txt", "w+")
      @@spacePathFile = File.new(File.expand_path("..")+'\\Log\\spacePath'+time.year.to_s+time.month.to_s+time.day.to_s+".txt", "w+")
      @@signalPathFile = File.new(File.expand_path("..")+'\\Log\\signalPath'+time.year.to_s+time.month.to_s+time.day.to_s+".txt", "w+")
    else
      #OS X环境路径
      @@logFile = File.new(File.expand_path("..")+'//Log//log'+time.year.to_s+time.month.to_s+time.day.to_s+".txt", "w+")
      @@pathFile = File.new(File.expand_path("..")+'//Log//log'+time.year.to_s+time.month.to_s+time.day.to_s+".txt", "w+")
      @@spacePathFile = File.new(File.expand_path("..")+'//Log//path'+".txt", "w+")
      @@signalPathFile = File.new(File.expand_path("..")+'//Log//signalPath'+time.year.to_s+time.month.to_s+time.day.to_s+".txt", "w+")
    end
  end

  module_function :createFile

  #基本写文件函数
  def baseWrite(note, content)
    @@logFile.syswrite(note+" "+content+"\n")
  end

  module_function :baseWrite

  #写入总路径文件
  def pathWrite(pathArray)

  end

  module_function :pathWrite

  #写入信号路径文件
  def signalPathWrite(pathArray)
    pathArray.each do |path|
      for j in 0..3
        @@signalPathFile.syswrite(path[j].to_s+" ")
      end
      @@signalPathFile.syswrite("\n")
    end
  end

  module_function :signalPathWrite


  #写入空间路径文件
  def spacePathWrite(pathArray)
    pathArray.each do |path|
      for i in 0..path.length-1
        for j in 0..2
          @@spacePathFile.syswrite(path[i][j].to_s+" ")
        end

      end
      @@spacePathFile.syswrite("\n")

    end
  end

  module_function :spacePathWrite

  def ueWrite(ueArray)
    ueFile = File.new(File.expand_path("..")+'//Doc//UserEquipment'+".txt", "w+")
    ueArray.each do |ue|
      for i in 0..3
        ueFile.syswrite(ue[i].to_s+" ")
      end
      ueFile.syswrite("\n")
    end
  end

  module_function :ueWrite

  #写入网元和终端直射距离
  def ueDistance(ueArray, neArray)
    distanceFile = File.new(File.expand_path("..")+'//Log//ueDistance'+".txt", "w+")
    ueArray.each do |ue|
      neArray.each do |ne|
        ueDistance = Space_Base.pointDistance(ne.coordinate, ue.coordinate)
        distanceFile.syswrite(ne.id.to_s+" "+ue.id.to_s+" "+ueDistance.to_s+"\n")
      end
    end
  end

  module_function :ueDistance

  #生成网格数据
  def gridWrite(ueArray)
    ueFile = File.new(File.expand_path("..")+'//Doc//UserEquipment'+".txt", "w+")
    ueArray.each do |ue|
      for i in 0..2
        ueFile.syswrite(ue[i].to_s+" ")
      end
      ueFile.syswrite("\n")
    end
  end

  module_function :gridWrite

  #输出虚拟源树数据
  def treeWrite(pointArray)
    treeFile = File.new(File.expand_path("..")+'//Doc//PointTree'+".txt", "w+")
    pointArray.each do |point|
      treeFile.syswrite(point.id.to_s+' ')
      treeFile.syswrite(point.coordinate[0].to_s+' '+point.coordinate[1].to_s+' '+point.coordinate[2].to_s+' ')
      treeFile.syswrite(point.fatherId.to_s+' ')
      treeFile.syswrite(point.level.to_s+' ')
      treeFile.syswrite(point.planeId.to_s+' ')
      treeFile.syswrite(point.cubeId.to_s+' ')
      treeFile.syswrite("\n")
    end
  end

  module_function :treeWrite

  #输出物体及其平面数据
  def cubeWrite(cubeArray)
    cubeFile = File.new(File.expand_path("..")+'//Doc//cubeArray'+".txt", "w+")
    cubeArray.each do |cube|
      cubeFile.syswrite('cubeId:'+' '+cube.id.to_s+' '+cube.plane.length.to_s+"\n")
      planeArray = cube.plane
      planeArray.each do |plane|
        cubeFile.syswrite('planeId:'+' '+plane.id.to_s+"\n")
        cubeFile.syswrite(plane.equation.to_s+' '+plane.point.to_s+"\n")
      end
    end
  end

  module_function :cubeWrite

  #首径输出及多径输出
  def firstPathWrite(pathArray)
    firstPathFile = File.new(File.expand_path("..")+'//Doc//firstPath'+".txt", "w+")
    pathArray.each do |path|
      for i in 0..3
        firstPathFile.syswrite(path[i].to_s+' ')
      end
      firstPathFile.syswrite("\n")
    end
  end

  module_function :firstPathWrite

  #首径输出及多径输出
  def multiPathWrite(pathArray)
    multiPathFile = File.new(File.expand_path("..")+'//Doc//multiPath'+".txt", "w+")
    pathArray.each do |path|
      for i in 0..3
        multiPathFile.syswrite(path[i].to_s+' ')
      end
      multiPathFile.syswrite("\n")
    end
  end

  module_function :multiPathWrite
end