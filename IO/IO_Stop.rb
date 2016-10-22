# encoding: utf-8
=begin
项目: SPA
类名/模块名:
文件: IO_Stop.rb
功能:
输入:
输出:
作者:刘洋
日期:16/10/19
时间:下午10:35
备注:
=end
require 'socket'
module Client3
  #好用
  def stopServer(port)
    hostname = 'localhost'
    s = TCPSocket.open(hostname, port)
    sleep(1)
    s.puts("stop")
    s.close # 关闭 socket
  end

  module_function :stopServer
end
t1 = Thread.new{Client3.stopServer(2000)}
t2 = Thread.new{Client3.stopServer(2001)}
t1.join
t2.join
