function draw_coordinate_system(linear, origin, thickness, drawtxt)
    if nargin < 2 || ~exist('origin', 'var') || isempty(origin)
        origin = zeros(3,1);
    end
    if nargin < 3 || ~exist('thickness', 'var') || isempty(thickness)
        thickness = 1;
    end
    if nargin < 3 || ~exist('drawtxt', 'var') || isempty(drawtxt)
        drawtxt = 0;
    end
    x = repmat(origin(1),3,1);
    y = repmat(origin(2),3,1);
    z = repmat(origin(3),3,1);
    line([x x+linear(1,:)']', [y y+linear(2,:)']', [z z+linear(3,:)']', 'LineWidth',thickness);
    if drawtxt
        distance = drawtxt;
        text('Position', origin+distance*linear(:,1), 'String', 'x');
        text('Position', origin+distance*linear(:,2), 'String', 'y');
        text('Position', origin+distance*linear(:,3), 'String', 'z');
    end