function obstacle = GetObstacles(obstacle,map)
%设置地图中的障碍物 v2022.3.1 by jubobolv
% 输入参数：1.obstacle 未加障碍物前的障碍物集 2.map 留用
% 输出参数：1.obstacle 加入障碍物后障碍物集
    new_ob=[1 9;
            2,9;];
    for i=2:9
        new_ob=[new_ob;[5,i]];
    end
    for i=8:12
        new_ob=[new_ob;[i,7]];
    end
    for i=1:4
        new_ob=[new_ob;[16,i]];
    end
    for i=14:20
        new_ob=[new_ob;[i,11]];
    end
    for i=5:8
        new_ob=[new_ob;[13,i]];
        new_ob=[new_ob;[i,13]];
    end
    for i=15:18
        new_ob=[new_ob;[11,i]];
    end
    for i=1:3
        new_ob=[new_ob;[11,i]];
    end
    new_ob=[new_ob;[10,3]];
    new_ob=[new_ob;[6,18]];
    new_ob=[new_ob;[6,19]];
    new_ob=[new_ob;[6,20]];
    new_ob=[new_ob;[13,13]];
    new_ob=[new_ob;[14,15]];

     obstacle=[obstacle;new_ob];
 end

