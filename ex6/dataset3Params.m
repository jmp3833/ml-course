function [C, sigma] = dataset3Params(X, y, Xval, yval)
%DATASET3PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = DATASET3PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.3;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%

valuesToTry = [0.01 0.03 0.1 0.3 1 3 10 30];
lowest_predicted_error = inf;

for i = 1:8
  for j = 1:8
    % create model with varied values of C and Sigma
    C_to_try = valuesToTry(i);
    sigma_to_try = valuesToTry(j);
    model = svmTrain(X, y, C_to_try, @(x1, x2) gaussianKernel(x1, x2, sigma_to_try)); 

    %Validate local model against cross validation set
    predictions = svmPredict(model, Xval);
    pred_error = mean(double(predictions ~= yval));

    %If predicted error with C and sigma is lower than lowest
    %currently found, replace global C and sigma
    if pred_error < lowest_predicted_error
      C = C_to_try;
      sigma = sigma_to_try;
      lowest_predicted_error = pred_error;
    end
  end
end
% =========================================================================
end
