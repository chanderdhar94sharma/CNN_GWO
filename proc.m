function [perc_auc] = proc(x,featvales,label)

temp=featvales;
Y=label;
%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:size(temp,1)
q=1;
for j=1:size(temp,2)
if x(j)~=0
vc(i,q)=temp(i,j);
q=q+1;end
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

% Group(1:4)=1;
% Group(5:8)=0;
% test(1:2)=1;
% class=Group';
% 
% trainset=size(vc,1)-2;
%  j=1;
% for i=1:size(vc,1)
%     if i<=trainset
%     temp1(i,:)=vc(i,:);
%     else       
%         temp2(j,:)=vc(i,:);
%         j=j+1;
%     end
% end

    svmStruct = svmtrain(X_train,Y_train);

 result = svmclassify(svmStruct,X_test);
 
 test= Y_test;
 TT=0;FF=0;TF=0;FT=0;
for i=1:size(X_test,1)
 if test(i) == result(i)
 if test(i) == 1
     TT=TT+1;
 else
     FF = FF+1;
 end
 else
     if test(i) == 1 & result(i)==0
         TF=TF+1;
     else
     FT=FT+1;
     end
 end
end
%AUC

auc=FT+TF;
perc_auc=auc/size(X_test,1);
end

%feature value seection
%for y=1:size(featvales,1)
% for i=1:size(x,2)
%     if x(i)==0
%         temp=horzcat(temp(1:end,1:i-1),temp(1:end,i+1:end));
%     end
% end
%end

%svm training and testing

