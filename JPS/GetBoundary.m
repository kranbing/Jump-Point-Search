function obstacle = GetBoundary(map)
% 获取地图边界，将地图边界加入障碍物集 v2022.3.1 by jubobolv
% 输入参数：1.map 地图信息 该函数主要调用地图的X、Y最大值
% 输出参数：1.obstacle 障碍物集
    obstacle=[];
    for i1=0:(map.X+1)
        obstacle=[obstacle;[i1,0]];        %地图下底边
    end
    for i2=1:(map.Y+1)
        obstacle=[obstacle;[map.X+1,i2]];  %地图右侧边
    end
    for i3=0:(map.X)
        obstacle=[obstacle;[i3,map.Y+1]];  %地图上底边
    end
    for i4=1:(map.Y)
        obstacle=[obstacle;[0,i4]];        %地图左侧边
    end
end

