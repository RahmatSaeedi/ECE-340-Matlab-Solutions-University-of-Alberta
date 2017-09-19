function y=sysresp(x, a)
% Solution by Rahmat Saeedi
% y[k]=x[k]+a*y[k-1]
% computes the output in response to an arbitrary input x[n], n=0,¡­N-1
% assumes that the system has 0 initial conditions
% input:
% x: the input signal,
% a: the system parameter
% y: the output signal
N = length(x); % length of the vector
y=zeros(1,N);
for  i=1:1:N-1
    y(i+1)=x(i+1)+a*y(i);
end

return