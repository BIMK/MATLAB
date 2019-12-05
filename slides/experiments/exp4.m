% KNN
X = rand(100,2)*2-1;                             % 每行一个训练样本,每列一个特征
Y = sum(X,2) > randn(100,1)/10;                  % 每行一个标签
k = 3;                                           % k近邻参数
[p1,p2]  = meshgrid(-1:0.01:1);                  % 用于绘制分类面的测试样本
[~,rank] = sort(pdist2([p1(:),p2(:)],X),2);      % 确定离每个测试样本最近的训练样本
[~,Y1]   = max(hist(Y(rank(:,1:k))',[0 1]),[],1);% 确定每个测试样本的标签
figure; hold on; box on;                        % 绘制训练样本分类面
plot(X(Y,1),X(Y,2),'ok','MarkerFaceColor','b');
plot(X(~Y,1),X(~Y,2),'ok','MarkerFaceColor','r');
contour(p1,p2,reshape(Y1-1,size(p1)),1);

% K-means
X = rand(300,2);                    % 每行一个样本,每列一个特征
X(sum(X.^2,2)>0.5&sum((1-X).^2,2)>0.5,:) = [];
k = 2;                              % k-means参数
C = X(randperm(end,k),:);           % 初始中心点
for i = 1 : 100                     % 重复迭代100次
    [~,Y] = min(pdist2(X,C),[],2);  % 确定离每个样本最近的中心点
    C = cell2mat(arrayfun(@(j)mean(X(Y==j,:),1),1:k,'UniformOutput',false)'); % 更新每个中心点
end
figure; hold on; box on;         	% 绘制聚类结果
arrayfun(@(j)plot(X(Y==j,1),X(Y==j,2),'ok','MarkerFaceColor',rand(1,3)),1:k);
