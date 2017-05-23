clear all;
clc;

featvales= xlsread('filename1t.xlsx','A1:ALL200');
label= xlsread('filename1t.xlsx','ALM1:ALM200');
save('data','featvales','label');
load('data');
%GWO
SearchAgents_no=2; % Number of search agents
Function_name='im'; % Name of the test function that can be from F1 to F23 (Table 1,2,3 in the paper)
Max_iteration=300; % Maximum numbef of iterations
% Load details of the selected benchmark function
[lb,ub,dim,fobj]=Get_Functions_details1(Function_name);
[Best_score,Best_pos,GWO_cg_curve]=GWO(SearchAgents_no,Max_iteration,lb,ub,dim,fobj,featvales,label);
Error_rate= Best_score
x=Best_pos;
featvales1 = xlsread('filename1.xlsx','A921:ALL921');

for i=1:size(x,2)
    if x(i)>0.4
        x1(i)=1;
    else
        x1(i)=0;
    end
end

% temp=featvales;
temp=featvales;
Y=label;
vc=[];
%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:size(temp,1)
q=1;
for j=1:size(temp,2)
if x1(j)~=0
vc(i,q)=temp(i,j);
q=q+1;
end
end
end

%%%%%%%%%%%%%%%%%%%%%%%%%
n_points=size(vc,1);
s_point  = round (n_points*0.7);
seq = randperm(n_points);
X_train = vc(seq(1:s_point),:);
Y_train = Y(seq(1:s_point),:);
X_test = vc(seq(s_point+1:end),:);
Y_test = Y(seq(s_point+1:end),:);

    svmStruct = svmtrain(X_train,Y_train);

    temp1=featvales1;
vc1=[];
%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:size(temp1,1)
q=1;
for j=1:size(temp1,2)
if x1(j)~=0
vc1(i,q)=temp1(i,j);
q=q+1;
end
end
end

 result = svmclassify(svmStruct,vc1)
 
