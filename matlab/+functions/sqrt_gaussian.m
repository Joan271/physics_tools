function [fi] = sqrt_gaussian(x,mu,sigma)
fi = 1/sqrt(sigma*sqrt(2*pi)).*exp(-(x-mu).^2/(4*sigma^2));
end
