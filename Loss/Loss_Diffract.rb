include Math
require 'complex'
require 'cmath'
require File.join($SPA_Path,'/Loss/Loss_Direct')
require File.join($SPA_Path,'/Space/Space_Base')
#计算一次绕射后的场强
#s1是入射波波程 s2是绕射波波程 v是 劈角   f是频率
# angle1是入射面与参考面的夹角，angle2是绕射面与参考面的夹角，angle3是入射线或绕射线与尖劈的夹角
# rn 是入射路径与正向劈面的反射系数，r0是入射路径与垂向劈面的反射系数
module Loss_DifLoss
def diffractionEe(s1,s2,v,angle1,angle2,angle3,f,signalValue,preSignalValue,rn,r0)
  wavelength=300000000/f
  k=(2*PI)/wavelength
  n=2-v/PI
  l=s1*s2*1.0/(s1+s2)*(Math.sin(angle3))**2
  r1=(PI-angle2+angle1)/(2*n)/1
  x1=2*k*l*n**2*(Math.sin(r1)**2)
  a1=-2*Math.sqrt(x1)*(Math.cos(x1)*Space_Base.integral(0,1/Math.sqrt(x1)){|x|1/x**2*Math.sin(-1/x**2)}+Math.sin(x1)*Space_Base.integral(0,1/Math.sqrt(x1)){|x|1/x**2*Math.cos(-1/x**2)})
  b1=-2*Math.sqrt(x1)*(Math.cos(x1)*Space_Base.integral(0,1/Math.sqrt(x1)){|x|1/x**2*Math.cos(-1/x**2)}+Math.sin(x1)*Space_Base.integral(0,1/Math.sqrt(x1)){|x|1/x**2*Math.sin(-1/x**2)})
  f1=Complex(a1,b1)
  d1=(Complex(Math.sqrt(2)/2,-1*Math.sqrt(2)/2))/(2*n*Math.sqrt(2*PI*k))*1/(Math.tan(r1))*f1
  r2=(PI+angle2-angle1)/(2*n)/1
  x2=2*k*l*n**2*(Math.sin(r2)**2)
  a2=-2*Math.sqrt(x2)*(Math.cos(x2)*Space_Base.integral(0,1/Math.sqrt(x2)){|x|1/x**2*Math.sin(-1/x**2)}+Math.sin(x2)*Space_Base.integral(0,1/Math.sqrt(x2)){|x|1/x**2*Math.cos(-1/x**2)})
  b2=-2*Math.sqrt(x2)*(Math.cos(x2)*Space_Base.integral(0,1/Math.sqrt(x2)){|x|1/x**2*Math.cos(-1/x**2)}+Math.sin(x2)*Space_Base.integral(0,1/Math.sqrt(x2)){|x|1/x**2*Math.sin(-1/x**2)})
  f2=Complex(a2,b2)
  d2=(Complex(Math.sqrt(2)/2,-1*Math.sqrt(2)/2))/(2*n*Math.sqrt(2*PI*k))*1/(Math.tan(r2))*f2
  r3=(PI-angle2-angle1)/(2*n)/1
  x3=2*k*l*n**2*(Math.sin(r3)**2)
  a3=-2*Math.sqrt(x3)*(Math.cos(x3)*Space_Base.integral(0,1/Math.sqrt(x3)){|x|1/x**2*Math.sin(-1/x**2)}+Math.sin(x3)*Space_Base.integral(0,1/Math.sqrt(x3)){|x|1/x**2*Math.cos(-1/x**2)})
  b3=-2*Math.sqrt(x3)*(Math.cos(x3)*Space_Base.integral(0,1/Math.sqrt(x3)){|x|1/x**2*Math.cos(-1/x**2)}+Math.sin(x3)*Space_Base.integral(0,1/Math.sqrt(x3)){|x|1/x**2*Math.sin(-1/x**2)})
  f3=Complex(a3,b3)
  d3=(Complex(Math.sqrt(2)/2,-1*Math.sqrt(2)/2))/(2*n*Math.sqrt(2*PI*k))*1/(Math.tan(r3))*f3
  r4=(PI+angle2+angle1)/(2*n)/1
  x4=2*k*l*n**2*(Math.sin(r4)**2)
  a4=-2*Math.sqrt(x4)*(Math.cos(x4)*Space_Base.integral(0,1/Math.sqrt(x4)){|x|1/x**2*Math.sin(-1/x**2)}+Math.sin(x4)*Space_Base.integral(0,1/Math.sqrt(x4)){|x|1/x**2*Math.cos(-1/x**2)})
  b4=-2*Math.sqrt(x4)*(Math.cos(x4)*Space_Base.integral(0,1/Math.sqrt(x4)){|x|1/x**2*Math.cos(-1/x**2)}+Math.sin(x4)*Space_Base.integral(0,1/Math.sqrt(x4)){|x|1/x**2*Math.sin(-1/x**2)})
  f4=Complex(a4,b4)
  d4=(Complex(Math.sqrt(2)/2,-1*Math.sqrt(2)/2))/(2*n*Math.sqrt(2*PI*k))*1/(Math.tan(r4))*f4
  d=d1+r0*rn*d2+r0*d3+rn*d4#r0 rn 是0参考面和n参考面的反射系数
  asa=Math.sqrt(s1*1.0/(s2*(s1+s2)))
 xs= Complex(Math.cos(k*s2),Math.sin(k*s2))
  ede=d*signalValue*asa*xs
  ede1=(ede).real
  ede2=(ede).imaginary
  ede3=Math.sqrt((ede1)**2+(ede2)**2)
  p d
  p 20*log10(ede3)
  p signalValue
  diffractionEe=20*log10(ede3)-20*log(preSignalValue.abs)
  return diffractionEe
end
 module_function :diffractionEe
end
