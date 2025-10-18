clc;clear;close all
tic%计时开始
disp('JPS start!');
%% 绘基础图
map.X=20;%地图大小
map.Y=20;
map.start=[1 1];%起点
map.goal=[map.X-1 map.Y-1];%终点
obstacle=GetBoundary(map);%边界加入障碍物
obstacle=GetObstacles(obstacle,map);%生成障碍物
Fill_Plot(obstacle,'k',1)%填充障碍物
Plot_Grid(map)%绘制网格和起点、终点

%% JPS

%将起点加入openlist
% openlist的格式：jump_point_x|junmp_point_y|g_cost|direction_x|direction_y|f_cost|father_node_x|father_node_x
openlist=[map.start(1),map.start(2),0,0,0,Manhattan_cost(map.start,map.goal),0,0];
% closelist的格式：jump_point_x|junmp_point_y|g_cost|father_node_x|father_node_x
%初始化closelist
closelist=[];

%调用JPS核心代码
[openlist,closelist] = jps_core(openlist,closelist,map.start,map.goal,obstacle);


%% 绘制路径 openlist等
Fill_Plot(closelist,'y',0.5);           %黄色填充closelist
Fill_Plot(openlist,[0.3,0.9,0.8],1);    %淡蓝填充openlist
%将closelist中的节点x y坐标分别拿出 准备绘制路线
for pp=1:length(closelist(:,1))
    x = closelist(pp,1);
    y = closelist(pp,2);
    A(pp,1)=x;
    A(pp,2)=y;%这部分是将路径坐标拿出来另外存放
end

plot( A(:,1), A(:,2),'b','linewidth',4)   %绘制路线
    
k=0;%用于存放路径长度的变量
for i=1:length(closelist(:,1))-1
    b=10*sqrt(((closelist(i+1,1)-closelist(i,1))^2)+((closelist(i+1,2)-closelist(i,2))^2));%简单的两点间距离公式
    k=k+b;%路径长度值的逐个累加
end
disp(['路径长度为',num2str(k)]);
    