clear;
clc;
tStart = tic; % �㷨��ʱ��
%************************��ʼ����������*******************************
    [Num,Txt,Raw]=xlsread('provincial_ capital_coordinate12.xlsx');  %��γ������% 
    cities = Num(:,5:6);
    cities=cities';
    [~,cityNum]=size(cities);
    
    
    maxGEN = 500;
    popSize = 300; % �Ŵ��㷨��Ⱥ��С
    crossoverProbabilty = 0.95; %�������
    mutationProbabilty = 0.33; %�������

    %********��ʼ����Ⱥ***********
    % �����������ɵĸ�������֮��ľ����
    distances = calculateDistance(cities);
    % ������Ⱥ��ÿ���������һ��·��
    gbest = Inf;%�У�Inf �����
    parentPop = zeros(popSize, cityNum);
    % ���������Ⱥ
    for i=1:popSize
     parentPop(i,2:cityNum-1) = randperm(cityNum-2); %randperm�������������һ���������У���1-cityNum���������������
     for a=2:cityNum-1
         parentPop(i,a)=parentPop(i,a)+1;
     end
     parentPop(i,1)=1;
     parentPop(i,cityNum)=cityNum;
    end
    % �����Ӵ���Ⱥ
    childPop = zeros(popSize,cityNum);
    
    %����ÿ������С·��
    minPathes = zeros(maxGEN,1);
    %****************************
  
%**********************************************************************

%*********************GA�㷨ѡ�񽻲����ִ�й���************************
for  genNum=1:maxGEN
 
    % ������Ӧ�ȵ�ֵ����·���ܾ���
    [fitnessValue, sumDistance, minPath, maxPath] = fitness(distances, parentPop);
    tournamentSize=4; %���ô�С
    for k=1:popSize
    %% ����Ϊ����ѡ��
        % ���ѡ�񸸴�
        tourPopDistances=zeros( tournamentSize,1);
        for i=1:tournamentSize
            randomRow = randi(popSize);%�У�����һ������1��popSize��α�������
            tourPopDistances(i,1) = sumDistance(randomRow,1);
        end
 
        % ѡ����õģ���������С��
        parent1  = min(tourPopDistances);
        [parent1X,parent1Y] = find(sumDistance==parent1,1, 'first');%ѡ�������4������̾�����Ⱥ���
        parent1Path = parentPop(parent1X(1,1),:);%%ѡ�������4������̾�����Ⱥ·��
 
 
        for i=1:tournamentSize
            randomRow = randi(popSize);
            tourPopDistances(i,1) = sumDistance(randomRow,1);
        end
        parent2  = min(tourPopDistances);
        [parent2X,parent2Y] = find(sumDistance==parent2,1, 'first');
        parent2Path = parentPop(parent2X(1,1),:);
    %% ����Ϊ����ѡ��
  
    %% ˳�򽻲棨OX��
        individual = crossover(parent1Path, parent2Path, crossoverProbabilty);%���彻��
    %%
  
    %% �Ի����죨����·�����ܳ����ظ�Ԫ�أ���˱��첻��Ϊ����仯����ʵ��������������Ԫ��λ����ʵ�ֱ��죩
        individual = mutate(individual, mutationProbabilty);%�������
    %%
        childPop(k,:) = individual(1,:);%�У�������һ����Ⱥ�ĸ���
        
        minPathes(genNum,1) = minPath; %�У������˴������·��
    end
    % ���¸���
    parentPop = childPop;%�У���Ⱥ��ʱ����Ϊ�����Ӵ�
    
    %% ��ͼ

    % ������ǰ״̬�µ����·��
    if minPath < gbest
        gbest = minPath;
        paint(cities, parentPop, gbest, sumDistance,genNum);%�У��������µ����·���켣
    end
    fprintf('����:%d   ���·��:%.2fKM \n', genNum,minPath);
  
%    fprintf('%s\n', Txt(Bestpath(1,0),2));
    %%
end

%% ������ɣ��������ս����ʾ
figure 
plot(minPathes, 'MarkerFaceColor', 'blue','LineWidth',1);
title({'���·����������ͼ';['���·������Ϊ', num2str(minPath)]});
set(gca,'ytick',0:10:450); 
ylabel('·���ܳ���');
xlabel('��Ⱥ����');
grid on
tEnd = toc(tStart);
fprintf('ʱ��:%d ��  %f ��.\n', floor(tEnd/60), rem(tEnd,60));
