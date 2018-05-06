% this program finds the noise pattern for normal data of LIT401

clear
clc

lit401_exc=csvread('lit401_sensor_exchanged_2_2_2016.csv'); % exc stands for exchanged
 % plot(lit401_exc); % this plot shows neat readings are between 960-990

% pick chunks of lets say 50k readings, bc some data was not as clean
% 
% lit401_1=lit401(20000:32000);

col = 0; % to control the columns of each vector
run = 1; % to control the rows of each fill vector
count=1; % to control boundary points, when we exit loop...take actions based on this flag
i=1;     % loop variable
a=0;     % flag to capture the lower limit of desired data, to avoid problem due to nosie etc

[model1_lit401_exc,measured1_lit401_exc]=DEF_lit401_exc(lit401_exc,count,col,run);

noise1_lit401_exc=abs(model1_lit401_exc - measured1_lit401_exc);


%
% this segment finds the min of length of the all noise vectors so that we can cascade them to that much value

% min_len_lit401=min([length(noise1_lit401),length(noise2_lit401),length(noise3_lit401),length(noise4_lit401),length(noise5_lit401),length(noise7_lit401)]);
% % cascading vectors according to min len among all
% noise_lit401=[noise1_lit401(:,1:min_len_lit401);noise2_lit401(:,1:min_len_lit401);noise3_lit401(:,1:min_len_lit401);noise4_lit401(:,1:min_len_lit401);noise5_lit401(:,1:min_len_lit401);noise7_lit401(:,1:min_len_lit401)];
% 
% noise_lit401_gv=[noise_lit401(1:9,:);noise_lit401(11:34,:);noise_lit401(38:47,:);noise_lit401(49:85,:)] % gv stands for good values. there are some anomalies like short vecotrs or similar. Removing those

for j=1:1:3 %bc we have only 3 vectors here
    %pause(1)
    hold on
    figure(1); plot(noise1_lit401_exc(j,1:345)) % others become 0 beyond this 450 to 345, full size is 480
end


% for finding noise pattern by averaging

len_lit401_exc=size(noise1_lit401_exc);
avg_noise_lit401_exc_a=sum(noise1_lit401_exc)/len_lit401_exc(1);
hold on
figure(2); plot(avg_noise_lit401_exc_a(:,1:345),'-r') %length is upto 750 but we are looking at 700 readings here

save avg_noise_lit401_exc_a


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% New_data_12_2_2016, just copy and pasted code from above here

% this program finds the noise pattern for normal data of LIT401

clear
clc

lit401_exc=csvread('lit401_exchanged_12022016.csv'); % exc stands for exchanged
%plot(lit401_exc)

%
% pick chunks of lets say 50k readings, bc some data was not as clean
% 
lit401_1=lit401_exc(1500:5000);

lit401_2=lit401_exc(9000:13000);

lit401_3=lit401_exc(14500:16500);

lit401_4=lit401_exc(20000:22000);

lit401_5=lit401_exc(25500:28000);

lit401_6=lit401_exc(31500:33000);

col = 0; % to control the columns of each vector
run = 1; % to control the rows of each fill vector
count=1; % to control boundary points, when we exit loop...take actions based on this flag
i=1;     % loop variable
a=0;     % flag to capture the lower limit of desired data, to avoid problem due to nosie etc

[model1_lit401_exc,measured1_lit401_exc]=DEF_lit401_exc(lit401_1,count,col,run);
[model2_lit401_exc,measured2_lit401_exc]=DEF_lit401_exc(lit401_2,count,col,run);
[model3_lit401_exc,measured3_lit401_exc]=DEF_lit401_exc(lit401_3,count,col,run);
[model4_lit401_exc,measured4_lit401_exc]=DEF_lit401_exc(lit401_4,count,col,run);
[model5_lit401_exc,measured5_lit401_exc]=DEF_lit401_exc(lit401_5,count,col,run);
[model6_lit401_exc,measured6_lit401_exc]=DEF_lit401_exc(lit401_6,count,col,run);


noise1_lit401_exc=abs(model1_lit401_exc - measured1_lit401_exc);
noise2_lit401_exc=abs(model2_lit401_exc - measured2_lit401_exc);
noise3_lit401_exc=abs(model3_lit401_exc - measured3_lit401_exc);
noise4_lit401_exc=abs(model4_lit401_exc - measured4_lit401_exc);
noise5_lit401_exc=abs(model5_lit401_exc - measured5_lit401_exc);
noise6_lit401_exc=abs(model6_lit401_exc - measured6_lit401_exc);

% this segment finds the min of length of the all noise vectors so that we can cascade them to that much value

min_len_lit401_exc=min([length(noise1_lit401_exc),length(noise2_lit401_exc),length(noise3_lit401_exc),length(noise4_lit401_exc),length(noise5_lit401_exc),length(noise6_lit401_exc)]);
% cascading vectors according to min len among all
noise_lit401_exc=[noise1_lit401_exc(:,1:min_len_lit401_exc);noise2_lit401_exc(:,1:min_len_lit401_exc);noise3_lit401_exc(:,1:min_len_lit401_exc);noise4_lit401_exc(:,1:min_len_lit401_exc);noise5_lit401_exc(:,1:min_len_lit401_exc);noise6_lit401_exc(:,1:min_len_lit401_exc)];

% gv stands for good values. there are some anomalies like short vecotrs or similar. Removing those
%noise_lit401_gv=[noise_lit401_exc(1:9,:);noise_lit401_exc(11:34,:);noise_lit401_exc(38:47,:);noise_lit401_exc(49:82,:)]; 
for j=1:1:6 %85, 
    %pause(1)
    hold on
    figure(1); plot(noise_lit401_exc(j,1:345)) % changed values to 450, earlier was 700
end

save noise_lit401_exc

%% for finding noise pattern by averaging

len_lit401=size(noise_lit401_exc);
avg_noise_lit401_exc_b=sum(noise_lit401_exc)/len_lit401(1);

figure(2), plot(avg_noise_lit401_exc_b(:,1:345),'-r') %length is upto 750 but we are looking at 700 readings here
save avg_noise_lit401_exc_b
