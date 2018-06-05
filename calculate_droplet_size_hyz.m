%Date��2018.6.5
%Name��Eazine
%Function��calculate droplet size in one dimension
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
%��ȡ��Ӧ���ص��ǿ��ֵ
hold on;

IndMin=find(diff(sign(diff(data)))>0)+1;
%diff()����һ�׵�����sign()���ź�����һ�׵���Ϊ���ı�Ϊ1��Ϊ����Ϊ-1��
%ֻ���ڲ��ȵĵط��ᷢ���仯������һ��diff�����жϷ��ŵı仯��find�Ľ���ǲ���ǰ�����ֵ����Ҫ��1
loc=find(data(IndMin)<thre)
%Ѱ��data-IndMin-loc����󷵻صĽ���Ƕ�Ӧ��Indmin�Ķ�Ӧλ�ã�
plot(IndMin(loc),data(IndMin(loc)),'r^')
di=diff(IndMin(loc))
%��ǰ���������ȼ�ļ��
size=di(end:-2:10)
distance=di(end-1:-2:10)
%�����ȼ�ཻ��Ϊsize��distance��ȡ����ĩ���Ƿ���һ��������Һ��
