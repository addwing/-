function [ mutatedPath ] = mutate( path, prob )
%��ָ����·������ָ���ĸ��ʽ��и���
%�У�����·�������������ͬ���������Ա��첻������䣬ֻ�����������λ�õķ���
    random = rand();
    if random <= prob         
        [l,length] = size(path);
        index1 = randi([2,length-1]);
        index2 = randi([2,length-1]);
        %����
        temp = path(l,index1);
        path(l,index1) = path(l,index2);
        path(l,index2)=temp;
    end
        mutatedPath = path; 