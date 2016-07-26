point1 = [200,1700,0]
point2 = [5200,6200,0]
dx = (point2[0]- point1[0])/10.0
dy = (point2[1]- point1[1])/10.0
z = 0.0
pointArray = Array.new

for i in 0..10
  for j in 0..10
    point = [point1[0]+dx*i,point1[1]+dy*j,z]
    pointArray.push(point)
  end
end
