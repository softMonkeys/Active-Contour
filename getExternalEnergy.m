function [Eext] = getExternalEnergy(I,Wline,Wedge,Wterm)

% Eline
Eline = I; 

% Eedge
[Gmag, ~] = imgradient(I,'central'); 
Eedge = -1.0 * Gmag; % -1*Gmag; 

% Eterm
filter_x = [-1 1]; 
filter_y = [-1;1];
filter_xx = [1 -2 1]; 
filter_yy = [1; -2; 1]; 
filter_xy = [1 -1; -1 1]; 
Cx = conv2(I, filter_x, 'same'); 
Cy = conv2(I, filter_y, 'same'); 
Cxx = conv2(I, filter_xx, 'same');
Cyy = conv2(I, filter_yy, 'same');
Cxy = conv2(I, filter_xy, 'same');
%Cxy = conv2(Cx, filter_y, 'same');
Eterm = (Cyy.*Cx.^2 - 2 * Cxy.*Cx.*Cy + Cxx.*Cy.^2)./(1 + Cx.^2 + Cy.^2).^(3/2); 

% Eext
Eext = Wline*Eline + Wedge*Eedge + Wterm*Eterm; 

end

