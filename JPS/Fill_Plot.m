function Fill_Plot(coord,color,tp)
% 填充坐标栅格  v2022.3.1 by jubobolv
% 输入参数：1.coord 坐标点集 2.color 填充颜色 3.tp 填充透明度
% 输出参数：无
    for i=1:length(coord(:,1))
        fill([coord(i,1)-0.5,coord(i,1)+0.5,coord(i,1)+0.5,coord(i,1)-0.5],...
            [coord(i,2)-0.5,coord(i,2)-0.5,coord(i,2)+0.5,coord(i,2)+0.5],color,'EdgeColor','none','FaceAlpha',tp);
        hold on
    end
    set(gca,'FontSize',40,'Fontname', 'Times New Roman');%设置字体以及字号
    set(gca,'XTick',0:5:20);
    set(gca,'YTick',0:5:20);%设置坐标轴刻度
    axis tight  
    
end