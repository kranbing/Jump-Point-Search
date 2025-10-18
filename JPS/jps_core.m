function [openlist,closelist] = jps_core(openlist,closelist,start,goal,obstacle)
%   jps计算 v2022.3.1 by jubobolv
%   输入参数 1.openlist 加入了起点的openlist; 2.closelist 为空; 3.start 起始节点坐标； 4.goal 目标节点坐标； 5.obstacle 障碍物点集合；
%   输出参数 1.openlist 通过计算最终得到的openlist集合   2.closelist 从起点到目标节点最优路径节点集合

%任意节点周围8个邻居节点 依次为上 下 左 右 左上 右上 左下 右下
    next=ToNext();

    %起点的8个方向找跳点 因为是起点 所以在每个方向都寻找跳点
    for i=1:8
        %起点作为父节点
        father_node=openlist(1,1:3);

        %从父节点到当前邻居节点的方向
        dir=next(i,1:2);
        %判断从父节点到按d方向到当前邻居节点是否有跳点
        [jump_point,~]=article_jump(father_node,dir,start,goal,obstacle);
        %若有跳点 将跳点加入到openlist中
        if ~isequal(jump_point,[]) %当时忘了可以这样判断--->~isempty(jump_point)  懒得改了 ^_^  
            % 将jump_point加入到openlist中 先将其格式化
            % 格式为：jump_point_x|junmp_point_y|g_cost|direction|f_cost|father_node_x|father_node_y
            successor=[jump_point(1),jump_point(2),jump_point(3),dir,jump_point(3)+...
                Manhattan_cost(jump_point(1,1:2),goal),father_node(1),father_node(2)];
            %将跳点插入openlist中
            openlist = insert_successor(successor,openlist);
        end
    end
    %起点周围跳点寻找完成 将起点（即openlist中此时的第一行）加入 closelist
    closelist=[openlist(1,1:3),openlist(1,7:8);closelist];
    % 从openlist中删除起点
    openlist(1,:)=[];
    
    %% while循环寻找到终点的路径
    findFlag=false;     %用于判断while循环是否结束的标签
    while ~findFlag
        %如果openlist为空 则没有路径 结束
        if isempty(openlist(:,1))
            disp('No path to goal!!');
            return;
        end
         %判断目标点是否出现在openlist列表中，如果在返回在openlist中的行索引
        [isopenFlag,Id]=isopen(goal,openlist);
        if isopenFlag
            disp('Find Goal!!');
            toc      %计时结束
            %将目标点加入closelist
            closelist = insert_closelist(openlist(Id,:),closelist);
            openlist(Id,:)=[];
            findFlag=true;
            %结束循环
            break;
        end
        [~,I]=sort(openlist(:,6)); %对OpenList按第6列（f_cost值）排序,该步骤获取每行按升序排序后的名次矩阵
        openlist=(openlist(I,:));%将每行重新按升序排序
        %---------------------以下：如果openlist里有f_cost相等的点,进行取舍----------ps.合理性待测试----------%
        %如果openlist有多行数据
        if length(openlist(:,1))>1
            %如果排序后的openlist中前两行的f_cost值相等 根据距离目标值的横纵距离排序 距离大的换到openlist第一行 作为选取的节点
            if isequal(openlist(1,6),openlist(2,6))
                dist1=abs(openlist(1,1)-goal(1))+abs(openlist(1,2)-goal(2));
                dist2=abs(openlist(2,1)-goal(1))+abs(openlist(2,2)-goal(2));
                dist_big=dist1;
                if dist1 < dist2  %将与目标点横纵距离大的点换到openlist第一行 作为选取的节点
                    temp=openlist(2,:);
                    openlist(2,:)=[];
                    openlist=[temp;openlist];
                    dist_big=dist2;
                end
                %比较openlist中其他行是否还有f_cost与第一行相同的点 如果有继续调整
                for j = 3:length(openlist(:,1))
                    if isequal(openlist(1,6),openlist(j,6))
                        dist=abs(openlist(j,1)-goal(1))+abs(openlist(j,2)-goal(2));
                        if dist_big < dist
                            temp=openlist(j,:);
                            openlist(j,:)=[];
                            openlist=[temp;openlist];
                            dist_big=dist;
                        end
                    end
                end
            end      
        end
         %----------------------------以上：如果openlist里有f_cost相等的点,进行取舍---------------------------%
        
        %从排序后的openlist中弹出第一行（即f_cost最小的点） 获取最后将其加入时的方向和父节点
        dir=openlist(1,4:5);
        father_node=openlist(1,1:3);
        
        %如果从opnelist中弹出的方向是斜向 说明上一次斜向找到了跳点但未完成斜向所有节点 需要继续该方向的跳点寻找
        %由于上一次找到该跳点是斜向 说明在其直线方向的分方向存在着有强迫邻居的跳点 故先将其找出来并加入到openlist
        if abs(dir(1))+abs(dir(2)) == 2
            for i=1:2
                if i==1    %竖直方向
                    new_dir=[0,dir(2)];
                 else      %水平方向                
                    new_dir =[dir(1),0];
                 end
                 [new_node,~]=article_jump(father_node,new_dir,start,goal,obstacle);
                 if ~isequal(new_node ,[])
                     successor=[new_node,new_dir,new_node(3)+Manhattan_cost(new_node(1,1:2),goal),...
                                father_node(1),father_node(2)];
                     openlist = insert_successor(successor,openlist);
                 end
            end
        else 
           %从opnelist中弹出的方向是直线，先直线寻找跳点，搜索到了就加入openlist;
           [jump_point,~]=article_jump(father_node,dir,start,goal,obstacle);
           if ~isequal(jump_point,[])%~isempty(jump_point)
               successor=[jump_point,dir,jump_point(3)+Manhattan_cost(jump_point(1,1:2),goal),...
                          father_node(1),father_node(2)];
                openlist = insert_successor(successor,openlist);
           end    
        end
        
        %判断从opnelist中弹出节点，沿其最后被加入的方向是否有强迫邻居 如果有 将其加入到openlist
        [flag,forcedNeigh]=hasForcedNeigh(father_node(1,1:2),father_node(1,1:2)-dir,start,goal,obstacle);
       if flag
          % 找到的所有的forcedNeigh加入到openlist
          for i=1:length(forcedNeigh(:,1))
              new_dir=forcedNeigh(i,:)-father_node(1,1:2);
              successor=[forcedNeigh(i,:),father_node(3)+14,new_dir,father_node(3)+14+Manhattan_cost(forcedNeigh(i,:),goal),...
                         father_node(1),father_node(2)]; 
              openlist = insert_successor(successor,openlist);
          end
       end
        %继续沿从opnelist中的方向向前寻找跳点
        [jump_point,~]=article_jump(father_node,dir,start,goal,obstacle);
        %如果存在则更新从opnelist中弹出的点到closelist中 并将其从openlist中删除 将本次找到的跳点插入到openlist
        if ~isequal(jump_point,[])      %当时忘了可以这样判断--->~isempty(jump_point)  懒得改了 ^_^          
            successor=[jump_point,dir,jump_point(3)+Manhattan_cost(jump_point(1,1:2),goal),...
                       father_node(1),father_node(2)];
            
            closelist = insert_closelist(openlist(1,:),closelist);
            openlist(1,:)=[];
            openlist = insert_successor(successor,openlist);
        else   %如果不存在则更新从opnelist中弹出的点到closelist中 并将其从openlist中删除
            closelist = insert_closelist(openlist(1,:),closelist);
            openlist(1,:)=[]; 
        end
    end
end


