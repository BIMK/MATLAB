% KNN
X = rand(100,2)*2-1;                             % ÿ��һ��ѵ������,ÿ��һ������
Y = sum(X,2) > randn(100,1)/10;                  % ÿ��һ����ǩ
k = 3;                                           % k���ڲ���
[p1,p2]  = meshgrid(-1:0.01:1);                  % ���ڻ��Ʒ�����Ĳ�������
[~,rank] = sort(pdist2([p1(:),p2(:)],X),2);      % ȷ����ÿ���������������ѵ������
[~,Y1]   = max(hist(Y(rank(:,1:k))',[0 1]),[],1);% ȷ��ÿ�����������ı�ǩ
figure; hold on; box on;                        % ����ѵ������������
plot(X(Y,1),X(Y,2),'ok','MarkerFaceColor','b');
plot(X(~Y,1),X(~Y,2),'ok','MarkerFaceColor','r');
contour(p1,p2,reshape(Y1-1,size(p1)),1);

% K-means
X = rand(300,2);                    % ÿ��һ������,ÿ��һ������
X(sum(X.^2,2)>0.5&sum((1-X).^2,2)>0.5,:) = [];
k = 2;                              % k-means����
C = X(randperm(end,k),:);           % ��ʼ���ĵ�
for i = 1 : 100                     % �ظ�����100��
    [~,Y] = min(pdist2(X,C),[],2);  % ȷ����ÿ��������������ĵ�
    C = cell2mat(arrayfun(@(j)mean(X(Y==j,:),1),1:k,'UniformOutput',false)'); % ����ÿ�����ĵ�
end
figure; hold on; box on;         	% ���ƾ�����
arrayfun(@(j)plot(X(Y==j,1),X(Y==j,2),'ok','MarkerFaceColor',rand(1,3)),1:k);
