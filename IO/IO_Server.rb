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
$SPA_Path = '/Users/liuyang/Documents/Github/SPA'
require File.join($SPA_Path, '/IO/SPA_Write')
require 'socket'

module IO_Server

  #spa模块服务器
  def spa
    server = TCPServer.open(2000) # Socket 监听端口为 2000
    loop {# 永久运行服务
      Thread.start(server.accept) do |client|
        p "server"
        requestFile = client.gets
        requestFile = requestFile.delete("\n") #删除换行符
        if requestFile=='ne' then
          filename = '/Users/liuyang/Documents/Github/SPA'+'/Doc/NetElement.txt'
        elsif requestFile == 'path'
          filename = '/Users/liuyang/Documents/Github/SPA'+'/Log/signalPath.txt'
        elsif requestFile == 'ueDistance'
          filename = '/Users/liuyang/Documents/Github/SPA'+'/Log/ueDistance.txt'
        elsif requestFile == 'UserEquipment'
          filename = '/Users/liuyang/Documents/Github/SPA'+'/Doc/UserEquipment.txt'
        else
          filename = '/Users/liuyang/Documents/Github/SPA/Doc/'+requestFile.to_s+'.txt'
        end
        fileExist = FileTest.exist?(filename) #判断文件是否存在
        p "filename#{filename}"
        if fileExist then
          client.puts('yes')
          file = File.open(filename)
          file.each_line do |line|
            client.puts(line)
          end
          client.close # 关闭客户端连接
        else
          client.puts('no')
          client.close
        end
      end
    }
  end

  module_function :spa

  #car模块服务器
  def car
    server = TCPServer.open(2001) # Socket 监听端口为 2000
    loop {# 永久运行服务
      Thread.start(server.accept) do |client|
        p "server"
        location = client.gets
        location = location.delete("\n") #删除换行符
        locationArray = location.split()
        p location
        SPA_Write.locationWrite(locationArray)
        client.close
      end
    }
  end

  module_function :car

end
IO_Server.spa
IO_Server.car
