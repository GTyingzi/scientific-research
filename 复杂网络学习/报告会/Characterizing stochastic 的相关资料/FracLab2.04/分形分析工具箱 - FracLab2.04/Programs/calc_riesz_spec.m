function [ varargout ] = calc_riesz_spec(func, K, N, b, phase, varargin)
%CALC_RIESZ_SPEC Calculates the spectrum of a Riesz product with random phases
%  FUNC  : a string containing the base function
%  K     : the order of the product
%  N     : resolution
%  B     : basis
%  PHASE : random phases
%  Q     : points where to calculate the Legendre transform
%
%  Attention: the chosen function must no take zero values.
%
%

if nargin==5
    q=-20:0.1:20;
else
    q=varargin{0};
end

if nargout > 4
    error('Too many output arguments.')    
end

q = q(:);

z = calc_riesz_int(func, K, N, b, phase);
z_K = z(N*b);

z_q = calc_riesz_spectre(func, K, N, b, phase, q);
z_q = z_q(:);

d = 1/(K*log(b));
a = 1+d*log(z_K);
tau_q = -1 + a.*q - d.*log(z_q);

[lt, s]= flt(q,tau_q);

if nargout == 0
    figure,
    subplot(211), plot(q, tau_q, 'k.','markersize',0.5)
    subplot(212), plot(s,lt, 'k.','markersize',0.5)
end
if nargout >= 1
    varargout{1} = lt;
end
if nargout >= 2
    varargout{2} = s;
end
if nargout >= 3
    varargout{3} = tau_q;
end
if nargout >= 4
    varargout{4} = q;
end

