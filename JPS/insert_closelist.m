function closelist = insert_closelist(point,closelist)
%   将跳点插入到closelist
%   此处显示详细说明
flag=0;
point_temp=[point(1,1:3),point(1,7:8)];
for i = 1:length(closelist(:,1))
    if isequal(point(1,7:8),closelist(i,4:5))
        closelist(i,:)=point_temp;
        flag=1;
        break
    end
end
if flag
    return
else
    closelist=[point_temp;closelist];
end
end
