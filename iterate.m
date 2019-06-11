function [newX, newY] = iterate(Ainv, x, y, Eext, gamma, kappa)

% Get fx and fy
fx = conv2(Eext, [ -1 1], 'same');
fy = conv2(Eext, [ -1;1], 'same');
%[fx, fy] = gradient(Eext);

% Iterate
fxi = interp2(fx, x, y);
fyi = interp2(fy, x, y); 

% interp2
newX = Ainv*(gamma*x' - kappa*fxi');
newY = Ainv*(gamma*y' - kappa*fyi');

% Clamp to image size
% 1 <= x <= col of Image
newX = max(1, newX); 
newX = min(newX, size(fx,2));
% 1 <= y <= row of Image
newY = max(1, newY); 
newY = min(newY, size(fy,1));

newX = newX'; 
newY = newY'; 

end

