Master_Code_path='/Users/jaimiez/Desktop/Research/Master_Code';
AI_ML_path='/Users/jaimiez/Desktop/Research/AI_ML/Post_Processed_Data'; %Modify and place your path here
GOES_LCZ_Table_path='/Users/jaimiez/Desktop/Research/GOES_LCZ_Table'; %Modify and place your path here

%AI_ML_LST_Summary Code
cd(AI_ML_path);
% AI_ML_Path_dir=dir('*.txt');
% for L=1:122
% for i=1:696 %length(AI_ML_Path_dir)
%         A=readmatrix(AI_ML_Path_dir(i).name);
%         T(i,L)=A(L,3);
% end 
% end
%Each column is a different location. Each row increase in hour increments

A=readmatrix('AI_ML_LST_Summary.txt');
K= 273.15*ones(2088,1);
x = 0:1:2087;
datetime.setDefaultFormats('default','yyyy-MM-dd HH:mm:ss')
startDate = datetime(2022,05,01, 0,01,0);
x = startDate + hours(x);
C=A(:,1)-K; %specify which location(column) you want to plot
F = 1.8*(C)+ 32; %conversion to Fahrenheit
F(F<=40)=NaN; %get rid of outliers in data

%%%%%%%
%transpose datetimes
p=string(transpose(x));
K_2= 273.15*ones(2088,122);
C_2=A-K;
F_2= 1.8*(C_2)+32;
F_2(F_2<=40)=NaN;

location = [p F_2];
R= array2table(location);
writetable(R,'WeatherForecasting.csv') 
%%%%%%%%

Nan=isnan(F);
Z=F(~Nan); %matrix without Nan
time=x(find(Nan==0)); 

Z(:,2)= circshift(Z,[-1,-1]); %target
Z(length(Z),2)= Z(length(Z)-1,2);

figure(1)
plot(time,Z(:,1)) %specify which location(column) you want to plot
xlabel('Time');
xtickformat('dd-MMM-yyyy HH:mm:ss');
ylabel('Temperature(F)');
title('Temp vs. Time')


cd(Master_Code_path)
