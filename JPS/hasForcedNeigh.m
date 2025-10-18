function [flag,forcedNeigh] = hasForcedNeigh(node,pre_node,start,goal,obstacle)
%判断是否有强迫邻居 有flag=1 无flag=0   v.2022.3.1 by jubobolv
% 输入参数 1.node 当前节点 2.pre_node 上一个节点 3.start 起点 4.goal 目标点 5.obstacle 障碍物集
% 输出参数 1.flag 是否有标签 2.forcedNeigh 强迫邻居
    %当前节点邻居中是否有障碍物，如果没有则返回False 如果有判断是否有强迫邻居
    flag=0;
    forcedNeigh=[];
    %若为起点或终点 不考虑强迫邻居  否则按照从 横竖-->对角 方向 开始寻找
    if isequal(node,start)
        return
    elseif isequal(node,goal)
        return
    else
        if (abs(node(1)-pre_node(1))+abs(node(2)-pre_node(2))) == 1 %直线移动
            if(node(2)-pre_node(2))==1  %竖直向上移动
                if isObstacle([node(1)-1,node(2)],obstacle) &&  ~isObstacle([node(1)-1,node(2)+1],obstacle)%左侧是障碍 左前不是障碍物
                    flag=1;
                    forcedNeigh=[node(1)-1,node(2)+1];
                end
                if isObstacle([node(1)+1,node(2)],obstacle) &&  ~isObstacle([node(1)+1,node(2)+1],obstacle)%右侧是障碍 右前不是障碍物
                    flag=1;
                    forcedNeigh=[node(1)+1,node(2)+1;forcedNeigh];
                end
             elseif (node(2)-pre_node(2)) == -1  %竖直向下移动
                 if isObstacle([node(1)+1,node(2)],obstacle) &&  ~isObstacle([node(1)+1,node(2)-1],obstacle)%左侧是障碍 左前不是障碍物
                    flag=1;
                    forcedNeigh=[node(1)+1,node(2)-1];
                 end
                 if isObstacle([node(1)-1,node(2)],obstacle) &&  ~isObstacle([node(1)-1,node(2)-1],obstacle)%右侧是障碍 右前不是障碍物
                    flag=1;
                    forcedNeigh=[node(1)-1,node(2)-1;forcedNeigh];
                 end 
             elseif (node(1)-pre_node(1)) == 1  %水平向右移动
                 if isObstacle([node(1),node(2)+1],obstacle) &&  ~isObstacle([node(1)+1,node(2)+1],obstacle)%左侧是障碍 左前不是障碍物
                    flag=1;
                    forcedNeigh=[node(1)+1,node(2)+1];
                 end
                 if isObstacle([node(1),node(2)-1],obstacle) &&  ~isObstacle([node(1)+1,node(2)-1],obstacle)%右侧是障碍 右前不是障碍物
                    flag=1;
                    forcedNeigh=[node(1)+1,node(2)-1;forcedNeigh];
                 end 
            elseif (node(1)-pre_node(1)) == -1  %水平向左移动
                 if isObstacle([node(1),node(2)-1],obstacle) &&  ~isObstacle([node(1)-1,node(2)-1],obstacle)%左侧是障碍 左前不是障碍物
                    flag=1;
                    forcedNeigh=[node(1)-1,node(2)-1];
                 end
                 if isObstacle([node(1),node(2)+1],obstacle) &&  ~isObstacle([node(1)-1,node(2)+1],obstacle)%右侧是障碍 右前不是障碍物
                    flag=1;
                    forcedNeigh=[node(1)-1,node(2)+1;forcedNeigh];
                 end
            end
        else       %% 对角运动
            if node(1)-pre_node(1) == 1 && node(2) - pre_node(2) ==1  %斜向右上
                if isObstacle([node(1)-1,node(2)],obstacle) &&  ~isObstacle([node(1)-1,node(2)+1],obstacle)%左侧是障碍 左上不是障碍物
                    flag=1;
                    forcedNeigh=[node(1)-1,node(2)+1];
                end
                if isObstacle([node(1),node(2)-1],obstacle) &&  ~isObstacle([node(1)+1,node(2)-1],obstacle)%右侧是障碍 右下不是障碍物
                    flag=1;
                    forcedNeigh=[node(1)+1,node(2)-1;forcedNeigh];
                end
            elseif node(1)-pre_node(1) == -1 && node(2) - pre_node(2) ==1  %斜向左上
                 if isObstacle([node(1),node(2)-1],obstacle) &&  ~isObstacle([node(1)-1,node(2)-1],obstacle)%左侧是障碍 左下不是障碍物
                    flag=1;
                    forcedNeigh=[node(1)-1,node(2)-1];
                 end
                 if isObstacle([node(1)+1,node(2)],obstacle) &&  ~isObstacle([node(1)+1,node(2)+1],obstacle)%右侧是障碍 右上不是障碍物
                    flag=1;
                    forcedNeigh=[node(1)+1,node(2)+1;forcedNeigh];
                 end
              elseif node(1)-pre_node(1) == -1 && node(2) - pre_node(2) == -1  %斜向左下
                 if isObstacle([node(1)+1,node(2)],obstacle) &&  ~isObstacle([node(1)+1,node(2)-1],obstacle)%左侧是障碍 右下不是障碍物
                    flag=1;
                    forcedNeigh=[node(1)+1,node(2)-1];
                 end
                 if isObstacle([node(1),node(2)+1],obstacle) &&  ~isObstacle([node(1)-1,node(2)+1],obstacle)%右侧是障碍 右前不是障碍物
                    flag=1;
                    forcedNeigh=[node(1)-1,node(2)+1;forcedNeigh];
                 end 
              elseif node(1)-pre_node(1) == 1 && node(2) - pre_node(2) == -1  %斜向右下
                  if isObstacle([node(1),node(2)+1],obstacle) &&  ~isObstacle([node(1)+1,node(2)+1],obstacle)%左侧是障碍 右上不是障碍物
                    flag=1;
                    forcedNeigh=[node(1)+1,node(2)+1];
                  end
                  if isObstacle([node(1)-1,node(2)],obstacle) &&  ~isObstacle([node(1)-1,node(2)-1],obstacle)%右侧是障碍 左下不是障碍物
                    flag=1;
                    forcedNeigh=[node(1)-1,node(2)-1;forcedNeigh];
                  end 
             end
        end
    end
end

