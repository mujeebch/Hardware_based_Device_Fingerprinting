%reads csv lit301 and subtracts that from a deterministic model and gives
%us noise. then we cal var and mean for that wrt each other

clear 
lit301=xlsread('20150930LIT301.csv'); 


for i=1:1:length(lit301)
    if (i<=560)
        lit301_model_det(i)=sum(lit301(1:560))/(560-1+1);
    else if (i>560 && i <=1080)||(i>3840 && i<=4370)       %decreasing level
            lit301_model_det(i)=lit301_model_det(i-1)-0.42157445;
        else if (i>1080 && i<=2380)||(i>4370 && i<=5690)
                lit301_model_det(i)=lit301_model_det(i-1)+(0.45500326-0.42157445); %increasing with inflow and outflow
            else if (i>2380 && i<=2490)||(i>5690 && i<=5800)
                    lit301_model_det(i)=lit301_model_det(i-1)+0.45500326; %increaing inflow only
                else if (i>2490 && i<=3160)||(i>5800 && i<=6450)
                        lit301_model_det(i)=lit301_model_det(i-1)+(0.45500326-0.42157445);
                    else if (i>3160 && i<=3375)||(i>6450 && i<=6680)
                            lit301_model_det(i)=lit301_model_det(i-1)+0.45500326;
                        else if (i>3375 && i<=3840)
                                lit301_model_det(i)=sum(lit301(3375:3840))/(3840-3375);
                            end
                        end
                    end
                        
                end
            end
        end      
    end
end

lit301_model_det=lit301_model_det';
 figure(2);plot (lit301(1:6680))
 hold on 
 plot(lit301_model_det(1:6680))
 
 noise_det=((lit301(1:6680))-(lit301_model_det(1:6680)));
 
 figure(3);plot(noise_det)
 
 plot(lit301)
 
 sd = 3.8943;
mn = 1.3352;
y = sd.*randn(6680,1) + mn;
 
 
 %% second approach as in above method end points are lose and noise is
 %more I guess

%water level increasing _Filling
%vec1_fill=lit301(1200:2200,1) %1200-2200

lit301=xlsread('20150930LIT301.csv'); 

vec1_fill_in_out(1)=lit301(1200);
for j=2:1:1001
    vec1_fill_in_out(j)=vec1_fill_in_out(j-1)+(0.45500326-0.42157445);
end

%4600-5600
vec2_fill_in_out(1)=lit301(4600);
for j=2:1:1001
    vec2_fill_in_out(j)=vec2_fill_in_out(j-1)+(0.45500326-0.42157445);
end

%7800-8800
vec3_fill_in_out(1)=lit301(7800);
for j=2:1:1001
    vec3_fill_in_out(j)=vec3_fill_in_out(j-1)+(0.45500326-0.42157445);
end

%11200-12200
vec4_fill_in_out(1)=lit301(11200);
for j=2:1:1001
    vec4_fill_in_out(j)=vec4_fill_in_out(j-1)+(0.45500326-0.42157445);
end

%water level decreasing _Emptying

%600- 1000
vec1_empty_out(1)=lit301(600);
for j=2:1:401
    vec1_empty_out(j)=vec1_empty_out(j-1)-0.42157445;
end

%3900-4300
vec2_empty_out(1)=lit301(3900);
for j=2:1:401
    vec2_empty_out(j)=vec2_empty_out(j-1)-0.42157445;
end

%7200-7600
vec3_empty_out(1)=lit301(7200);
for j=2:1:401
    vec3_empty_out(j)=vec3_empty_out(j-1)-0.42157445;
end

%10500-10900
vec4_empty_out(1)=lit301(10500);
for j=2:1:401
    vec4_empty_out(j)=vec4_empty_out(j-1)-0.42157445;
end

% generate noise vector by lit301 - vectors_model above

%for filling
noise_vec1_fill_in_out=abs((vec1_fill_in_out)' - (lit301(1200:2200)));

noise_vec2_fill_in_out=abs((vec2_fill_in_out)' - (lit301(4600:5600)));

noise_vec3_fill_in_out=abs((vec3_fill_in_out)' - (lit301(7800:8800)));

noise_vec4_fill_in_out=abs((vec4_fill_in_out)' - (lit301(11200:12200)));

%for emptying

noise_vec1_empty_out=(vec1_empty_out)' - (lit301(600:1000));

noise_vec2_empty_out=(vec2_empty_out)' - (lit301(3900:4300));

noise_vec3_empty_out=(vec3_empty_out)' - (lit301(7200:7600));

noise_vec4_empty_out=(vec4_empty_out)' - (lit301(10500:10900));

% Correlation coefficients among these noise vectors...Filling....result of
% following vectors is not correlated even with themselves from instance to
% instance

cc_vec1_vec2_fill_in_out=corrcoef(noise_vec1_fill_in_out,noise_vec2_fill_in_out);

cc_vec1_vec3_fill_in_out=corrcoef(noise_vec1_fill_in_out,noise_vec3_fill_in_out);

cc_vec1_vec4_fill_in_out=corrcoef(noise_vec1_fill_in_out,noise_vec4_fill_in_out);


cc_vec2_vec3_fill_in_out=corrcoef(noise_vec2_fill_in_out,noise_vec3_fill_in_out);

cc_vec2_vec4_fill_in_out=corrcoef(noise_vec2_fill_in_out,noise_vec4_fill_in_out);
% 
%Following plot shows, how these noises even from one sensor are different
plot(noise_vec1_fill_in_out,'-+r')
hold on
plot(noise_vec2_fill_in_out,'-*k')
hold on
plot(noise_vec3_fill_in_out,'-dg')
hold on
plot(noise_vec4_fill_in_out)

xl=xlabel('Measurements')
yl=ylabel('Error (mm)')
set(xl,'FontSize',14);
set(yl,'FontSize',14);


h_legend=legend('Noise Vector 1','Noise Vector 2','Noise Vector 3','Noise Vector 4')
set(h_legend,'FontSize',14);
%variance and mean
var_vec1_fill_in_out=var(noise_vec1_fill_in_out);
mean_vec1_fill_in_out=mean(noise_vec1_fill_in_out);

var_vec2_fill_in_out=var(noise_vec2_fill_in_out);
mean_vec2_fill_in_out=mean(noise_vec2_fill_in_out);

var_vec3_fill_in_out=var(noise_vec3_fill_in_out);
mean_vec3_fill_in_out=mean(noise_vec3_fill_in_out);

var_vec4_fill_in_out=var(noise_vec4_fill_in_out);
mean_vec4_fill_in_out=mean(noise_vec4_fill_in_out);

% find the average for above vectors to get reference noise

avg_vec_fill_in_out=(abs(noise_vec1_fill_in_out)+abs(noise_vec2_fill_in_out)+abs(noise_vec3_fill_in_out)+abs(noise_vec4_fill_in_out))/4;

%plot(avg_vec_fill_in_out);

%correlation coefficients between, avg_noise_vec and all individuals

cc_avg_vec1_fill_in_out=corrcoef(noise_vec1_fill_in_out,avg_vec_fill_in_out);


cc_avg_vec2_fill_in_out=corrcoef(noise_vec2_fill_in_out,avg_vec_fill_in_out);

cc_avg_vec3_fill_in_out=corrcoef(noise_vec3_fill_in_out,avg_vec_fill_in_out);

cc_avg_vec4_fill_in_out=corrcoef(noise_vec4_fill_in_out,avg_vec_fill_in_out);



var_avg_vec_fill_in_out_lit301=var(avg_vec_fill_in_out);
mean_avg_vec_fill_in_out_lit301=mean(avg_vec_fill_in_out);
% Correlation coefficients among Emptying noise vetors


cc_vec1_vec2_empty_out=corrcoef(noise_vec1_empty_out,noise_vec2_empty_out);

cc_vec1_vec3_empty_out=corrcoef(noise_vec1_empty_out,noise_vec3_empty_out);

cc_vec1_vec4_empty_out=corrcoef(noise_vec1_empty_out,noise_vec4_empty_out);


cc_vec2_vec3_empty_out=corrcoef(noise_vec2_empty_out,noise_vec3_empty_out);

cc_vec2_vec4_empty_out=corrcoef(noise_vec2_empty_out,noise_vec4_empty_out);

%% LIT-401

lit401=xlsread('LIT401.csv'); 

%plot(lit401);

%1200-2600
vec1_fill_in_out_lit401(1)=lit401(1200);
for j=2:1:1401
    vec1_fill_in_out_lit401(j)=vec1_fill_in_out_lit401(j-1)+(0.42157445 - 0.30828792);
end

%plot(vec1_fill_in_out_lit401)
%hold on
%plot(lit401(1200:2600))

%4600-6000
vec2_fill_in_out_lit401(1)=lit401(4600);
for j=2:1:1401
    vec2_fill_in_out_lit401(j)=vec2_fill_in_out_lit401(j-1)+(0.42157445 - 0.30828792);
end


% plot(vec2_fill_in_out_lit401)
% hold on
% plot(lit401(4600:6000))




%for filling
noise_vec1_fill_in_out_lit401=abs((vec1_fill_in_out_lit401)' - (lit401(1200:2600)));

noise_vec2_fill_in_out_lit401=abs((vec2_fill_in_out_lit401)' - (lit401(4600:6000)));

% Correlation coefficients among these noise vectors...Filling....

cc_vec1_vec2_fill_in_out_lit401=corrcoef(noise_vec1_fill_in_out_lit401,noise_vec2_fill_in_out_lit401);

% %Following plot shows, how these noises even from one sensor are different
% plot(noise_vec1_fill_in_out_lit401,'r')
% hold on
% plot(noise_vec2_fill_in_out_lit401,'k')

%variance and mean
var_vec1_fill_in_out_lit401=var(noise_vec1_fill_in_out_lit401);
mean_vec1_fill_in_out_lit401=mean(noise_vec1_fill_in_out_lit401);

var_vec2_fill_in_out_lit401=var(noise_vec2_fill_in_out_lit401);
mean_vec2_fill_in_out_lit401=mean(noise_vec2_fill_in_out_lit401);


% find the average for above vectors to get reference noise

avg_vec_fill_in_out_lit401=(abs(noise_vec1_fill_in_out_lit401)+abs(noise_vec2_fill_in_out_lit401))/2;

%plot(avg_vec_fill_in_out_lit401);

var_avg_vec_fill_in_out_lit401=var(avg_vec_fill_in_out_lit401);
mean_avg_fill_in_out_lit401=mean(avg_vec_fill_in_out_lit401);

%correlation between individuals of lit401 and avg of lit301..noise vectors

cc_avg_vec1_fill_in_out_lit401=corrcoef(noise_vec1_fill_in_out_lit401(1:1001),avg_vec_fill_in_out);

cc_avg_vec2_fill_in_out_lit401=corrcoef(noise_vec2_fill_in_out_lit401(1:1001),avg_vec_fill_in_out);

% correlation between nosie of lit401 indvidual to its own avg

cc_avg_vec1_fill_in_out_lit401=corrcoef(noise_vec1_fill_in_out_lit401,avg_vec_fill_in_out_lit401);
cc_avg_vec2_fill_in_out_lit401=corrcoef(noise_vec2_fill_in_out_lit401,avg_vec_fill_in_out_lit401);

% correlation between avergae of lit301 and lit401

cc_avglit301_avglit401_fill_in_out=corrcoef(avg_vec_fill_in_out,avg_vec_fill_in_out_lit401(1:1001));


%% corelation comparison of lit301 individuals with lit401 avg

cc_avglit401_vec1_fill_in_out_lit301=corrcoef(noise_vec1_fill_in_out,avg_vec_fill_in_out_lit401(1:1001))

cc_avglit401_vec2_fill_in_out_lit301=corrcoef(noise_vec2_fill_in_out,avg_vec_fill_in_out_lit401(1:1001))

cc_avglit401_vec3_fill_in_out_lit301=corrcoef(noise_vec3_fill_in_out,avg_vec_fill_in_out_lit401(1:1001))

cc_avglit401_vec4_fill_in_out_lit301=corrcoef(noise_vec4_fill_in_out,avg_vec_fill_in_out_lit401(1:1001))
%% Comparison between avg noise vector and other readings to distinguish
% sensors


% comparison between lit301 avg and it's vectors

std_dev_avg_fill_in_out_lit301=sqrt(var_avg_vec_fill_in_out_lit301);

count_3sig_fill_in_out_lit301=0;

for j=1:1:1001
    if (noise_vec4_fill_in_out(j)<=(2.5566))
        count_3sig_fill_in_out_lit301=count_3sig_fill_in_out_lit301+1;
    end
end


count_3sig_fill_in_out_lit301;

































