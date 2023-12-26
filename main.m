clear;
clc;
tStart = tic; % 算法计时器
%************************初始化参数变量*******************************
    [Num,Txt,Raw]=xlsread('provincial_ capital_coordinate12.xlsx');  %经纬度数据% 
    cities = Num(:,5:6);
    cities=cities';
    [~,cityNum]=size(cities);
    
    
    maxGEN = 500;
    popSize = 300; % 遗传算法种群大小
    crossoverProbabilty = 0.95; %交叉概率
    mutationProbabilty = 0.33; %变异概率

    %********初始化种群***********
    % 计算上述生成的各个城市之间的距离断
    distances = calculateDistance(cities);
    % 生成种群，每个个体代表一个路径
    gbest = Inf;%行：Inf 无穷大
    parentPop = zeros(popSize, cityNum);
    % 随机打乱种群
    for i=1:popSize
     parentPop(i,2:cityNum-1) = randperm(cityNum-2); %randperm功能是随机打乱一个数字序列，将1-cityNum数字序列随机打乱
     for a=2:cityNum-1
         parentPop(i,a)=parentPop(i,a)+1;
     end
     parentPop(i,1)=1;
     parentPop(i,cityNum)=cityNum;
    end
    % 定义子代种群
    childPop = zeros(popSize,cityNum);
    
    %定义每代的最小路径
    minPathes = zeros(maxGEN,1);
    %****************************
  
%**********************************************************************

%*********************GA算法选择交叉变异执行过程************************
for  genNum=1:maxGEN
 
    % 计算适应度的值，即路径总距离
    [fitnessValue, sumDistance, minPath, maxPath] = fitness(distances, parentPop);
    tournamentSize=4; %设置大小
    for k=1:popSize
    %% 以下为联赛选择法
        % 随机选择父代
        tourPopDistances=zeros( tournamentSize,1);
        for i=1:tournamentSize
            randomRow = randi(popSize);%行：返回一个介于1到popSize的伪随机整数
            tourPopDistances(i,1) = sumDistance(randomRow,1);
        end
 
        % 选择最好的，即距离最小的
        parent1  = min(tourPopDistances);
        [parent1X,parent1Y] = find(sumDistance==parent1,1, 'first');%选出随机的4个中最短距离种群序号
        parent1Path = parentPop(parent1X(1,1),:);%%选出随机的4个中最短距离种群路径
 
 
        for i=1:tournamentSize
            randomRow = randi(popSize);
            tourPopDistances(i,1) = sumDistance(randomRow,1);
        end
        parent2  = min(tourPopDistances);
        [parent2X,parent2Y] = find(sumDistance==parent2,1, 'first');
        parent2Path = parentPop(parent2X(1,1),:);
    %% 以上为联赛选择法
  
    %% 顺序交叉（OX）
        individual = crossover(parent1Path, parent2Path, crossoverProbabilty);%个体交叉
    %%
  
    %% 对换变异（由于路径不能出现重复元素，因此变异不能为随意变化，本实验采用随机交换两元素位置来实现变异）
        individual = mutate(individual, mutationProbabilty);%个体变异
    %%
        childPop(k,:) = individual(1,:);%行：保存下一代种群的个体
        
        minPathes(genNum,1) = minPath; %行：保留此代中最短路径
    end
    % 更新父代
    parentPop = childPop;%行：种群此时更新为最新子代
    
    %% 画图

    % 画出当前状态下的最短路径
    if minPath < gbest
        gbest = minPath;
        paint(cities, parentPop, gbest, sumDistance,genNum);%行：画出最新的最短路径轨迹
    end
    fprintf('代数:%d   最短路径:%.2fKM \n', genNum,minPath);
  
%    fprintf('%s\n', Txt(Bestpath(1,0),2));
    %%
end

%% 迭代完成，进行最终结果显示
figure 
plot(minPathes, 'MarkerFaceColor', 'blue','LineWidth',1);
title({'最短路径收敛曲线图';['最短路径距离为', num2str(minPath)]});
set(gca,'ytick',0:10:450); 
ylabel('路径总长度');
xlabel('种群代数');
grid on
tEnd = toc(tStart);
fprintf('时间:%d 分  %f 秒.\n', floor(tEnd/60), rem(tEnd,60));
