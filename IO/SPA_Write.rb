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
  def ueDistance(ueArray,neArray)
    distanceFile = File.new(File.expand_path("..")+'//Log//ueDistance'+".txt", "w+")
    ueArray.each do |ue|
      neArray.each do |ne|
        ueDistance = Space_Base.pointDistance(ne.coordinate,ue.coordinate)
        distanceFile.syswrite(ne.id.to_s+" "+ue.id.to_s+" "+ueDistance.to_s+"\n")
      end
    end
  end

  module_function :ueDistance
end