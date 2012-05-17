function draw_coordinate_system(linear, origin, thickness)
    if nargin < 2 || ~exist('origin', 'var') || isempty(origin)
        origin = zeros(3,1);
    end
    if nargin < 3
        thickness = 1;
    end
    x = repmat(origin(1),3,1);
    y = repmat(origin(2),3,1);
    z = repmat(origin(3),3,1);
    line([x x+linear(1,:)']', [y y+linear(2,:)']', [z z+linear(3,:)']', 'LineWidth',thickness);