# encoding: utf-8
=begin
项目: SPA
类名/模块名:
文件: IO_Server.rb
功能:
输入:
输出:
作者:刘洋
日期:16/7/26
时间:下午4:14
备注:服务器模块
说明:
=end
require 'socket'

module IO_Server
  def base(port)
    server = TCPServer.open(port)   # Socket 监听端口为 2000
    loop {                          # 永久运行服务
      Thread.start(server.accept) do |client|
        client.puts(Time.now.ctime) # 发送时间到客户端
        client.puts "Closing the connection. Bye!"
        client.close                # 关闭客户端连接
      end
    }
  end
  module_function :base

  def test
    server = TCPServer.open(2000)   # Socket 监听端口为 2000
    loop {                          # 永久运行服务
      Thread.start(server.accept) do |client|
        p "server"
        p client.gets
        client.puts("serverdata")
        filename = File.expand_path("..")+"/Doc/NetElement.txt"
        file = File.open(filename)
        file.each_line do |line|
          client.puts(line)
        end
        client.close                # 关闭客户端连接
      end
    }
  end
  module_function :test

  def server1
    Socket.tcp_server_loop(2000) do |connection|
      while line = connection.gets   # 从 socket 中读取每行数据
        puts line.chop      # 打印到终端
      end
      connection.close
    end
  end
  module_function :server1

end

#IO_Server.test
IO_Server.server1
