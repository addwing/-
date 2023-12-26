function [childPath] = crossover(parent1Path, parent2Path, prob)
% ����
 
    random = rand();
    if prob >= random                     %�У��������һ��01֮ǰ�������͸���ֵ�Ƚϣ��൱��һ�����̶ĵ�ѡ����ִ�и���ѡ��ִ�в���
        [l, length] = size(parent1Path);
        childPath = zeros(l,length);
        setSize = floor(length/2) -1;     %�У�floor �����������ȡ��
        offset = randi(setSize);          %�У���� ����1-setSize֮�������
        parent1OXstart=offset;            %�У�0X���棬����1�Ŵ����Ӵ���Ƭ�����
        parent1OXend=setSize+offset-1;    %�У�0X���棬����1�Ŵ����Ӵ���Ƭ���յ�
        
        for i=parent1OXstart:parent1OXend
            childPath(1,i) = parent1Path(1,i);
        end
        
        childPath(1,1) = parent1Path(1,1);%�У���·���������յ�ֱ�Ӹ����Ӵ�����Ϊ�����յ㲻��
        childPath(1,length) = parent1Path(1,length);
        
        %�У�parent2��˳������Ӵ�λ����
        parent2Point=2;                
        for x=2:length-1
            if childPath(1,x)==0
                for y=parent2Point:length-1
                    if ~any(childPath == parent2Path(1,y))%�У�����Ӵ�·����ӦԪ�ز����ڸ���Ԫ��
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