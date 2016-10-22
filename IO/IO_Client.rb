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
  #求师兄
  def send_to
     hostname = '125.223.120.28'
     port = 2000
    s = TCPSocket.open(hostname, port)
    begin
      sleep(0.5)
      msg = s.read_nonblock(4096)
    rescue SystemCallError
    end
    s.flush
  rescue
    puts $!
  ensure
    s.close if s
  end
  module_function :send_to

  #好用
  def test
    #hostname = 'localhost'
    hostname = '125.223.119.101'
    #hostname = '192.168.1.100'
    port = 3001
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

  #传播分析客户端matlab服务器
  def spa2
    hostname = 'localhost'
    #hostname = '192.168.31.20'
    #hostname = '125.223.123.252'
    port = 2000
    uefile =File.expand_path('..')+'//Doc//location.txt'
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
          file.syswrite(line) # 写入文件
          puts line.chop # 打印到终端
      end
      s.close # 关闭 socket
    }
  end

  module_function :spa2

  #传播分析模块客户端
  def spa
    hostname = 'localhost'
    #hostname = '192.168.31.20'
    #hostname = '125.223.123.252'
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
    #hostname = '125.223.119.101'
    #hostname = '192.168.1.100'
    port = 2000
    nefile =File.expand_path('..')+'//ne1.txt'
    pathfile = File.expand_path('..')+'//signalPath1.txt'
    distancefile = File.expand_path('..')+'//ueDistance11.txt'
    uefile = File.expand_path('..')+'//UserEquipment111.txt'
    #永久运行服务
    loop {
      #获取全部文件,请求终止
      if(FileTest.exist?(nefile)&&File.size(nefile)!=0&&FileTest.exist?(pathfile)&&File.size(pathfile)!=0&&FileTest.exist?(distancefile)&&File.size(distancefile)!=0&&FileTest.exist?(uefile)&&File.size(uefile)!=0) then
        p "getAllFile"
        break
      end
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

  #编码测距模块客户端2
  def car2
    hostname = 'localhost'
    #hostname = '125.223.119.101'
    #hostname = '192.168.1.100'
    port = 2000
    pathfile = File.expand_path('..')+'//signalPath1.txt'
    distancefile = File.expand_path('..')+'//ueDistance11.txt'
    uefile = File.expand_path('..')+'//UserEquipment111.txt'
    #永久运行服务
    loop {
      #获取全部文件,请求终止
      if(FileTest.exist?(nefile)&&File.size(nefile)!=0&&FileTest.exist?(pathfile)&&File.size(pathfile)!=0&&FileTest.exist?(distancefile)&&File.size(distancefile)!=0&&FileTest.exist?(uefile)&&File.size(uefile)!=0) then
        p "getAllFile"
        break
      end
      if !FileTest.exist?(pathfile) || File.size(pathfile) == 0 then
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

  module_function :car2

  #获取网元的客户端
  def ne
    hostname = 'localhost'
    #hostname = '125.223.119.101'
    #hostname = '192.168.1.100'
    port = 2000
    nefile =File.expand_path('..')+'//ne1.txt'
    #永久运行服务
    loop {
      #获取全部文件,请求终止
      if(FileTest.exist?(nefile)&&File.size(nefile)!=0) then
        p "getNEfile"
        break
      end
      if !FileTest.exist?(nefile)||File.size(nefile) == 0 then
        file = File.new(nefile, 'w+')
        filename = 'ne'
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

  module_function :ne

  #好用
  def stopServer(port)
    #hostname = 'localhost'
    filename = uefile =File.expand_path('..')+'//Doc//IP.txt'
    file = File.open(filename)
    hostname = file.readline
    p hostname
    file.close
    s = TCPSocket.open(hostname, port)
    sleep(1)
    s.puts("stop")
    s.close # 关闭 socket
  end

  module_function :stopServer
end
t1 = Thread.new{IO_Client.stopServer(2000)}
t2 = Thread.new{IO_Client.stopServer(2001)}
t1.join
t2.join
#IO_Client.send_to
#IO_Client.car
#IO_Client.ne
#IO_Client.spa2
#IO_Client.test

