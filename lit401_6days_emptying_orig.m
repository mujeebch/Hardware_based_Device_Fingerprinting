% this program finds the noise pattern for normal data of LIT401

% this is lit-401 in in tank 4

clear
clc

lit401=csvread('LIT401_6days_dec_2015.csv');

plot(lit401)

%%
% pick chunks of lets say 50k readings, bc some data was not as clean

lit401_1=lit401(20000:32000);
lit401_2=lit401(38000:65000);
lit401_3=lit401(68000:100000);
lit401_4=lit401(100000:200000);
lit401_5=lit401(200000:337000);
lit401_6=lit401(370000:430000);
lit401_7=lit401(450000:490000);

col = 0; % to control the columns of each vector
run = 1; % to control the rows of each fill vector
count=1; % to control boundary points, when we exit loop...take actions based on this flag
i=1;     % loop variable
a=0;     % flag to capture the lower limit of desired data, to avoid problem due to nosie etc

[model1_lit401,measured1_lit401]=DEF_lit401(lit401_1,count,col,run);
[model2_lit401,measured2_lit401]=DEF_lit401(lit401_2,count,col,run);
[model3_lit401,measured3_lit401]=DEF_lit401(lit401_3,count,col,run);
[model4_lit401,measured4_lit401]=DEF_lit401(lit401_4,count,col,run);
[model5_lit401,measured5_lit401]=DEF_lit401(lit401_5,count,col,run);
%[model6_lit401,measured6_lit401]=DEF_lit401(lit401_6,count,col,run);
[model7_lit401,measured7_lit401]=DEF_lit401(lit401_7,count,col,run);

noise1_lit401=abs(model1_lit401 - measured1_lit401);
noise2_lit401=abs(model2_lit401 - measured2_lit401);
noise3_lit401=abs(model3_lit401 - measured3_lit401);
noise4_lit401=abs(model4_lit401 - measured4_lit401);
noise5_lit401=abs(model5_lit401 - measured5_lit401);
noise7_lit401=abs(model7_lit401 - measured7_lit401);



% this segment finds the min of length of the all noise vectors so that we can cascade them to that much value

min_len_lit401=min([length(noise1_lit401),length(noise2_lit401),length(noise3_lit401),length(noise4_lit401),length(noise5_lit401),length(noise7_lit401)]);
% cascading vectors according to min len among all
noise_lit401=[noise1_lit401(:,1:min_len_lit401);noise2_lit401(:,1:min_len_lit401);noise3_lit401(:,1:min_len_lit401);noise4_lit401(:,1:min_len_lit401);noise5_lit401(:,1:min_len_lit401);noise7_lit401(:,1:min_len_lit401)];

noise_lit401_gv=[noise_lit401(1:9,:);noise_lit401(11:34,:);noise_lit401(38:47,:);noise_lit401(49:82,:)]; % gv stands for good values. there are some anomalies like short vecotrs or similar. Removing those
for j=1:1:77 %85, 
    %pause(1)
    hold on
    figure(1); plot(noise_lit401_gv(j,1:345)) % changed values to 450, earlier was 700
end


% for finding noise pattern by averaging

len_lit401=size(noise_lit401_gv);
avg_noise_6_days_lit401=sum(noise_lit401_gv)/len_lit401(1);
hold on
figure(2); plot(avg_noise_6_days_lit401(:,1:345),'-r') %length is upto 750 but we are looking at 700 readings here



