
K = 1;
while (K)
filters = '\n select the filter type: \n \n  1-Bassel       2-Butterworth       3-Tchebyschev      :';

type = input(filters);

if( type==1)
    fprintf('\n \t   Bassel \n');
    a = Bessel_Filter_a;
    b = Bessel_Filter_b;
elseif (type==2)
    fprintf('\n \t   Butterworth \n ');
    a = Butterworth_Filter_a;
    b = Butterworth_Filter_b;
else
    fprintf('\n \t   Tchebyschev \n');
    ripple = input('\n select the filter ripple: \n \n  1 - 0.5dB       2 - 1dB       3 - 2dB       4 - 3dB      :');
    if (ripple==1)
        a = Tchebyscheff_Filter_a_5dB;
        b = Tchebyscheff_Filter_b_5dB;
    elseif (ripple==2)
        a = Tchebyscheff_Filter_a_1dB;
        b = Tchebyscheff_Filter_b_1dB;
    elseif (ripple==3)
        a = Tchebyscheff_Filter_a_2dB;
        b = Tchebyscheff_Filter_b_2dB;
    elseif (ripple==4)
        a = Tchebyscheff_Filter_a_3dB;
        b = Tchebyscheff_Filter_b_3dB;        
    end
end


fc = input('\n 3dB Cut off Frequency in Hz :');

C = ([[10 12 15  16 18 20 22 30 33 39 47 68 100 150 220 330 470 680 1000 2200 3300 3900 4700 6800 8200 ].*1e-12 [10 20 22 33 40 47 68 100 220 680 1000].*1e-9]);
R = ([[1 1.2 1.5 1.8 2.2 2.7 3.3 3.9 4.7 5.6 6.8 8.2 10 12 15 18 22 27 33 39 47 56 68 82 100 120 150 180 220 270 330 390 470 560 680 820] [1 1.2 1.5 1.8 2.2 2.7 3.3 3.9 4.7 5.6 6.8 8.2 10 12 15 18 22 27 33 39 47 56 68 82 100 120 150 180 220 270 330 390 470 560 680 820].*1e+3 [1 1.2 1.5 1.8 2.2 2.7 3.3 3.9 4.7 5.6 6.8 8.2 10].*1e+6]);

H = 1;
while(H)
    
R1_lower_Limit = input('\n Max Percentage error in R Values :');
R2_lower_Limit = R1_lower_Limit;

for k =1:1:length(a)
    
    if k==1
        fprintf(['\n \t',num2str(k),'st Stage \t %d '])        
    elseif k==2
        fprintf(['\n \t',num2str(k),'nd Stage \t %d '])
    elseif k==3
        fprintf(['\n \t',num2str(k),'rd Stage \t %d '])
    else
        fprintf(['\n \t',num2str(k),'th Stage \t %d '])
    end
    
    fprintf('   C1            C2          R1          R2         R1 error      R2 error   \n \n')
    
    for i = 1:1:length(C)
        C1 = C(i);
        C_temp = C1*4*b(k)/((a(k))^2);
        
        for j = 1:1:length(C)
            C2 = C(j);
            if C2>=C_temp
                          
                R1 = (a(k)*C2-sqrt((C2*a(k))^2-4*C1*C2*b(k)))./(4*pi*fc*C1*C2);
                R2 = (a(k)*C2+sqrt((C2*a(k))^2-4*C1*C2*b(k)))./(4*pi*fc*C1*C2); 
                                            
            else
                C2 = 0;
                R1 = 0;
                R2 = 0;
            end
            

            for d = 1:length(R)    
                if abs(R1-R(d))<= min(abs(R1-R))
                    R1_Value = (R(d));

                end
               
            end

            for d = 1:length(R)    
                if abs(R2-R(d))<= min(abs(R2-R))       
                    R2_Value = (R(d));

                end
                
            end
            
           
                if (abs(R1-R1_Value)/R1*100)<=R1_lower_Limit && (abs(R2-R2_Value)/R2*100)<=R2_lower_Limit
                if R2<1e+6 || R2<1e+6           
                if C1>=1e-6 && C2>=1e-6
                
                    if R1>=1e+6  && R2>=1e+6  
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-6)),'u \t \t ',num2str(C2/(1e-6)),'u \t \t ',num2str(R1_Value/(1e+6)),'M \t \t ', num2str(R2_Value/(1e+6)),'M \t \t ', num2str(abs(R1-R1_Value)/R1*100),'%% \t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
                
                    elseif R1>=1e+6  && R2>=1e+3 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-6)),'u \t \t ',num2str(C2/(1e-6)),'u \t \t ',num2str(R1_Value/(1e+6)),'M \t \t ', num2str(R2_Value/(1e+3)),'k \t\t ',  num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
               
                    elseif R1>=1e+6  && R2>=0 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-6)),'u \t \t ',num2str(C2/(1e-6)),'u \t \t ',num2str(R1_Value/(1e+6)),'M \t \t ', num2str(R2_Value),'\t \t',           num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
            
                    elseif R1>=1e+3  && R2>=1e+6 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-6)),'u \t \t ',num2str(C2/(1e-6)),'u \t \t ',num2str(R1_Value/(1e+3)),'k \t \t ', num2str(R2_Value/(1e+6)),'M \t \t',  num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
            
                    elseif R1>=1e+3  && R2>=1e+3 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-6)),'u \t \t ',num2str(C2/(1e-6)),'u \t \t ',num2str(R1_Value/(1e+3)),'k \t \t ', num2str(R2_Value/(1e+3)),'k \t \t',  num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
            
                    elseif R1>=1e+3  && R2>=0 
                         fprintf (['\t \t \t \t \t',num2str(C1/(1e-6)),'u \t \t ',num2str(C2/(1e-6)),'u \t \t ',num2str(R1_Value/(1e+3)),'k \t \t ',num2str(R2_Value),'\t \t',           num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])

                    elseif R1>=0  && R2>=1e+6 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-6)),'u \t \t ',num2str(C2/(1e-6)),'u \t \t ',num2str(R1_Value),' \t \t ',         num2str(R2_Value/(1e+6)),'M \t \t',  num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])

                    elseif R1>=0  && R2>=1e+3 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-6)),'u \t \t ',num2str(C2/(1e-6)),'u \t \t ',num2str(R1_Value),'\t \t ',          num2str(R2_Value/(1e+3)),'k \t \t',  num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
                    
                    else
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-6)),'u \t \t ',num2str(C2/(1e-6)),'u \t \t ',num2str(R1_Value),'\t \t ',          num2str(R2_Value),'\t \t',           num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
                    
                    end
                
                elseif C1>=1e-6 && C2>=1e-9
                
                    if R1>=1e+6  && R2>=1e+6  
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-6)),'u \t \t ',num2str(C2/(1e-9)),'n \t \t ',num2str(R1_Value/(1e+6)),'M \t \t ', num2str(R2_Value/(1e+6)),'M \t \t ', num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
                
                    elseif R1>=1e+6  && R2>=1e+3 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-6)),'u \t \t ',num2str(C2/(1e-9)),'n \t \t ',num2str(R1_Value/(1e+6)),'M \t \t ', num2str(R2_Value/(1e+3)),'k \t\t ',  num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
               
                    elseif R1>=1e+6  && R2>=0 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-6)),'u \t \t ',num2str(C2/(1e-9)),'n \t \t ',num2str(R1_Value/(1e+6)),'M \t \t ', num2str(R2_Value),'\t \t',           num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
            
                    elseif R1>=1e+3  && R2>=1e+6 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-6)),'u \t \t ',num2str(C2/(1e-9)),'n \t \t ',num2str(R1_Value/(1e+3)),'k \t \t ', num2str(R2_Value/(1e+6)),'M \t \t',  num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
            
                    elseif R1>=1e+3  && R2>=1e+3 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-6)),'u \t \t ',num2str(C2/(1e-9)),'n \t \t ',num2str(R1_Value/(1e+3)),'k \t \t ', num2str(R2_Value/(1e+3)),'k \t \t',  num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
            
                    elseif R1>=1e+3  && R2>=0 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-6)),'u \t \t ',num2str(C2/(1e-9)),'n \t \t ',num2str(R1_Value/(1e+3)),'k \t \t ', num2str(R2_Value),'\t \t',           num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])

                    elseif R1>=0  && R2>=1e+6 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-6)),'u \t \t ',num2str(C2/(1e-9)),'n \t \t ',num2str(R1_Value),' \t \t ',         num2str(R2_Value/(1e+6)),'M \t \t',   num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])

                    elseif R1>=0  && R2>=1e+3 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-6)),'u \t \t ',num2str(C2/(1e-9)),'n \t \t ',num2str(R1_Value),'\t \t ',          num2str(R2_Value/(1e+3)),'k \t \t',   num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
                    
                    else
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-6)),'u \t \t ',num2str(C2/(1e-9)),'n \t \t ',num2str(R1_Value),'\t \t ',          num2str(R2_Value),'\t \t',            num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
                    
                    end                
               
                elseif C1>=1e-6 && C2>=1e-12 
                
                    if R1>=1e+6  && R2>=1e+6  
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-6)),'u \t \t ',num2str(C2/(1e-12)),'p \t \t ',num2str(R1_Value/(1e+6)),'M \t \t ',num2str(R2_Value/(1e+6)),'M \t \t ',    num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
                    
                    elseif R1>=1e+6  && R2>=1e+3 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-6)),'u \t \t ',num2str(C2/(1e-12)),'p \t \t ',num2str(R1_Value/(1e+6)),'M \t \t ',num2str(R2_Value/(1e+3)),'k \t\t ',     num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
               
                    elseif R1>=1e+6  && R2>=0 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-6)),'u \t \t ',num2str(C2/(1e-12)),'p \t \t ',num2str(R1_Value/(1e+6)),'M \t \t ',num2str(R2_Value),'\t \t',              num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
            
                    elseif R1>=1e+3  && R2>=1e+6 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-6)),'u \t \t ',num2str(C2/(1e-12)),'p \t \t ',num2str(R1_Value/(1e+3)),'k \t \t ',num2str(R2_Value/(1e+6)),'M \t \t',     num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
            
                    elseif R1>=1e+3  && R2>=1e+3 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-6)),'u \t \t ',num2str(C2/(1e-12)),'p \t \t ',num2str(R1_Value/(1e+3)),'k \t \t ',num2str(R2_Value/(1e+3)),'k \t \t',     num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
            
                    elseif R1>=1e+3  && R2>=0 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-6)),'u \t \t ',num2str(C2/(1e-12)),'p \t \t ',num2str(R1_Value/(1e+3)),'k \t \t ',num2str(R2_Value),'\t \t',              num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])

                    elseif R1>=0  && R2>=1e+6 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-6)),'u \t \t ',num2str(C2/(1e-12)),'p \t \t ',num2str(R1_Value),' \t \t ',        num2str(R2_Value/(1e+6)),'M \t \t',     num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])

                    elseif R1>=0  && R2>=1e+3 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-6)),'u \t \t ',num2str(C2/(1e-12)),'p \t \t ',num2str(R1_Value),'\t \t ',         num2str(R2_Value/(1e+3)),'k \t \t',     num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
            
                    else
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-6)),'u \t \t ',num2str(C2/(1e-12)),'p \t \t ',num2str(R1_Value),'\t \t ',         num2str(R2_Value),'\t \t',              num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
                    
                    end
                
                elseif C1>=1e-9 && C2>=1e-6 
                
                    if R1>=1e+6  && R2>=1e+6  
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-9)),'n \t \t ',num2str(C2/(1e-6)),'u \t \t ',num2str(R1_Value/(1e+6)),'M \t \t ',num2str(R2_Value/(1e+6)),'M \t \t ', num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
                
                    elseif R1>=1e+6  && R2>=1e+3 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-9)),'n \t \t ',num2str(C2/(1e-6)),'u \t \t ',num2str(R1_Value/(1e+6)),'M \t \t ',num2str(R2_Value/(1e+3)),'k \t\t ',  num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
            
                    elseif R1>=1e+6  && R2>=0 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-9)),'n \t \t ',num2str(C2/(1e-6)),'u \t \t ',num2str(R1_Value/(1e+6)),'M \t \t ',num2str(R2_Value),'\t \t',           num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
            
                    elseif R1>=1e+3  && R2>=1e+6 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-9)),'n \t \t ',num2str(C2/(1e-6)),'u \t \t', num2str(R1_Value/(1e+3)),'k \t \t ',num2str(R2_Value/(1e+6)),'M \t \t',  num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
            
                    elseif R1>=1e+3  && R2>=1e+3 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-9)),'n \t \t ',num2str(C2/(1e-6)),'u \t \t ',num2str(R1_Value/(1e+3)),'k \t \t ',num2str(R2_Value/(1e+3)),'k \t \t',  num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
            
                    elseif R1>=1e+3  && R2>=0 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-9)),'n \t \t ',num2str(C2/(1e-6)),'u \t \t ',num2str(R1_Value/(1e+3)),'k \t \t ',num2str(R2_Value),'\t \t',           num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])

                    elseif R1>=0  && R2>=1e+6 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-9)),'n \t \t ',num2str(C2/(1e-6)),'u \t \t ',num2str(R1_Value),' \t \t ',         num2str(R2_Value/(1e+6)),'M \t \t', num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
    
                    elseif R1>=0  && R2>=1e+3 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-9)),'n \t \t ',num2str(C2/(1e-6)),'u \t \t ',num2str(R1_Value),'\t \t ',          num2str(R2_Value/(1e+3)),'k \t \t', num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
                
                    else
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-9)),'n \t \t ',num2str(C2/(1e-6)),'u \t \t ',num2str(R1_Value),'\t \t ',          num2str(R2_Value),'\t \t',          num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
                    
                    end                
            
                elseif C1>=1e-9 && C2>=1e-9
                
                    if R1>=1e+6  && R2>=1e+6  
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-9)),'n \t \t ',num2str(C2/(1e-9)),'n \t \t ',num2str(R1_Value/(1e+6)),'M \t \t ',num2str(R2_Value/(1e+6)),'M \t \t ', num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
                
                    elseif R1>=1e+6  && R2>=1e+3 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-9)),'n \t \t ',num2str(C2/(1e-9)),'n \t \t ',num2str(R1_Value/(1e+6)),'M \t \t ',num2str(R2_Value/(1e+3)),'k \t\t ',  num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
               
                    elseif R1>=1e+6  && R2>=0 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-9)),'n \t \t ',num2str(C2/(1e-9)),'n \t \t ',num2str(R1_Value/(1e+6)),'M \t \t ',num2str(R2_Value),'\t \t',           num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
            
                    elseif R1>=1e+3  && R2>=1e+6 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-9)),'n \t \t ',num2str(C2/(1e-9)),'n \t \t ',num2str(R1_Value/(1e+3)),'k \t \t ',num2str(R2_Value/(1e+6)),'M \t \t',  num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
            
                    elseif R1>=1e+3  && R2>=1e+3 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-9)),'n \t \t ',num2str(C2/(1e-9)),'n \t \t ',num2str(R1_Value/(1e+3)),'k \t \t ',num2str(R2_Value/(1e+3)),'k \t \t',  num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
            
                    elseif R1>=1e+3  && R2>=0 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-9)),'n \t \t ',num2str(C2/(1e-9)),'n \t \t ',num2str(R1_Value/(1e+3)),'k \t \t ',num2str(R2_Value),'\t \t',           num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])

                    elseif R1>=0  && R2>=1e+6 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-9)),'n \t \t ',num2str(C2/(1e-9)),'n \t \t ',num2str(R1_Value),' \t \t ',        num2str(R2_Value/(1e+6)),'M \t \t',  num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])

                    elseif R1>=0  && R2>=1e+3 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-9)),'n \t \t ',num2str(C2/(1e-9)),'n \t \t ',num2str(R1_Value),'\t \t ',         num2str(R2_Value/(1e+3)),'k \t \t',  num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
                    
                    else
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-9)),'n \t \t ',num2str(C2/(1e-9)),'n \t \t ',num2str(R1_Value),'\t \t ',         num2str(R2_Value),'\t \t',           num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
                    
                    end                
            
                elseif C1>=1e-9 && C2>=1e-12
                
                    if R1>=1e+6  && R2>=1e+6  
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-9)),'n \t \t ',num2str(C2/(1e-12)),'p \t \t ',num2str(R1_Value/(1e+6)),'M \t \t ',num2str(R2_Value/(1e+6)),'M \t \t ',num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
                
                    elseif R1>=1e+6  && R2>=1e+3 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-9)),'n \t \t ',num2str(C2/(1e-12)),'p \t \t ',num2str(R1_Value/(1e+6)),'M \t \t ',num2str(R2_Value/(1e+3)),'k \t\t ', num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
               
                    elseif R1>=1e+6  && R2>=0 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-9)),'n \t \t ',num2str(C2/(1e-12)),'p \t \t ',num2str(R1_Value/(1e+6)),'M \t \t ',num2str(R2_Value),'\t \t',          num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
            
                    elseif R1>=1e+3  && R2>=1e+6 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-9)),'n \t \t ',num2str(C2/(1e-12)),'p \t \t ',num2str(R1_Value/(1e+3)),'k \t \t ',num2str(R2_Value/(1e+6)),'M \t \t', num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
            
                    elseif R1>=1e+3  && R2>=1e+3 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-9)),'n \t \t ',num2str(C2/(1e-12)),'p \t \t ',num2str(R1_Value/(1e+3)),'k \t \t ',num2str(R2_Value/(1e+3)),'k \t \t',num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
            
                    elseif R1>=1e+3  && R2>=0 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-9)),'n \t \t ',num2str(C2/(1e-12)),'p \t \t ',num2str(R1_Value/(1e+3)),'k \t \t ',num2str(R2_Value),'\t \t',          num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])

                    elseif R1>=0  && R2>=1e+6 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-9)),'n \t \t ',num2str(C2/(1e-12)),'p \t \t ',num2str(R1_Value),' \t \t ',        num2str(R2_Value/(1e+6)),'M \t \t', num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])

                    elseif R1>=0  && R2>=1e+3 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-9)),'n \t \t ',num2str(C2/(1e-12)),'p \t \t ',num2str(R1_Value),'\t \t ',         num2str(R2_Value/(1e+3)),'k \t \t', num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
                    
                    else
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-9)),'n \t \t ',num2str(C2/(1e-12)),'p \t \t ',num2str(R1_Value),'\t \t ',         num2str(R2_Value),'\t \t',          num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
                    
                    end

                elseif C1>=1e-12 && C2>=1e-6
                
                    if R1>=1e+6  && R2>=1e+6  
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-12)),'p \t \t ',num2str(C2/(1e-6)),'u \t \t ',num2str(R1_Value/(1e+6)),'M \t \t ',num2str(R2_Value/(1e+6)),'M \t \t ', num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
                
                    elseif R1>=1e+6  && R2>=1e+3 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-12)),'p \t \t ',num2str(C2/(1e-6)),'u \t \t ',num2str(R1_Value/(1e+6)),'M \t \t ',num2str(R2_Value/(1e+3)),'k \t\t ',num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
               
                    elseif R1>=1e+6  && R2>=0 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-12)),'p \t \t ',num2str(C2/(1e-6)),'u \t \t ',num2str(R1_Value/(1e+6)),'M \t \t ',num2str(R2_Value),'\t \t',          num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
            
                    elseif R1>=1e+3  && R2>=1e+6 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-12)),'p \t \t ',num2str(C2/(1e-6)),'u \t \t ',num2str(R1_Value/(1e+3)),'k \t \t ',num2str(R2_Value/(1e+6)),'M \t \t', num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
            
                    elseif R1>=1e+3  && R2>=1e+3 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-12)),'p \t \t ',num2str(C2/(1e-6)),'u \t \t ',num2str(R1_Value/(1e+3)),'k \t \t ',num2str(R2_Value/(1e+3)),'k \t \t', num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
            
                    elseif R1>=1e+3  && R2>=0 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-12)),'p \t \t ',num2str(C2/(1e-6)),'u \t \t ',num2str(R1_Value/(1e+3)),'k \t \t ',num2str(R2_Value),'\t \t',          num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])

                    elseif R1>=0  && R2>=1e+6 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-12)),'p \t \t ',num2str(C2/(1e-6)),'u \t \t ',num2str(R1_Value),' \t \t ',        num2str(R2_Value/(1e+6)),'M \t \t', num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])

                    elseif R1>=0  && R2>=1e+3 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-12)),'p \t \t ',num2str(C2/(1e-6)),'u \t \t ',num2str(R1_Value),'\t \t ',         num2str(R2_Value/(1e+3)),'k \t \t', num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
                    
                    else
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-12)),'p \t \t ',num2str(C2/(1e-6)),'u \t \t ',num2str(R1_Value),'\t \t ',         num2str(R2_Value),'\t \t',          num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
                    
                    end            

                elseif C1>=1e-12 && C2>=1e-9
                
                    if R1>=1e+6  && R2>=1e+6  
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-12)),'p \t \t ',num2str(C2/(1e-9)),'n \t \t ',num2str(R1_Value/(1e+6)),'M \t \t ',num2str(R2_Value/(1e+6)),'M \t \t ', num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
                
                    elseif R1>=1e+6  && R2>=1e+3 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-12)),'p \t \t ',num2str(C2/(1e-9)),'n \t \t ',num2str(R1_Value/(1e+6)),'M \t \t ',num2str(R2_Value/(1e+3)),'k \t\t ', num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
               
                    elseif R1>=1e+6  && R2>=0 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-12)),'p \t \t ',num2str(C2/(1e-9)),'n \t \t ',num2str(R1_Value/(1e+6)),'M \t \t ',num2str(R2_Value),'\t \t',          num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
            
                    elseif R1>=1e+3  && R2>=1e+6 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-12)),'p \t \t ',num2str(C2/(1e-9)),'n \t \t ',num2str(R1_Value/(1e+3)),'k \t \t ',num2str(R2_Value/(1e+6)),'M \t \t', num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
            
                    elseif R1>=1e+3  && R2>=1e+3 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-12)),'p \t \t ',num2str(C2/(1e-9)),'n \t \t ',num2str(R1_Value/(1e+3)),'k \t \t ',num2str(R2_Value/(1e+3)),'k \t \t', num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
            
                    elseif R1>=1e+3  && R2>=0 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-12)),'p \t \t ',num2str(C2/(1e-9)),'n \t \t ',num2str(R1_Value/(1e+3)),'k \t \t ',num2str(R2_Value),'\t \t',          num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
    
                    elseif R1>=0  && R2>=1e+6 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-12)),'p \t \t ',num2str(C2/(1e-9)),'n \t \t ',num2str(R1_Value),' \t \t ',        num2str(R2_Value/(1e+6)),'M \t \t', num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])

                    elseif R1>=0  && R2>=1e+3 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-12)),'p \t \t ',num2str(C2/(1e-9)),'n \t \t ',num2str(R1_Value),'\t \t ',         num2str(R2_Value/(1e+3)),'k \t \t', num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
                    
                    else
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-12)),'p \t \t ',num2str(C2/(1e-9)),'n \t \t ',num2str(R1_Value),'\t \t ',         num2str(R2_Value),'\t \t',          num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
                    
                    end
            
                elseif C1>=1e-12 && C2>=1e-12
                
                    if R1>=1e+6  && R2>=1e+6  
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-12)),'p \t \t ',num2str(C2/(1e-12)),'p \t \t ',num2str(R1_Value/(1e+6)),'M \t \t ',num2str(R2_Value/(1e+6)),'M \t \t ', num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
                
                    elseif R1>=1e+6  && R2>=1e+3 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-12)),'p \t \t ',num2str(C2/(1e-12)),'p \t \t ',num2str(R1_Value/(1e+6)),'M \t \t ',num2str(R2_Value/(1e+3)),'k \t\t ', num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
               
                    elseif R1>=1e+6  && R2>=0 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-12)),'p \t \t ',num2str(C2/(1e-12)),'p \t \t ',num2str(R1_Value/(1e+6)),'M \t \t ',num2str(R2_Value),'\t \t',         num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
            
                    elseif R1>=1e+3  && R2>=1e+6 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-12)),'p \t \t ',num2str(C2/(1e-12)),'p \t \t ',num2str(R1_Value/(1e+3)),'k \t \t ',num2str(R2_Value/(1e+6)),'M \t \t',num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
                
                    elseif R1>=1e+3  && R2>=1e+3 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-12)),'p \t \t ',num2str(C2/(1e-12)),'p \t \t ',num2str(R1_Value/(1e+3)),'k \t \t ',num2str(R2_Value/(1e+3)),'k \t \t',num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
            
                    elseif R1>=1e+3  && R2>=0 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-12)),'p \t \t ',num2str(C2/(1e-12)),'p \t \t ',num2str(R1_Value/(1e+3)),'k \t \t ',num2str(R2_Value),'\t \t',         num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])

                    elseif R1>=0  && R2>=1e+6 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-12)),'p \t \t ',num2str(C2/(1e-12)),'p \t \t ',num2str(R1_Value),' \t \t ',        num2str(R2_Value/(1e+6)),'M \t \t',num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])

                    elseif R1>=0  && R2>=1e+3 
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-12)),'p \t \t ',num2str(C2/(1e-12)),'p \t \t ',num2str(R1_Value),'\t \t ',         num2str(R2_Value/(1e+3)),'k \t \t', num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
                    
                    else
                        fprintf (['\t \t \t \t \t',num2str(C1/(1e-12)),'p \t \t  ',num2str(C2/(1e-12)),'p \t \t',num2str(R1_Value),'\t \t ',         num2str(R2_Value),'\t \t',          num2str(abs(R1-R1_Value)/R1*100),'%%','\t \t',num2str(abs(R2-R2_Value)/R2*100),'%%','\n'])
                    
                    end
                    
                end
                
                end            	
            	  
                end           
                         
        end
    
    end
end


Continue = input('\n \n Do you want to Try different error percentage- \n \n          1-Yes          2-No      :');

    if Continue ==1
        H = 1;
        clc;
    else
        H = 0;
        clc;
    end
    
    
end

Continue = input('\n \n Do you want to try other filter- \n \n          1-Yes          2-No      :');

    if Continue ==1
        clc;
        K = 1;
    else
        clc;
        K = 0;
    end
    
    
end


clc;
close all;
clear all;

Total_filter_coefficient = 1;
