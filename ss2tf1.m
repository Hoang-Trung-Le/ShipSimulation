load statefeedback.mat
M = [25.8000000000000	0	0;
0	33.8000000000000	1.01150000000000;
0	1.01150000000000	2.76000000000000];
A = [(M(2,2)^-1)*k2+(M(2,3)^-1)*k4    (M(2,2)^-1)*k3+(M(2,3)^-1)*k5    0 ;   (M(3,2)^-1)*k2+(M(3,3)^-1)*k4    (M(3,2)^-1)*k3+(M(3,3)^-1)*k5    0 ; 0    1    0];
B = [-2*T*(M(2,3)^-1)*Xp  ;  -2*T*(M(3,3)^-1)*Xp ;  0]; 
C = [0 0 1]; 
D = [0]; 
[num,den] = ss2tf(A,B,C,D,1); 

