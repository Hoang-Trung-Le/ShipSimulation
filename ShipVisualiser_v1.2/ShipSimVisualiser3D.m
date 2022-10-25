%% SHIP SIMULATION
function ShipSimVisualiser3D(axes)
%load('NoHeading.mat');
load('CompleteTest.mat')

%recordings = out.recordout
%trajX = recordings{1}.Values;
%trajY = recordings{2}.Values;

posY = out.eta.Data(:,1)
posX = out.eta.Data(:,2)
heading = out.eta.Data(:,3)
alpha = out.alpha.Data(:,1);

dualpods = true; %option to display two pod objects as in real life
out.alpha.Time(end)
%% SHIP ANIMATION
hold on
axis equal
%Ship = PlaceObject('Ship_5.ply',[x,y,0.0])
% surf([-50,-50;50,50],[-50,50;-50,50],[0.0,0.0;0.0,0.0],'CData',imread('ocean.jpg'),'FaceColor','texturemap','FaceAlpha',0.7); %starting ocean area
% set(gca,'color', [0.6 0.8 1]); %plot bg colour

Ship = PlaceObj('Ship_7.ply', axes) %place the ship model



if dualpods == false
   Pod = PlaceObj('Pod_3.ply', axes)   %place the propeller model (size is exaggerated for visibility)
   MoveObj(Pod,[[0,-6,0],[0,0,0]])
   pause(1)
   for i = 1:size(posX) %animate through the simulation output
      pause(0.5)
      yaw = -heading(i)
      MoveObj(Ship,[[posX(i),posY(i),0.5],[0,0,yaw]])
      MoveObj(Pod,[[posX(i)+6*sin(yaw),posY(i)-6*cos(yaw),0.0],[0,0,yaw-alpha(i)]])
   end
else
   Pod1 = PlaceObj('Pod_3.ply', axes)   %place and offset the twin propeller models
   Pod2 = PlaceObj('Pod_3.ply', axes)
   MoveObj(Pod1,[[3,-6,0],[0,0,-1]])
   MoveObj(Pod1,[[-3,-6,0],[0,0,-1]])
   pause(1)
   for i = 1:size(posX) %animate through the simulation output
      pause(0.5)
      yaw = -heading(i)
      MoveObj(Ship,[[posX(i),posY(i),0.5],[0,0,yaw]])
      MoveObj(Pod1,[[posX(i)+6*sin(yaw)+3*cos(yaw),posY(i)-6*cos(yaw)+3*sin(yaw),-1],[0,0,yaw-alpha(i)]])
      MoveObj(Pod2,[[posX(i)+6*sin(yaw)-3*cos(yaw),posY(i)-6*cos(yaw)-3*sin(yaw),-1],[0,0,yaw-alpha(i)]])
   end
end
end