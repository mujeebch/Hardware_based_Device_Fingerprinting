clear
clc

lit301=csvread('LIT301_6days_dec_2015.csv');

% pick chunks of lets say 50k readings, bc some data was not as clean

lit301_1=lit301(20000:32000);

lit301_2=lit301(38000:55000);

lit301_3=lit301(72000:140000);

lit301_4=lit301(140000:200000);

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

while(i<=length(lit301_1)) % loop to read whole string of data for given sensor
    
    if (i>201) % just bc in if we are checking if its filling or emptying, to set logic for that
        if (lit301_1(i)>=920) % this condition to set flag for lower value to be used in following loop
            a=1;
            while (a==1) && (lit301_1(i)<971) && (lit301_1(i) - lit301_1(i-100)>0) % this loop will run for desired data points
                count=0; % this flag is used when this loop exit, to monitor loop exit 
                if (col == 0) % to initialize value to be used in model
                    lit301_ini = lit301_1(i-1);
                end
                
                col = col + 1; % incremented to 1 as Matlab does not support an index 0
                filling_lit301_model(run,col) = lit301_ini + (0.45500326-0.42157445); % getting a particular row and all col elements for a vector
                filling_lit301_measured(run,col) = lit301_1(i); % for measured data
                lit301_ini = filling_lit301_model(run,col); % updating initial value to be used in model above
                
                
                i = i + 1; % loop var inc
                
            end % end while
        end % end if
        
        if count==0 % this is to check when inner loop terminates to inc row and col for next vectors
            run = run + 1; % inc
            i=i+100; % to avoid boundary value noise problem at upper boundary
            col = 0; % set for next iter
            count=1; % set so that this if won't execute until inner loop not executed
            
        end
        
    end %end that dummy if to avoid issue in start
    i = i + 1; %inc
    
end

%plot(filling_lit301_model)
hold on
plot(filling_lit301_measured)

figure(2),plot(lit301_1)
