%% SHIP SIMULATION

load('NoHeading.mat');

recordings = out.recordout;
trajX = recordings{1}.Values;

figure(1)
trajX.Name = 'X Position (m)';
trajX.TimeInfo.Units = 'seconds';
plot(trajX,':b')

trajY = recordings{2}.Values;
figure(2)
trajY.Name = 'Y Position (m)';
trajY.TimeInfo.Units = 'seconds';
plot(trajY,':b')

figure(3)
plot(trajX.Data,trajY.Data)