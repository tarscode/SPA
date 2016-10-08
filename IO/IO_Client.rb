# encoding: utf-8
=begin
项目: SPA
类名/模块名:
文件: IO_Client.rb
功能:
输入:
输出:
作者:刘洋
日期:16/7/26
时间:下午4:14
备注:客户端模块
说明:
=end
require 'socket'

module IO_Client
  #好用
  def test
    hostname = 'localhost'
    #hostname = '125.223.126.136'
    #hostname = '192.168.1.100'
    port = 2000
    #port = 12345
    file = File.new(File.expand_path("..")+'//Log//socket'+".txt", "w+")
    s = TCPSocket.open(hostname, port)
    sleep(1)
    s.puts("hello")
    while line = s.gets # 从 socket 中读取每行数据
      file.syswrite(line) # 写入文件
      puts line.chop # 打印到终端
    end
    s.close # 关闭 socket
  end

  module_function :test

  #传播分析模块客户端
  def spa
    #hostname = 'localhost'
    hostname = '125.223.119.101'
    #hostname = '192.168.31.20'
    port = 2000
    uefile =File.expand_path('..')+'//Doc//ue.txt'
    #永久运行服务
    loop {
      if !FileTest.exist?(uefile)||File.size(uefile) == 0 then
        p "not exist"
        file = File.new(uefile, 'w+')
        filename = 'ue'
      else
        p "exist"
        sleep(5)
        next
      end
      s = TCPSocket.open(hostname, port)
      sleep(1)
      s.puts(filename)
      while line = s.gets # 从 socket 中读取每行数据
        if line.to_s== "no\n" then
          sleep(5)
          s.close
        elsif line.to_s == "yes\n" then
        else
          file.syswrite(line) # 写入文件
          puts line.chop # 打印到终端
        end
      end
      s.close # 关闭 socket
    }
  end

  module_function :spa

  #编码测距模块客户端
  def car
    hostname = 'localhost'
    #hostname = '125.223.126.136'
    #hostname = '192.168.1.100'
    port = 2000
    nefile =File.expand_path('..')+'//ne.txt'
    pathfile = File.expand_path('..')+'//signalPath.txt'
    distancefile = File.expand_path('..')+'//ueDistance.txt'
    uefile = File.expand_path('..')+'//UserEquipment.txt'
    #永久运行服务
    loop {
      if !FileTest.exist?(nefile)||File.size(nefile) == 0 then
        file = File.new(nefile, 'w+')
        filename = 'ne'
      elsif !FileTest.exist?(pathfile) || File.size(pathfile) == 0 then
        file = File.new(pathfile, 'w+')
        filename = 'path'
      elsif !FileTest.exist?(distancefile) || File.size(distancefile) == 0 then
        file = File.new(distancefile, 'w+')
        filename = 'ueDistance'
      elsif !FileTest.exist?(uefile) || File.size(uefile) == 0 then
        file = File.new(uefile, 'w+')
        filename = 'UserEquipment'
      else
        sleep(5)
        next
      end
      s = TCPSocket.open(hostname, port)
      sleep(1)
      s.puts(filename)
      while line = s.gets # 从 socket 中读取每行数据
        p line.to_s
        if line.to_s== "no\n" then
          sleep(5)
          s.close
        elsif line.to_s == "yes\n" then
        else
          file.syswrite(line) # 写入文件
          puts line.chop # 打印到终端
        end
      end
      s.close # 关闭 socket
    }
  end

  module_function :car

end
#IO_Client.car
IO_Client.spa

