function [y1, y2] = hope(u, t)
y1 = u(1,:)
y2 = u(2,:)

if t < 300.0
   y1 = u(2,:)
   y2 = u(3,:)
end
end