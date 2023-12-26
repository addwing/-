function [ mutatedPath ] = mutate( path, prob )
%对指定的路径利用指定的概率进行更新
%行：由于路径不允许存在相同的数，所以变异不能随意变，只能用随机互换位置的方法
    random = rand();
    if random <= prob         
        [l,length] = size(path);
        index1 = randi([2,length-1]);
        index2 = randi([2,length-1]);
        %交换
        temp = path(l,index1);
        path(l,index1) = path(l,index2);
        path(l,index2)=temp;
    end
        mutatedPath = path; 