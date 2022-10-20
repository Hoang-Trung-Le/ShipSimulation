function projectedPoint = PointProjection(shipPos, line)

% H(xH, yH) is the orthogonally projected point of the current ship position on the designated path
% syms xH yH
% shipPos = flip(shipPos); % Reverse to familiar coordinate system
% 
% eqn1 = line(1)*xH + line(2)*yH + line(3) == 0; % H is on the path's line formula
% eqn2 = line(2)*(xH - shipPos(1)) - line(1)*(yH - shipPos(2)) == 0; % cross product of 2 vectors in the same direction (direction vector of distance and normal vector of path)
% 
% % Convert to standard linear algebra to solve H coordinates
% [A, B] = equationsToMatrix([eqn1, eqn2], [xH, yH]);
% projectedPoint = double(linsolve(A,B))';

A = [line(1) line(2); line(2) -line(1)];
B = [-line(3); line(2)*shipPos(1) - line(1)*shipPos(2)];
projectedPoint = transpose(A\B);

end
