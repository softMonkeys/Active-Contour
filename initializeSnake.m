function [x, y, fig] = initializeSnake(I, file_name)

% Show figure
fig = figure;
imshow(I); 
hold on; 

% Get initial points
[Px, Py] = getpts();

Sx = [Px' Px(1)]; 
Sy = [Py' Py(1)];
plot(Sx, Sy, 'b-s','MarkerFaceColor','b'); 
hold on

%saveas(fig, strcat('capture/', file_name, '_init.png'));

% Interpolate
n_sample = 100;

n = size(Sx, 2);
t = 1:n;
ts = 1:(1/(n_sample-1))*(n-1):n;
x = spline(t,Sx,ts);
y = spline(t,Sy,ts);

% Clamp points to be inside of image
% 1 <= x <= col of Image
x = max(1, x); 
x = min(x, size(I,2));
% 1 <= y <= row of Image
y = max(1, y); 
y = min(y, size(I,1));

plot(x, y, 'r'); 
end
