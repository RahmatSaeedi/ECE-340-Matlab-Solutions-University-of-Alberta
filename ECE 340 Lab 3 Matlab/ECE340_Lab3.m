% Solution by Rahmat Saeedi
%% Main Function
function ECE340_Lab2()
    close all;
    %Q1_ImpulseResponse();
    Q2_LTI_systems();
end
%% Q1 Convolution
function Q1_ImpulseResponse()
    %defining the impulse response function h(n)
    function result=h(n)
        if(n<=0)        %h(n) is causal and onesided with h(0)=0
            result=0;
        else
            PI_6=pi/6;
            result=n.*sin(PI_6 .*n)./(2.^n);
        end
    end
    
    %Computting the impulse response of h(n) directly
    h1=h(0:10);
    
    %Computting the impulse response of h(n) indirectly using builtin
    %ztransform filter function
    N=[0 4 0 -1 0];
    D=[16  -16*sqrt(3)  20  -4*sqrt(3)  1];
    h2=filter(N,D,[1 zeros(1,10)]);
    
    %Plotting the impulse response functions on the same plot
    plot(0:10,h1,'b+');
    hold on
    plot(0:10,h2,'go')
    xlabel('n from 0 to 10');
    ylabel('Impulse Response h_1[n] & h_2[n]');
    title('Impulse Response of given h(n)');
    legend('h_1[n]','h_2[n]');
end
function Q2_LTI_systems()
    %Annonymous functions that rerurns the frequency response of H1 and H2
    %transfer functions
    H1_frequency_Response=@(w) (2+2.*exp(-1i.*w))./(1-1.25.*exp(-1i.*w));
    H2_frequency_Response=@(w) (2+2.*exp(-1i.*w))./(1-0.75.*exp(-1i.*w));
    
    %Definning the numerator and denominators of H1 and H2
    H1_N=[2 2];
    H1_D=[1 -1.25];
    H2_N=[2 2];
    H2_D=[1 -0.75];
    
   %Finding the poles and zeroes of the ztranfer functions
   [Z1, P1 , ~]=tf2zpk(H1_N, H1_D);
   [Z2, P2 , ~]=tf2zpk(H2_N, H2_D);
   Z1=1./Z1; P1=1./P1;
   Z2=1./Z2; P2=1./P2;
   
   %Plotting the poles and zeroes of the ztransfer functions
   figure
   zplane(Z1,P1);
   legend('Zeros of H_1(z)','Poles of H_1(z)');
   figure
   zplane(Z2,P2);
   legend('Zeros of H_2(z)','Poles of H_2(z)');

   %Computing the frequency response of the systems
   w=linspace(0,2*pi,200);
   H1_freq_resp_mag=abs(H1_frequency_Response(w));
   H1_freq_resp_phase=angle(H1_frequency_Response(w));
   H2_freq_resp_mag=abs(H2_frequency_Response(w));
   H2_freq_resp_phase=angle(H2_frequency_Response(w));
   
   %Plotting the frequency responses of the systems
   figure
   subplot(2,1,1)
   plot(w,H1_freq_resp_mag,'-');
    xlabel('Frequency, w, (rad)');
    ylabel('Magnitude of H_1(w)');
    legend('|H_1(w)|','location','north');
   subplot(2,1,2)
   plot(w,H1_freq_resp_phase,'--');
    xlabel('Frequency, w, (rad)');
    ylabel('Phase of H_1(w),  (rad)');
    legend('\angle H_1(w)','location','southeast');
   figure
   subplot(2,1,1)
   plot(w,H2_freq_resp_mag,'-');
    xlabel('Frequency, w, (rad)');
    ylabel('Magnitude of H_2(w)');
    legend('|H_2(w)|','location','north');
   subplot(2,1,2)
   plot(w,H2_freq_resp_phase,'--');
    xlabel('Frequency, w, (rad)');
    ylabel('Phase of H_2(w),  (rad)');
    legend('\angle H_2(w)','location','southeast');
    
   %Using inverse-zetransform to compute impulse response
   syms z n;
   H1=(2+2*z^-1)/(1-1.25*z^-1);
   H2=(2+2*z^-1)/(1-0.75*z^-1);
   h1=iztrans(H1,z,n);
   h2=iztrans(H2,z,n);
   
   %Evaluate and plot the impulse responses
   n=0:25;
   figure
   plot(n,subs(h1));
    xlabel('n from 0 to 25');
    ylabel('Impulse Response h_1[n]');
   figure
   plot(n,subs(h2));
    xlabel('n from 0 to 25');
    ylabel('Impulse Response h_2[n]');
end