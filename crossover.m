function [childPath] = crossover(parent1Path, parent2Path, prob)
% 交叉
 
    random = rand();
    if prob >= random                     %行：随机生成一个01之前的数，和概率值比较，相当于一个轮盘赌的选择，来执行概率选择执行操作
        [l, length] = size(parent1Path);
        childPath = zeros(l,length);
        setSize = floor(length/2) -1;     %行：floor 朝负无穷大方向取整
        offset = randi(setSize);          %行：随机 产生1-setSize之间的整数
        parent1OXstart=offset;            %行：0X交叉，父代1遗传给子代的片段起点
        parent1OXend=setSize+offset-1;    %行：0X交叉，父代1遗传给子代的片段终点
        
        for i=parent1OXstart:parent1OXend
            childPath(1,i) = parent1Path(1,i);
        end
        
        childPath(1,1) = parent1Path(1,1);%行：将路径的起点和终点直接赋给子代，因为起点和终点不变
        childPath(1,length) = parent1Path(1,length);
        
        %行：parent2依顺序放入子代位坐标
        parent2Point=2;                
        for x=2:length-1
            if childPath(1,x)==0
                for y=parent2Point:length-1
                    if ~any(childPath == parent2Path(1,y))%行：如果子代路径相应元素不等于父代元素
                        childPath(1,x)=parent2Path(1,y);
                        parent2Point=y+1;
                        break;
                    end
                end
            end
        end
        
    else
        childPath = parent1Path;
    end
end