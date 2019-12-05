% 爬取信息
NAME     = {};  % 小区名
DISTRICT = {};  % 区域名
AREA     = {};  % 行政区名
PRICE    = [];  % 价格
for i = 1 : 50
    str      = urlread(['https://hf.anjuke.com/community/p',num2str(i),'/']);
    clc; fprintf('%d\n',i);
    name     = regexp(str,'(?<=<a hidefocus="true" target="_blank" alt=").*?(?=")','match');
    address  = regexp(str,'(?<=<address>).*?(?=</address>)','match');
    district = cell(size(address));
    area     = cell(size(address));
    for i = 1 : length(address)
        district(i) = regexp(address{i},'(?<=［).*?(?=-)','match');
        area(i)     = regexp(address{i},'(?<=-).*?(?=］)','match');
    end
    price    = str2double(regexp(str,'(?<=<strong>).*?(?=</strong>)','match'));
    NAME     = [NAME,name];
    DISTRICT = [DISTRICT,district];
    AREA     = [AREA,area];
    PRICE    = [PRICE,price];
end
% 排序
uniD = unique(DISTRICT);
Data = cell(length(uniD),2);
for i = 1 : length(uniD)
    Data{i,1} = uniD{i};
    uniA      = unique(AREA(strcmp(uniD{i},DISTRICT)));
    Data{i,2} = cell(length(uniA),2);
    for j = 1 : length(uniA)
        Data{i,2}{j,1} = uniA{j};
        Data{i,2}{j,2} = find(strcmp(uniA{j},AREA));
        [~,rank] = sort(PRICE(Data{i,2}{j,2}),'descend');
        Data{i,2}{j,2} = Data{i,2}{j,2}(rank);
    end
    [~,rank]  = sort(PRICE(cellfun(@(S)S(1),Data{i,2}(:,2))),'descend');
    Data{i,2} = Data{i,2}(rank,:);
end
[~,rank] = sort(PRICE(cellfun(@(S)S{1,2}(1),Data(:,2))),'descend');
% 写入Excel
Index = [];
for i = rank
    for j = 1 : size(Data{i,2},1)
        Index = [Index,Data{i,2}{j,2}];
    end
end
xlswrite('my.xlsx',[DISTRICT(Index);AREA(Index);NAME(Index);num2cell(PRICE(Index))]');