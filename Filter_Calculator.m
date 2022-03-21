
clc;
clear variables;
close all;

Total_filter_coefficient = 1;
while (Total_filter_coefficient)
    
Filter = input('\n Select the filter type:  \n \n  1 - Lowpass    2 - Highpass      0 - EXIT      :');

    if Filter == 0

        Total_filter_coefficient = 0;
        fprintf('\n \n')

    else
        
        
        Filter_order = input('\n Select the filter Order (Only 2, 4, 6, 8, 10 are available for now):    ');
        run('Filter_Coefficient.m')

            if Filter == 1

                fprintf(['\n \t   Lowpass of order - " ', num2str(Filter_order),' " \n'])
                run('Lowpass_Filter.m')


            else 

                fprintf(['\n \t   Highpass of order - " ', num2str(Filter_order),' " \n'])
                run('Highpass_Filter.m')

            end
            
    end   
    
end