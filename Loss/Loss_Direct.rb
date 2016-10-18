# encoding: utf-8
=begin
项目: SPA
类名/模块名:
文件: Loss_Direct.rb
功能:直射损耗计算
输入:信号初始功率、信号频率、发射端到测试点距离
输出:信号直射损耗后功率
作者:田易
日期:16/6/16
时间:下午3:49
备注:
=end
module Loss_Direct
  def direct(signalValue,distance,frequency)
    signalValueLoss=20*log10(frequency/1000000.0)+20*log10(distance*1.0/1000000.0)+32.45
    signalValue = signalValue - signalValueLoss
    return signalValue
  end
  module_function :direct
end
