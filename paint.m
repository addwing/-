function [ bestPopPath ] = paint( cities, pop, minPath, totalDistances,gen)
    gNumber=gen;
    [~, length] = size(cities);
    xDots = cities(1,:);
    yDots = cities(2,:);
    %figure(1);
    %行：先画城市的固定坐标
    plot(xDots,yDots, 'p', 'MarkerSize', 10, 'MarkerFaceColor', 'green');
    xlabel('经度');
    ylabel('纬度');
    axis equal
    
    [num,txt,raw]=xlsread('provincial_ capital_coordinate12.xlsx');  %经纬度数据% 
     text(xDots(1)+0.2,yDots(1)+0.2,txt(1+1,2),'FontSize',9.5,'Color','red','FontWeight','Bold') ; %先画起点，突出起点
    for i=2:length-1
        text(xDots(i)+0.2,yDots(i)+0.2,txt(i+1,2),'FontSize',8,'Color','blue','FontWeight','Bold') ; %加上0.01使标号和点不重合，可以自己调整
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
   % title('当前代数%d 的路径图');
    title(['第', num2str(gNumber),'代种群的最优路径图']) ;
    %行：再画城市的路径连线
    plot(bestX(1,:),bestY(1,:), 'red', 'LineWidth', 1.25);
    legend('城市', '路径');
    axis equal%行：axis equal/将横轴纵轴的定标系数设成相同值。
    grid on
    %text(5,0,sprintf('迭代次数: %d 总路径长度: %.2f',gNumber, minPath),'FontSize',10);
    drawnow
    hold off
end