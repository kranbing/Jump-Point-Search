function [node,forcedNeigh]=article_jump(pre_node,dir,start,goal,obstacle)
% 判断pre_node沿dir方向是否有跳点  v.2022.3.1 by jubobolv
% 输入参数 1.pre_node 上一个节点 2.dir 从上个节点寻找跳点的方向 3.start 起点 4.goal 目标点 5.obstacle 障碍物集
% 输出参数 1.node 跳点坐标 2.forcedNeigh 强迫邻居

    % 强迫邻居
    forcedNeigh=[];
    % 如果当前方向为直线方向 dir方向下一节点的g_cost加10 否则为斜线方向 dir方向下一节点的g_cost加14
    if abs(dir(1))+abs(dir(2)) == 1
        node=pre_node+[dir(1),dir(2),10];
    else
        node=pre_node+[dir(1),dir(2),14];
    end
    % 如果当前方向的下一节点是障碍物 则当前方向不存在跳点 结束寻找
    if isObstacle(node(1,1:2),obstacle)
        node=[];
        return
    end
     % 如果当前方向的下一节点是目标点 结束寻找
    if isequal(node(1,1:2) , goal)
        return
    end
    % 寻找当前方向的下一节点的强迫邻居 判断是否有
    [flag,forcedNeigh]=hasForcedNeigh(node(:,1:2),pre_node(:,1:2),start,goal,obstacle);
    % 如果有强迫邻居则返回该节点和其强迫邻居 该强迫邻居为当前节点的强迫邻居 结束寻找
    if flag 
        return 
    end
    %如果当前方向为斜向 则在斜向的两个分直线方向分别寻找跳点 如果寻找到了则返回该节点 结束寻找
    if abs(dir(1))+abs(dir(2)) == 2
        for i=1:2
             if i==1   %竖直方向
                new_dir=[0,dir(2)];
             else      %水平方向                
                new_dir =[dir(1),0];
             end
             %在直线方向寻找跳点 如果有跳点说明当前节点跳点 达到终止条件 停止寻找
             [new_node,~]=article_jump(node,new_dir,start,goal,obstacle);
             if ~isequal(  new_node , [])
                 return
             end
        end
    end
% 以上为找到 则递归寻找    
[node,~]=article_jump(node,dir,start,goal,obstacle);
end