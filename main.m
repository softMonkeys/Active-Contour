clear all; close all; clc; 

%% Parameter Setup

% Load/Save data 
image_name = 'circle';
image_format = '.jpg'; 
image_fname = fullfile('images', strcat(image_name, image_format)); 

% Parameters (play around with different images and different parameters)
%N = 200;%400;
%Wedge = .7; % image gradient
%Wline = .5; % image intensity (high: black/white)
%Wterm = 0.5; % corners (high goes unstable) 
%alpha = 0.14; %looseness (high: tight/tensed) 
%beta  = 0.2; % Curvature (high: sharp)
%gamma = 0.2; % stepsize for Internal(high: small)5
%kappa = 0.15; %0.15; % stepsize for loop 
%sigma = .5; %1%0.5; % Gaussian Blur (high: force getting less) for external

%save(strcat('data/', file_name, '.mat'), 'N', 'alpha', 'beta', 'gamma', 'kappa', 'Wline', 'Wedge', 'Wterm', 'sigma');
% Load data
load(fullfile('data', sprintf('%s.mat', image_name))); 


%% Main
% Load image
I = imread(image_fname);
if (ndims(I) == 3)
    I = rgb2gray(I);
end

% Initialize the snake
[x, y, fig] = initializeSnake(I, image_fname);

% Calculate external energy
I_smooth = double(imgaussfilt(I, sigma));
Eext = getExternalEnergy(I_smooth,Wline,Wedge,Wterm);

% Calculate matrix A^-1 for the iteration
Ainv = getInternalEnergyMatrixBonus(size(x,2), alpha, beta, gamma); 
Ainv_ = getInternalEnergyMatrix(size(x,2), alpha, beta, gamma); % for check

% Compare the A matrix to check 
A = inv(Ainv) - gamma*eye(size(x,2)); 
A_ = inv(Ainv_) - gamma*eye(size(x,2)); % for check

% Iterate and update positions
displaySteps = floor(N/10);
for i=1:N
    % Iterate
    [x,y] = iterate(Ainv, x, y, Eext, gamma, kappa);

    % Plot intermediate result
    imshow(I); 
    hold on;
    %plot([x x(1)], [y y(1)], 'r', 'LineWidth', 2);
    plot([x x(1)], [y y(1)], 'r'); 
        
    % Display step
    if(mod(i,displaySteps)==0)
        fprintf('%d/%d iterations\n',i,N);
    end
    
    pause(0.0001)
end
 
if(displaySteps ~= N)
    fprintf('%d/%d iterations\n',N,N);
end

%saveas(fig, strcat('capture/', file_name, '_ctr.png'));