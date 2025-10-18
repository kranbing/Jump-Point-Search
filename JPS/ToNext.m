function next_coor = ToNext()
%节点周围8个节点的坐标变化量和曼哈顿距离 v2022.3.1 by jubobolv
% 输入参数：null
next_coor=[0 1 10;      %上
           0 -1 10;     %下
           -1 0 10;     %左
           1 0 10;      %右
           -1 1 14;     %左上
           1 1 14;      %右上
           -1 -1 14;    %左下
           1 -1 14;];   %右下
end

