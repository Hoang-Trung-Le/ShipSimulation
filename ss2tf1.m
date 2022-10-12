load statefeedback.mat
M = [25.8000000000000	0	0;
0	33.8000000000000	1.01150000000000;
0	1.01150000000000	2.76000000000000];
Minv=inv(M)
A = [Minv(2,2)*k1+Minv(2,3)*k3    Minv(2,2)*k2+Minv(2,3)*k4    0 ;   Minv(3,2)*k1+Minv(3,3)*k3    Minv(3,2)*k2+Minv(3,3)*k4    0 ; 0    1    0];
B = [2*T*Minv(2,3)*Xp  ;  2*T*Minv(3,3)*Xp ;  0]; 
C = [0 0 1]; 
D = [0]; 
[num,den] = ss2tf(A,B,C,D,1); 

