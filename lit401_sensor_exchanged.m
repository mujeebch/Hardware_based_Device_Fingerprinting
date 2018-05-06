
%clear
clc

lit401_exchanged_2_2_2016=csvread('LIT401_2_2_2016_exc.csv');

lit401=lit401_exchanged_2_2_2016';
lit401_1_exc=lit401(:,1:7400);
lit401_2_exc=lit401(:,7500:13400);

%plot(lit401_1_exc)
%
col = 0; % to control the columns of each vector
run = 1; % to control the rows of each fill vector
count=1; % to control boundary points, when we exit loop...take actions based on this flag
i=1;     % loop variable
a=0;     % flag to capture the lower limit of desired data, to avoid problem due to nosie etc

[model1_exc,measured1_exc]=DEF(lit401_1_exc,count,col,run);

[model2_exc,measured2_exc]=DEF(lit401_2_exc,count,col,run);

noise1_lit401_exc=abs(model1_exc-measured1_exc);
noise2_lit401_exc=abs(model2_exc-measured2_exc);
%%
min_len_exc=min([length(noise1_exc),length(noise2_exc)]);
%% cascading 
noise_exc=[noise1_exc(:,1:min_len_exc);noise2_exc(:,1:min_len_exc)];

for j=1:1:88
    pause(1)
    hold on
    figure(1); plot(noise_exc(j,:))
end


%%

corrcoef(noise8(4,1:800),avg_noise_6_days(:,1:800))

%%
corrcoef(noise2_lit401_exc(:,1:800),avg_noise_6_days(:,1:800))


