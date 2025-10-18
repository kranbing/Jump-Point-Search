function flag = isObstacle(coor,obstacle)
% 判断给定节点是否是障碍物  v2022.3.1 by jubobolv
% 输入参数：1.coor 给定节点 2.obstacle 障碍物集
 flag=0;
 for j = 1:length(obstacle(:,1))
    if isequal(coor,obstacle(j,:))
        flag=1;
        break
    end
 end
end

