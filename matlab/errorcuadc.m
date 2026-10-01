function [m,n,r,dm,dn]=errorcuadc(x,y,ddx,ddy,color)
% Ajuste de mínimos cuadrados
%   "ajuste de valores experimentales a una recta"
%  [m,n,r,dm,dn]=errorcuadc(x,y,ddx,ddy,color)
%
%  Entradas:                        Salidas:
%   x-variable independiente         m-pendiente del ajuste
%   y-variable dependiente           n-corte 0Y del ajuste
%                                    r-coef. de regresión
%
% m=(N·sxy-sx·sy)/(N·sxx-sx²)
% n=(sy·sxx-sx·sxy)/(N·sxx-sx²)
% r=(N·sxy-sx·sy)/√[(N·sxx-sx²)·(N·syy-sy²)]

X=x; Y=y; dX=ddx; dY=ddy;
s=size(y);
rows=s(1);
cols=s(2);
szx=size(x);
sdx=size(ddx);
if szx(1)<rows
    if rem(rows,szx(1))==0
        for tm=2:(rows/szx(1))
            X=[X;x];
        end
    end
    if sdx(1)<rows && rem(rows,sdx(1))==0
        for tm=2:(rows/sdx(1))
            dX=[dX;ddx];
        end
    end
end
m=zeros(rows,1); n=m; r=m; dm=m; dn=m;

for rw=1:rows
    x=X(rw,:); 
    ddx=dX(rw,:); 
    y=Y(rw,:); 
    ddy=dY(rw,:);

  if length(x)==length(y)
    N=length(x);
                sx=sum(x);
                sy=sum(y);
    xx=x.^2;    sxx=sum(xx);
    xy=x.*y;    sxy=sum(xy);
    yy=y.^2;    syy=sum(yy);

    dx=N.*sxx-sx.^2;
    dy=N.*syy-sy.^2; 
    %dd=N.*sxy-sx*sy;

    m(rw)=(N.*sxy-sx.*sy)./dx;      %disp(['m= ',num2str(m)])
    n(rw)=(sy.*sxx-sx.*sxy)./dx;    %disp(['n= ',num2str(n)])
    r(rw)=m(rw).*sqrt(dx./dy);          %disp(['r= ',num2str(r)])

    f=m(rw).*x+n(rw); var=y-f; 
    dm(rw)=sqrt((N*sum(var.^2))/((N-2)*dx));
    dn(rw)=dm(rw)*sqrt(sxx/N);

    %x0=x(1); y0=y(1); ms=zeros(1,N-1);
    %for k=1:(N-1)
    %   ms(1,k)=(y(1,k)-y0)/(x(1,k)-x0)
    %end
    %m_max=max(ms); m_min=min(ms);
    %dms=(m_max-m_min)/2;
    %dmsf=C*dm^e    


    %% Representación
    hold on; plot(x,f,color,LineWidth=2);
    hold on; errorbar(x,y,ddy,-ddy,ddx,-ddx,'k',"LineStyle","none",LineWidth=1.5); 
    hold on; 
    %plot(x,y,'.k')
    %title('')
    %xlabel('')
    %ylabel('')
    %legend('','','location','best')

  elseif length(x)>length(y)
    a=length(x)-length(y);
    txt=['x tiene ',num2str(a),' elementos más que y'];
    error(txt)

  else
    a=length(y)-length(x);
    txt=['y tiene ',num2str(a),' elementos más que x'];
    error(txt)
  end

end