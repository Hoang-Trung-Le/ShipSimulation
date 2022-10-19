clear;close;clc;

wp1 = [500 0];
wp2 = [1000 500];
wayPoint1 = flip(wp1);
wayPoint2 = flip(wp2);
% plot([wayPoint1(2),wayPoint1(1)],[wayPoint2(2),wayPoint2(1)])
% hold on
a = (wayPoint2(2) - wayPoint1(2)) / (wayPoint2(1) - wayPoint1(1));
b = -1;
c = wayPoint2(2) - a*wayPoint2(1);

line = [a b c];
x = linspace(-500,2500);
y = a*x + c;
plot(x,y)
hold on
plot(wayPoint2(1),wayPoint2(2),'*r')
plot(wayPoint1(1),wayPoint1(2),'*r')

shipPos = [0 0];
shipPos = flip(shipPos);
plot(shipPos(1),shipPos(2),'og')
syms xH yH

eqn1 = line(1)*xH + line(2)*yH + line(3) == 0;
eqn2 = line(2)*(xH - shipPos(1)) - line(1)*(yH - shipPos(2)) == 0;

[A, B] = equationsToMatrix([eqn1, eqn2], [xH, yH]);
H = double(linsolve(A,B))
plot(H(1),H(2),'or')
plot([shipPos(1) H(1)], [shipPos(2) H(2)])


%%
l = 50;
syms xL yL

eqnL1 = a*xL + b*yL + c == 0;
eqnL2 = (xL - H(1))^2 + (yL - H(2))^2 - (5*l)^2 == 0;
hl = [xL-H(1),yL-H(2)];
ab = [(wayPoint2(1) - wayPoint1(1)), (wayPoint2(2) - wayPoint1(2))];
eqnL3 = dot(hl,ab) > 0;
X = solve([eqnL1, eqnL2, eqnL3], [xL, yL]);
xL = double(X.xL);
yL = double(X.yL);
L = [xL, yL];
plot(xL(1),yL(1),'*g')
plot([shipPos(1) L(1)],[shipPos(2) L(2)],'m')
N = shipPos + [0 500];
plot([shipPos(1) N(1)],[shipPos(2) N(2)],'k')
% plot(xL(2),yL(2),'*b')
daspect([1 1 1])
sl = L - shipPos;
sn = [0 1];
beta = acos(dot(sl,sn)/(norm(sn)*norm(sl)));
if L(1) < shipPos(1)
   beta = -beta;
end
rad2deg(beta)
