clear
clc

lit301_exchanged_2_2_2016=csvread('LIT301_sensor_exchanged_02022016.csv');

%plot(lit301_exchanged_2_2_2016)
%
lit301=lit301_exchanged_2_2_2016'; %complement taken to make a row vector into a column vector for analysis
lit301_1_exc=lit301(:,2000:6000);
lit301_2_exc=lit301(:,8000:12000);


col = 0; % to control the columns of each vector
run = 1; % to control the rows of each fill vector
count=1; % to control boundary points, when we exit loop...take actions based on this flag
i=1;     % loop variable
a=0;     % flag to capture the lower limit of desired data, to avoid problem due to nosie etc

[model1_exc,measured1_exc]=DEF(lit301_1_exc,count,col,run);

[model2_exc,measured2_exc]=DEF(lit301_2_exc,count,col,run);

noise1_exc=abs(model1_exc-measured1_exc);
noise2_exc=abs(model2_exc-measured2_exc);
%
min_len_exc=min([length(noise1_exc),length(noise2_exc)]);
% cascading 
noise_exc=[noise1_exc(:,1:min_len_exc);noise2_exc(:,1:min_len_exc)];

for j=1:1:88
    %pause(1)
    hold on
    figure(1); plot(noise_exc(j,:))
end


%% calculating the average reference pattern
len_lit301_exc=size(noise_exc);
avg_noise_lit301_exc_a=sum(noise_exc)/len_lit301_exc(1);
hold on
figure(2); 
plot(avg_noise_lit301_exc_a(:,:),'-r')

save avg_noise_lit301_exc_a


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% copy code from above here to see for 12022016 data

clear
clc

lit301_exchanged_12_02_2016=csvread('lit301_exchanged_12022016.csv');

%plot(lit301_exchanged_12_02_2016)
%
lit301=lit301_exchanged_12_02_2016'; %complement taken to make a row vector into a column vector for analysis

lit301_1_exc=lit301(:,2000:5000);
lit301_2_exc=lit301(:,5500:9000);
lit301_3_exc=lit301(:,11000:14500);
lit301_4_exc=lit301(:,16500:20000);
lit301_5_exc=lit301(:,22500:26000);
lit301_6_exc=lit301(:,29000:30800);

col = 0; % to control the columns of each vector
run = 1; % to control the rows of each fill vector
count=1; % to control boundary points, when we exit loop...take actions based on this flag
i=1;     % loop variable
a=0;     % flag to capture the lower limit of desired data, to avoid problem due to nosie etc

[model1_exc,measured1_exc]=DEF(lit301_1_exc,count,col,run);
%[model2_exc,measured2_exc]=DEF(lit301_2_exc,count,col,run); % 2 n 6 were
%wiered
[model3_exc,measured3_exc]=DEF(lit301_3_exc,count,col,run);
[model4_exc,measured4_exc]=DEF(lit301_4_exc,count,col,run);
[model5_exc,measured5_exc]=DEF(lit301_5_exc,count,col,run);
%[model6_exc,measured6_exc]=DEF(lit301_6_exc,count,col,run);

noise1_exc=abs(model1_exc-measured1_exc);
%noise2_exc=abs(model2_exc-measured2_exc);
noise3_exc=abs(model3_exc-measured3_exc);
noise4_exc=abs(model4_exc-measured4_exc);
noise5_exc=abs(model5_exc-measured5_exc);
%noise6_exc=abs(model6_exc-measured6_exc);
%
min_len_exc=min([length(noise1_exc),length(noise3_exc),length(noise4_exc),length(noise5_exc)]);

% cascading 
noise_lit301_exc=[noise1_exc(:,1:min_len_exc);noise3_exc(:,1:min_len_exc);noise4_exc(:,1:min_len_exc);noise5_exc(:,1:min_len_exc)];

for j=1:1:4
    %pause(1)
    hold on
    figure(1); plot(noise_lit301_exc(j,1:700)) %800
end

save noise_lit301_exc

%% calculating the average reference pattern
len_lit301_exc=size(noise_exc);
avg_noise_lit301_exc_b=sum(noise_exc)/len_lit301_exc(1);
hold on
figure(2); 
plot(avg_noise_lit301_exc_b(:,1:700),'-r')


save avg_noise_lit301_exc_b




%%

%corrcoef(noise1_exc(:,1:800),avg_noise_6_days(:,1:800))

%
%corrcoef(noise2_exc(:,1:800),avg_noise_6_days(:,1:800))


