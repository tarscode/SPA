# encoding: utf-8
=begin
项目: SPA
类名/模块名:
文件: SPA_File.rb
功能:
输入:
输出:
作者:刘洋
日期:16/7/26
时间:上午10:28
备注:判断数据文件是否存在
=end
module SPA_File
  def inputFile
    neFile = FileTest.exist?(File.expand_path("..")+"/Doc/NetElement.txt")
    ueFile = FileTest.exist?(File.expand_path("..")+"/Doc/UserEquipment.txt")
    signalFile = FileTest.exist?(File.expand_path("..")+"/Doc/Signal.txt")
    spacelFile = FileTest.exist?(File.expand_path("..")+"/Doc/Space.txt")
    $logger.info("neFile:"+neFile.to_s+" ueFile:"+ueFile.to_s+" signalFile:"+signalFile.to_s+" spaceFile:"+spacelFile.to_s)
    if neFile&&ueFile&&signalFile&&spacelFile then
      return false
    end
      return true
  end
  module_function :inputFile
end

