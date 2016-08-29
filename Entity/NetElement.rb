# encoding:utf-8
=begin
类名:NetElement（网元类）
功能：组织网元信息
作者：刘洋
日期：2016.3.25
备注：
=end

class NetElement 
  attr_accessor :id  #网元编号
  attr_accessor :coordinate #网元坐标
  attr_accessor :signal #网元信号对象数组
  attr_accessor :type #网元类型

end
