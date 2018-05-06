% This program loads previously saved noise patterns for sensors and then
% use readings from LIT-301_original and LIT-401_original as fresh values
% and correlate their noise vectors with the average noise patterns

load noise_lit301_gv
load avg_noise_6_days_lit301
load avg_noise_6_days_lit401
load avg_noise_lit301_exc_b
load avg_noise_lit401_exc_b
load noise_lit401_gv

load noise_lit301_exc
load noise_lit401_exc

size(avg_noise_6_days_lit301);
size(noise_lit301_gv);
size(avg_noise_6_days_lit401);
size(avg_noise_lit301_exc_b);
size(avg_noise_lit401_exc_b);
size(noise_lit401_gv);

%% Corr between LIT-301_original and LIT-301_noise_pattern

% Following loop finds correlation between avg noise pattern taken over 6
% days and fresh readings from original LIT-301 vector by vector, in this
% case for 52 vectors....also these come from 6 days data

for i=1:1:52
    ans1 = corrcoef(avg_noise_6_days_lit301(1,1:700),noise_lit301_gv(i,1:700));
    Corr_Mtx_1 (i) = ans1(1,2);
end

% Corr between LIT-301_original and LIT-301_noise_pattern_swapped

for i=1:1:52
    ans1 = corrcoef(avg_noise_lit301_exc_b(1,1:700),noise_lit301_gv(i,1:700));
    Corr_Mtx_2 (i) = ans1(1,2);
end

% If Correlation of original with original pattern is higher than Correlation of original with swapped pattern, set h=1 and then sum(h)
% to see how many vectors are correlated
for i=1:1:52
    if (Corr_Mtx_1(i) > Corr_Mtx_2(i))
        h1(i) = 1;
    else
        h1(i)=0;
    end
end

%% Correlation between LIT-301_original and LIT-401_noise_pattern

for i=1:1:52
    ans1 = corrcoef(avg_noise_6_days_lit401(1,1:350),noise_lit301_gv(i,1:350));
    Corr_Mtx_3 (i) = ans1(1,2);
end

% If Correlation of original with original pattern is higher than Correlation of original with noise pattern from LIT-401, set h=1 and then sum(h)
% to see how many vectors are correlated

for i=1:1:52
    if (Corr_Mtx_1(i) > Corr_Mtx_3(i))
        h2(i) = 1;
    else
        h2(i)=0;
    end
end

%% Correlation between LIT-301_original and LIT-401_noise_pattern_swapped

for i=1:1:52
    ans1 = corrcoef(avg_noise_lit401_exc_b(1,1:350),noise_lit301_gv(i,1:350));
    Corr_Mtx_4 (i) = ans1(1,2);
end

% If Correlation of original with original pattern is higher than Correlation of original with noise pattern from LIT-401, set h=1 and then sum(h)
% to see how many vectors are correlated

for i=1:1:52
    if (Corr_Mtx_1(i) > Corr_Mtx_4(i))
        h3(i) = 1;
    else
        h3(i)=0;
    end
end

%% LIT-401

%% Corr between LIT-401_original and LIT-401_noise_pattern, from 6 days
for i=1:1:77
    ans1 = corrcoef(avg_noise_6_days_lit401(1,1:345),noise_lit401_gv(i,1:345));
    Corr_Mtx_11 (i) = ans1(1,2);
end

% Corr between LIT-301_original and LIT-301_noise_pattern_swapped

for i=1:1:77
    ans1 = corrcoef(avg_noise_lit401_exc_b(1,1:345),noise_lit401_gv(i,1:345));
    Corr_Mtx_12 (i) = ans1(1,2);
end

% If Correlation of original with original pattern is higher than Correlation of original with swapped pattern, set h=1 and then sum(h)
% to see how many vectors are correlated
for i=1:1:77
    if (Corr_Mtx_11(i) > Corr_Mtx_12(i))
        h11(i) = 1;
    else
        h11(i)=0;
    end
end

%% Correlation between LIT-401_original and LIT-301_noise_pattern

for i=1:1:77
    ans1 = corrcoef(avg_noise_6_days_lit301(1,1:350),noise_lit401_gv(i,1:350));
    Corr_Mtx_13 (i) = ans1(1,2);
end

% If Correlation of original with original pattern is higher than Correlation of original with noise pattern from LIT-401, set h=1 and then sum(h)
% to see how many vectors are correlated

for i=1:1:77
    if (Corr_Mtx_11(i) > Corr_Mtx_13(i))
        h12(i) = 1;
    else
        h12(i)=0;
    end
end

%% Correlation between LIT-401_original and LIT-301_noise_pattern_swapped

for i=1:1:77
    ans1 = corrcoef(avg_noise_lit301_exc_b(1,1:345),noise_lit401_gv(i,1:345));
    Corr_Mtx_14 (i) = ans1(1,2);
end

% If Correlation of original with original pattern is higher than Correlation of original with noise pattern from LIT-401, set h=1 and then sum(h)
% to see how many vectors are correlated

for i=1:1:77
    if (Corr_Mtx_11(i) > Corr_Mtx_14(i))
        h13(i) = 1;
    else
        h13(i)=0;
    end
end

%% Treating exchnaged values as fresh and comparing those with noise patterns from 6 days


for i=1:1:4
    ans1 = corrcoef(avg_noise_6_days_lit301(1,1:700),noise_lit301_exc(i,1:700));
    Corr_Mtx_111 (i) = ans1(1,2);
end


% Corr between LIT-301_original and LIT-301_noise_pattern_swapped

for i=1:1:4
    ans1 = corrcoef(avg_noise_6_days_lit401(1,1:350),noise_lit301_exc(i,1:350));
    Corr_Mtx_112 (i) = ans1(1,2);
end

% If Correlation of original with original pattern is higher than Correlation of original with swapped pattern, set h=1 and then sum(h)
% to see how many vectors are correlated
for i=1:1:4
    if (Corr_Mtx_111(i) > Corr_Mtx_112(i))
        h111(i) = 1;
    else
        h111(i)=0;
    end
end

%%


for i=1:1:6
    ans1 = corrcoef(avg_noise_6_days_lit301(1,1:350),noise_lit401_exc(i,1:350));
    Corr_Mtx_113 (i) = ans1(1,2);
end


% Corr between LIT-301_original and LIT-301_noise_pattern_swapped

for i=1:1:6
    ans1 = corrcoef(avg_noise_6_days_lit401(1,1:350),noise_lit401_exc(i,1:350));
    Corr_Mtx_114 (i) = ans1(1,2);
end

% If Correlation of original with original pattern is higher than Correlation of original with swapped pattern, set h=1 and then sum(h)
% to see how many vectors are correlated
for i=1:1:6
    if (Corr_Mtx_113(i) > Corr_Mtx_114(i))
        h112(i) = 1;
    else
        h112(i)=0;
    end
end