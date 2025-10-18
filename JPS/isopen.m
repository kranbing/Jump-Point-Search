function [isopenFlag,Id] = isopen(goal,openlist)
%判断目标点是否在openlist列表中，在openlist中，isopenFlag = 1,不在open中，isopenFlag = 0 .并反回索引号 v2022.3.1 by jubobolv
% 输入参数：1.goal 目标节点 2.openlist
% 输出函数：1.isopenFlag 是否在openlist列表中标签 2.Id 在openlist列表中的索引
    isopenFlag = 0;
    Id = 0;%初始化
    if  isempty(openlist)%如果open列表为空，则不在open列表中
        isopenFlag = 0;
    else %open列表不为空时
        for i = 1:length(openlist(:,1))%列表中有多少个坐标就循环多少次
           if isequal(goal(1:2),openlist(i,1:2))%在Openlist中
                isopenFlag = 1;
                Id = i;
                return;
           end 
        end
    end
end
