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
  def base(hostname,port)
    p "client"
    s = TCPSocket.open(hostname, port)
    while line = s.gets   # 从 socket 中读取每行数据
      puts line.chop      # 打印到终端
    end
    s.close               # 关闭 socket
  end
  module_function :base

  def test
    #hostname = 'localhost'
    #hostname = '125.223.126.136'
    hostname = '192.168.1.100'
    #port = 2000
    port = 12345
    file = File.new(File.expand_path("..")+'//Log//file'+".txt", "w+")
    s = TCPSocket.open(hostname, port)
    sleep(1)
    s.puts(250)
    s.puts("hello")
    while line = s.gets   # 从 socket 中读取每行数据
      file.syswrite(line)
      puts line.chop      # 打印到终端
    end
    s.close               # 关闭 socket
  end
  module_function :test

  def test1
    #hostname = 'localhost'
    #hostname = '125.223.126.226'
    #hostname = '192.168.1.100'
    hostname = '125.223.126.136'
    port = 2000
    #port = 12345
    s = TCPSocket.open(hostname, port)
    p "client"
    sleep(1)
    s.puts(229229229)
    s.puts("hello")
    s.puts("from mac")
    p "client2"
    s.close               # 关闭 socket
  end
  module_function :test1

  def client1
    Socket.tcp('localhost',2000) do |connection|
      connection.puts("hello this is client1")
      connection.close
    end
  end
  module_function :client1

end
IO_Client.test1
#IO_Client.base('125.223.126.136',2000)
#IO_Client.base('localhost',2000)
