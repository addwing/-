function [ bestPopPath ] = paint( cities, pop, minPath, totalDistances,gen)
    gNumber=gen;
    [~, length] = size(cities);
    xDots = cities(1,:);
    yDots = cities(2,:);
    %figure(1);
    %�У��Ȼ����еĹ̶�����
    plot(xDots,yDots, 'p', 'MarkerSize', 10, 'MarkerFaceColor', 'green');
    xlabel('����');
    ylabel('γ��');
    axis equal
    
    [num,txt,raw]=xlsread('provincial_ capital_coordinate12.xlsx');  %��γ������% 
     text(xDots(1)+0.2,yDots(1)+0.2,txt(1+1,2),'FontSize',9.5,'Color','red','FontWeight','Bold') ; %�Ȼ���㣬ͻ�����
    for i=2:length-1
        text(xDots(i)+0.2,yDots(i)+0.2,txt(i+1,2),'FontSize',8,'Color','blue','FontWeight','Bold') ; %����0.01ʹ��ź͵㲻�غϣ������Լ�����
    end
    
    
    
    hold on
    [minPathX,~] = find(totalDistances==minPath,1, 'first');
    bestPopPath = pop(minPathX, :);
    bestX = zeros(1,length);
    bestY = zeros(1,length);
    for j=1:length
       bestX(1,j) = cities(1,bestPopPath(1,j));
       bestY(1,j) = cities(2,bestPopPath(1,j));
    end
   % title('��ǰ����%d ��·��ͼ');
    title(['��', num2str(gNumber),'����Ⱥ������·��ͼ']) ;
    %�У��ٻ����е�·������
    plot(bestX(1,:),bestY(1,:), 'red', 'LineWidth', 1.25);
    legend('����', '·��');
    axis equal%�У�axis equal/����������Ķ���ϵ�������ֵͬ��
    grid on
    %text(5,0,sprintf('��������: %d ��·������: %.2f',gNumber, minPath),'FontSize',10);
    drawnow
    hold off
end