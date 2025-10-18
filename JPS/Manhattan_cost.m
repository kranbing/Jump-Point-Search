function cost =Manhattan_cost(node,goal)
%计算启发函数代价值 ，这里采用曼哈顿算法 v2022.3.1 by jubobolv
% 输入参数：1.node 当前节点 2.目标节点
% 输出参数：1.当前节点到目标节点的曼哈顿距离
cost=10*abs(node(1)-goal(1))+10*abs(node(2)-goal(2));
end

