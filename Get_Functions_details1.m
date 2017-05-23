function [lb,ub,dim,fobj] = Get_Functions_details1(F)


switch F
    case 'im'
        fobj = @im;
        lb=0;
        ub=1;
        dim=1000;
end

end

% F1

function auc = im(x,featvales,label)
for i=1:size(x,2)
    if x(i)>0.4
        x1(i)=1;
    else
        x1(i)=0;
    end
end
% if x
auc=proc(x1,featvales,label);
% end
end
