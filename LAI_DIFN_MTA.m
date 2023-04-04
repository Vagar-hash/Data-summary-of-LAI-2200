
path = [input('影像路径：') '\'];
List =dir([path,'*.txt']); %设置路径
n=length(List);%计算文件长度
datatxt = zeros(n,3);
for i = 1:n
    file_name=List(i).name;
    s=importdata([path,file_name],' ');
    ss=s.textdata;
    %搜索LAI位置
    LAIadd = strfind(ss, 'LAI','ForceCellOutput',1);
    ind = ~cellfun(@isempty, LAIadd);
    LAIadd2=find(ind==1);
    LAI=ss{LAIadd2(2)};
    LAI = str2double(LAI(5:end));
    %搜索DIFN位置，LAI+3
    DIFN=ss{LAIadd2(2)+3};
    DIFN = str2double(DIFN(6:end));
    %搜索MTA位置，LAI+4
    MTA=ss{LAIadd2(2)+4};
    MTA = str2double(MTA(5:end));
    datatxt(i,:) = [LAI DIFN MTA];
end
datatxtt = [{List.name}' {List.date}' num2cell(datatxt)];
xlswrite([path 'aaa000.xlsx'],datatxtt)
