# encoding: utf-8
=begin
项目: SPA
类名/模块名:
文件: Demo.rb
功能:
输入:
输出:
作者:刘洋
日期:17/4/8
时间:上午10:44
备注:
=end
$SPA_Path = '/Users/liuyang/Documents/Github/SPA'
require File.join($SPA_Path, '/IO/SPA_Write')
require File.join($SPA_Path, '/Data/Data_Cell')

module Demo
  #neArray1 = Data_Cell.getCellPointArray([60*1000,25*1000,20*1000])
  #neArray2 = Data_Cell.getIndoorCellPointArray()
  #SPA_Write.neWrite(neArray1+neArray2)

  #生成3GPP终端数据
  ueData = Data_Cell.ue(180)
  SPA_Write.ueWrite(ueData)

end
