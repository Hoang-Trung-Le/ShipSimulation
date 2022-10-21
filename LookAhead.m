function L = LookAhead(wayPoint1, wayPoint2, line, H, l)

% L(xL, yL) is the lookahead point
% syms xL yL
% 
% eqnL1 = line(1)*xL + line(2)*yL + line(3) == 0; % L is on the path's line formula
% eqnL2 = (xL - H(1))^2 + (yL - H(2))^2 - (5*l)^2 == 0; % distance from H to L is usually 5*l
% 
% HL = [xL-H(1),yL-H(2)];
% AB = [(wayPoint2(1) - wayPoint1(1)), (wayPoint2(2) - wayPoint1(2))];
% eqnL3 = dot(HL, AB) > 0; % vector HL has the same direction as the direction vector of the path's line formula so their dot product is positive
% 
% X = solve([eqnL1, eqnL2, eqnL3], [xL, yL]);
% xL = double(X.xL);
% yL = double(X.yL);
% L = [xL, yL];

% xL is the concerned variable
% L is on the path -> a*xL + b*yL + c = 0 -> yL = a*xL + c (b = -1)
% a*x^2 + bx + c = 0
% AB = [(wayPoint2(1) - wayPoint1(1)), (wayPoint2(2) - wayPoint1(2))];
% a = line(1)^2 + 1;
% b = -2*(H(1) - line(1)*line(3) + line(1)*H(2));
% c = H(1)^2 + line(3)^2 - 2*line(3)*H(2) + H(2)^2 - (2*l)^2;
% xLs = roots([a b c]);
% cond = (H(1)*AB(1) - (line(3) - H(2))*AB(2)) / (AB(1) + line(1)*AB(2));
% xL = xLs(xLs > cond);
% yL = line(1)*xL + line(3);
% L = [xL, yL];

AB = [(wayPoint2(1) - wayPoint1(1)), (wayPoint2(2) - wayPoint1(2))];
U = AB / norm(AB);
L = H + (5*l)*U;

end