% 创建窗口
fig = figure('MenuBar','none','ToolBar','none','NumberTitle','off','Position',[0 0 300 300]);
movegui(fig,'center');
% 随机生成标签
label = randi([0 9],10,10);
% 创建按钮
for x = 1 : 10
    for y = 1 : 10
        button(x,y) = uicontrol('Style','togglebutton','Units','Normalized','Position',[(x-1)/10 (y-1)/10 .1 .1],'String',num2str(label(x,y)),'FontSize',18);
    end
end
% 设置每个按钮的回调函数
for x = 1 : 10
    for y = 1 : 10
        button(x,y).Callback = @(~,~)CB(button);
    end
end
% 回调函数内容
function CB(button)
    loc = [];
    for x = 1 : 10
        for y = 1 : 10
            if button(x,y).Value
                loc = [loc;x,y];
            end
        end
    end
    map = false(12,12);
    map(2:end-1,2:end-1) = arrayfun(@(h)strcmp(h.Visible,'on'),button);
    if size(loc,1) >= 2
        if strcmp(button(loc(1,1),loc(1,2)).String,button(loc(2,1),loc(2,2)).String)
            connect = isConnected(map,loc(1,1)+1,loc(1,2)+1,loc(2,1)+1,loc(2,2)+1);
        else
            connect = false;
        end
        button(loc(1,1),loc(1,2)).Value = 0;
        button(loc(2,1),loc(2,2)).Value = 0;
        if connect
            button(loc(1,1),loc(1,2)).Visible = 'off';
            button(loc(2,1),loc(2,2)).Visible = 'off';
        end
    end
end
% 判断是否可达
function connect = isConnected(map,x1,y1,x2,y2)
    connect    = false;
    map(x1,y1) = false;
    map(x2,y2) = false;
    % 从上下出发
    for i = 1 : size(map,2)
        if ~any(map(x1,min(i,y1):max(i,y1))) && ~any(map(min(x1,x2):max(x1,x2),i)) && ~any(map(x2,min(i,y2):max(i,y2)))
            connect = true;
            return;
        end
    end
    % 从左右出发
    for i = 1 : size(map,1)
        if ~any(map(min(i,x1):max(i,x1),y1)) && ~any(map(i,min(y1,y2):max(y1,y2))) && ~any(map(min(i,x2):max(i,x2),y2))
            connect = true;
            return;
        end
    end
end