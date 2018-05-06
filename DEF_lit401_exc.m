% this function is written to extract data for filling process of LIT 301
% and get the noise vectors

function [filling_lit_model,filling_lit_measured]=DEF_lit401(lit,count,col,run) % data_extract_filling


i=1;     % loop variable
a=0;     % flag to capture the lower limit of desired data, to avoid problem due to nosie etc

while(i<=length(lit)) % loop to read whole string of data for given sensor
    
    if (i>201) % just bc in if we are checking if its filling or emptying, to set logic for that
        if (lit(i)>=960) % this condition to set flag for lower value to be used in following loop
            a=1;
            while (a==1) && (lit(i)<990) && (lit(i) - lit(i-100)>0) % this loop will run for desired data points
                count=0; % this flag is used when this loop exit, to monitor loop exit 
                if (col == 0) % to initialize value to be used in model
                    lit_ini = lit(i-1);
                end
                
                col = col + 1; % incremented to 1 as Matlab does not support an index 0 
                filling_lit_model(run,col) = lit_ini + (0.42157445 - 0.30828792); % getting a particular row and all col elements for a vector
                filling_lit_measured(run,col) = lit(i); % for measured data
                lit_ini = filling_lit_model(run,col); % updating initial value to be used in model above
                
                
                i = i + 1; % loop var inc
                
            end % end while
        end % end if
        
        if count==0 % this is to check when inner loop terminates to inc row and col for next vectors
            run = run + 1; % inc
            i=i+100; % to avoid boundary value noise problem at upper boundary
            col = 0; % set for next iter
            count=1; % set so that this if won't execute until inner loop not executed
            
        end
        
    end %end that dummy if, which was used to avoid issue in start
    i = i + 1; %inc
    
end

