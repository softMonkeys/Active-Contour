function [Ainv] = getInternalEnergyMatrix(nPoints, alpha, beta, gamma)

alpha = -1 * alpha; 
A = diag((-2*alpha+6*beta)*ones(1, nPoints), 0);
A = A + diag((alpha-4*beta)*ones(1, nPoints-1), 1);
A = A + diag((alpha-4*beta)*ones(1, nPoints-1), -1);
A = A + diag((alpha-4*beta)*ones(1, 1), nPoints-1);
A = A + diag((alpha-4*beta)*ones(1, 1), -(nPoints-1));
A = A + diag((beta)*ones(1, nPoints-2), 2);
A = A + diag((beta)*ones(1, nPoints-2), -2);
A = A + diag((beta)*ones(1, 2), nPoints-2); 
A = A + diag((beta)*ones(1, 2), -(nPoints-2)); 

Ainv = inv(A + gamma*eye(nPoints)) ; 

end

