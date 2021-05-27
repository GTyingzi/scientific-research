% Christophe Canus 1998
%
% function [q]=bilogspace(Q,d,q_min,q_max)
%
function [q]=bilogspace(Q,d,q_min,q_max)
if nargin<4
  q_max=+5;
end
if nargin<3
  q_min=-5;
end
if nargin<2
  d=1;
end
if nargin<1
  Q=101;
end
q1=logspace(0,1,floor(Q/2)+1);
q1=fliplr(d-(q1-min(q1))/(max(q1)-min(q1))*abs(q_min-d));
q2=logspace(0,1,Q/2);
q2=d+(q2-min(q2))/(max(q2)-min(q2))*(q_max-d);
q=[q1(1:floor(Q/2)) q2];
return;
