%Date：2018.6.5
%Name：Eazine
%Function：calculate droplet size in one dimension
%1000/(((334-20)^2+(219-193)^2)^(1/2))=3.1739 3.1739micrometers per pixel
close all;
clc;
clear;
oriImage=imread('E:\hyz\Data\2018\20180426\data\d90c480.tif');
figure
imshow(oriImage),title('original image');

%Image= imlincomb(5,oriImage);
%scale the image using a coeefficient of 5 in the lineat combination

%convert the matrix into an mat2 grey image
mat2grayImage=mat2gray(oriImage)
figure
imshow(mat2grayImage),title('brighten image')

%find the center of the droplets(the row is defined by the center of the channel)
%withdraw the data of column 512 and find the valleys. The two valleys are
%the wall of the channel
column512=mat2grayImage(:,512)
a=find(column512>0.5)
column512(a)=1
min_column=find(diff(sign(diff(column512)))>0)+1;
row=floor(mean(min_column))-1

%withdraw the data of raw x and define the average of the data as threshold 
data=mat2grayImage(row,:)
thre=mean(data)
figure
plot(1:length(data),data);
%提取对应像素点的强度值
hold on;

IndMin=find(diff(sign(diff(data)))>0)+1;
%diff()是求一阶导数，sign()符号函数，一阶导数为正的变为1，为负变为-1，
%只有在波谷的地方会发生变化，再用一次diff（）判断符号的变化，find的结果是波峰前面的数值，需要加1
loc=find(data(IndMin)<thre)
%寻找data-IndMin-loc（最后返回的结果是对应的Indmin的对应位置）
plot(IndMin(loc),data(IndMin(loc)),'r^')
di=diff(IndMin(loc))
%求前后两个波谷间的间距
size=di(end:-2:10)
distance=di(end-1:-2:10)
%两波谷间距交替为size和distance，取决于末端是否有一个完整的液滴
