function run()
% Solution by Rahmat Saeedi
%(b)
v0 = 20;
th0 = 45;
h0 = 5;
g = 9.81;
t = linspace(1,4,400);

y = height(t,v0,th0,h0,g)
end
function [x,y,vx,vy] = trajectory(t,v0,th0,h0,g)      

x = v0 .* cos(th0) .* t;
y = h0 + (v0 .* sin(th0) .* t) - ((1./2) .* g .* (t.^2));
vx = v0 .* cos(th0);
vy = (v0 .* sin(th0)) - (g .* t);
end

function y = height(t,v0,th0,h0,g)

[x,y,vx,vy] = trajectory(t,v0,th0,h0,g);  
end

