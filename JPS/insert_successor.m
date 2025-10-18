function openlist = insert_successor(successor,openlist)
%插入successor到openlist 检测是否已经存在 然后进行插入  v.2022.3.1 by jubobolv
% 输入参数 1.successor待插入的跳点 2.openlist 
% 思路：  在openlist中查找successor，如果可以找到，比较其f_cost，
%           若successor的f_cost大于相等  则不插入，否则将successor更新至openlist
%         如果找不到 直接插入
    flag=0;
    % 在openlist中查找successor
    for i=1:length(openlist(:,1))
        % 如果可以找到
        if isequal(successor(1,1:2),openlist(i,1:2))
            % 比较其f_cost 若successor的f_cost小 将successor更新至openlist
            if successor(1,6) < openlist(i,6)   
                openlist(i,:)=successor;
                return
            else %若successor的f_cost大于相等已存在的  则不插入
                flag=1;
            end
        else
            continue
        end
    end

    if flag  %若successor的f_cost大于相等已存在的  则不插入
        return
    else    %不存在则插入
        openlist=[openlist;successor];
    end
end