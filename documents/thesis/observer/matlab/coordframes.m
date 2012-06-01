NEDEF = eye(3);
NED = eye(3);

BF = ...
    external.rotationmat3D(-0.474933*pi/180, [1,0,0])... % Roll
    *external.rotationmat3D(0.201372*pi/180, [0,1,0])... % Pitch
    *external.rotationmat3D(19.5753*pi/180, [0,0,1]); % Yaw

CAM = BF*external.rotationmat3D(-30*pi/180, [0,1,0]);

PTAM = [-0.324889   0.945334 -0.0281195;
0.941844 0.320703  -0.1004;
-0.0858934 -0.059103  -0.99455]';
ptamorigin = [0.641523; -0.753724;  0];

origin = [-1.79553; -1.24494; -1.34022];
camorigin = origin + BF*[0;0;0.1];
%%
figures.getFigure('worldcoordframes');clf;
draw_coordinate_system(NEDEF,[],[],1.1); text('Position', [-0.15;0;0], 'String', 'NEDEF');
draw_coordinate_system(BF*0.5, origin,2,1.2); text('Position', origin + [0.1;0.1;0], 'String', 'BF');
draw_coordinate_system(PTAM*0.6, ptamorigin,[],1.1); text('Position', ptamorigin + [0.1;0.1;-0.02], 'String', 'PTAM');
view([58 27]);
legend('X', 'Y', 'Z', 'Location', 'NorthEast');
axis equal;
% text(1.1,0,0,'X'); text(0,1.1,0,'Y'); text(0,0,1.1,'Z');
set(gca,'XDir','reverse'); set(gca,'ZDir','reverse');
%%
figures.getFigure('quadrotorcoordframes');clf;
xlabel('X'); ylabel('Y'); zlabel('Z');
draw_coordinate_system(NED*0.7, origin,[],1.1); text('Position', origin + [0.4;-0.05;0], 'String', 'NED');
draw_coordinate_system(BF*0.5, origin, 3, 1.1); text('Position', origin+[-0.02;0;0], 'String', 'BF');
draw_coordinate_system(CAM*0.2, camorigin, 2); text('Position', camorigin+[-0.02;0;0], 'String', 'Camera');
L = 0.25;
draw_coordinate_system(BF*0.1, origin + BF*[L;0;0]); text('Position', origin + BF*[L + 0.05;0.05;0], 'String', 'P_1');
draw_coordinate_system(BF*0.1, origin + BF*[0;L;0]); text('Position', origin + BF*[0.05;-L+0.05;0], 'String', 'P_2');
draw_coordinate_system(BF*0.1, origin + BF*[-L;0;0]); text('Position', origin + BF*[-L+0.05;0.05;0], 'String', 'P_3');
draw_coordinate_system(BF*0.1, origin + BF*[0;-L;0]); text('Position', origin + BF*[0.05;L+0.05;0], 'String', 'P_4');
view([5 25]);
axis equal;
set(gca,'XDir','reverse'); set(gca,'ZDir','reverse');

%%
figures.getFigure('ground');clf;
draw_coordinate_system(NEDEF); text('Position', [-0.15;0;0], 'String', 'NEDEF');
axis equal;
set(gca,'XDir','reverse'); set(gca,'ZDir','reverse');
draw_coordinate_system(CAM*0.2, camorigin, 2); text('Position', camorigin+[-0.1;0;0], 'String', 'Camera');
draw_coordinate_system(PTAM*0.6, ptamorigin); text('Position', ptamorigin + [0.1;0.1;0.1], 'String', 'PTAM');

line([camorigin(1) ptamorigin(1)]', [camorigin(2) ptamorigin(2)]', [camorigin(3) ptamorigin(3)]', 'LineWidth',1, 'LineStyle', '--');
h = text('Position', camorigin + 0.3*(ptamorigin-camorigin) + [0.2;0;-0.1], 'Interpreter', 'tex', 'String', 'l');
set(h, 'FontName', 'Symbol');
view([9 24]);
axis equal;