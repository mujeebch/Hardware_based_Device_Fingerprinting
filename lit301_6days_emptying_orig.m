clear
clc

lit301=csvread('LIT301_6days_dec_2015.csv');

plot(lit301)



%%

% pick chunks of lets say 50k readings, bc some data was not as clean

lit301_1=lit301(22000:32000);
lit301_2=lit301(40000:53000);
lit301_3=lit301(72000:140000);
lit301_4=lit301(140000:180000); % 200,000
lit301_5=lit301(200000:260000);
lit301_6=lit301(260000:300000);
lit301_7=lit301(300000:340000);
lit301_8=lit301(420000:436000);
lit301_9=lit301(450000:490000);

col = 0; % to control the columns of each vector
run = 1; % to control the rows of each fill vector
count=1; % to control boundary points, when we exit loop...take actions based on this flag
i=1;     % loop variable
a=0;     % flag to capture the lower limit of desired data, to avoid problem due to nosie etc

[model1_lit301,measured1_lit301] = DEE_lit301(lit301_1,count,col,run);
[model2_lit301,measured2_lit301] = DEE_lit301(lit301_2,count,col,run);
[model3_lit301,measured3_lit301] = DEE_lit301(lit301_3,count,col,run);
[model4_lit301,measured4_lit301] = DEE_lit301(lit301_4,count,col,run);
[model5_lit301,measured5_lit301] = DEE_lit301(lit301_5,count,col,run);
[model6_lit301,measured6_lit301] = DEE_lit301(lit301_6,count,col,run);
[model7_lit301,measured7_lit301] = DEE_lit301(lit301_7,count,col,run);
[model8_lit301,measured8_lit301] = DEE_lit301(lit301_8,count,col,run);
[model9_lit301,measured9_lit301] = DEE_lit301(lit301_9,count,col,run);

%%

noise1_lit301=abs(model1_lit301-measured1_lit301);
noise2_lit301=abs(model2_lit301 - measured2_lit301);
noise3_lit301=abs(model3_lit301 - measured3_lit301);
noise4_lit301=abs(model4_lit301 - measured4_lit301);
noise5_lit301=abs(model5_lit301 - measured5_lit301);
noise6_lit301=abs(model6_lit301 - measured6_lit301);
noise7_lit301=abs(model7_lit301 - measured7_lit301);
noise8_lit301=abs(model8_lit301 - measured8_lit301);
noise9_lit301=abs(model9_lit301 - measured9_lit301);

%% this segment finds the min of length of the all noise vectors so that we can cascade them to that much value
% UPDATE: No need to find the min length just cascade all the vectors and
% then remove ones which are skewed, sp commenting following line
% min_len_lit301=min([length(noise1_lit301),length(noise2_lit301),length(noise5_lit301),length(noise6_lit301),length(noise7_lit301),length(noise8_lit301),length(noise9_lit301)]);
% cascading all vectors in one matrix according to the min len of all
noise_lit301=[noise1_lit301(:,1:360);noise2_lit301(:,1:360);noise3_lit301(:,1:360);noise4_lit301(:,1:360);noise5_lit301(:,1:360);noise6_lit301(:,1:360);noise7_lit301(:,1:360);noise8_lit301(:,1:360);noise9_lit301(:,1:360)];

noise_lit301_gv=[noise_lit301(1:5,:);noise_lit301(10:16,:);noise_lit301(18:25,:);noise_lit301(27:31,:);noise_lit301(33:49,:);noise_lit301(51:54,:);noise_lit301(56:69,:);noise_lit301(71:86,:)]; % gv stands for good values, there are some anomalies like short vecotrs or similar. Removing those
for j=1:1:76 % loops runs number of rows of noise vector, 86 were initially, now 76 left after removal of skewed ones above
    %pause(1)
    hold on
    figure(1); plot(noise_lit301_gv(j,1:360)) %plotting all the vectors
end


%% calculating the average reference pattern
len_lit301=size(noise_lit301_gv);
avg_noise_6_days_lit301_emp=sum(noise_lit301_gv)/len_lit301(1);
hold on
figure(2); 
plot(avg_noise_6_days_lit301_emp(:,1:360),'-r')


