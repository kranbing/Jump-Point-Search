function Plot_Grid(map)
% 绘制栅格和起始点 v2022.3.1 by jubobolv
% 输入参数：1.map 地图信息 该函数主要调用地图的X、Y最大值

for i = 1:map.Y+3  %在地图周围有一圈围墙，所以是地图大小+3
   line([-0.5,map.X+1.5],[i-1.5,i-1.5],'color',[0.5,0.5,0.5]);%划线，重点是line函数的参数用法 水平线
end
for j = 1:map.X+3
   line([j-1.5,j-1.5],[-0.5,map.Y+1.5],'color',[0.5,0.5,0.5]);     %竖线
end
plot(map.start(1),map.start(2),'og','MarkerSize',15,'LineWidth',3);%画出起点圈圈
hold on;
plot(map.goal(1),map.goal(2),'or','MarkerSize',15,'LineWidth',3);%画出目标点圈圈
axis([-0.5,map.X+1.5,-0.5,map.Y+1.5]);%设置坐标轴
axis equal;
end


