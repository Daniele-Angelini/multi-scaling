function H = scaleH(x,y,q)

%dato un processo x definito nello spazio delle y (non necessariamente)
%uniforme, questo programma stima l'esponente di Hurst con un metodo
%di multiscaling con parametro di scala q.
%Nel caso di supporto non uniforme, si procede a fare una interpolazione
%dei delle x su un nuovo supporto uniforme. 

x_uniform = linspace(min(x),max(x),1000);
y_uniform = interp1(x, y, x_uniform, 'linear');
s0 = 1;
s_final = floor(length(x_uniform)/2);
s = linspace(s0,s_final,s_final-s0);
for i = s(1):s(end)-1
    flag = y_uniform(i+1:end)-y_uniform(1:end-i);
    mu = mean(flag);
    F(i-s(1)+1) = mean(abs((flag-mu)).^q);
end
F = (F/F(1)).^(1/q);
X = log(s);
Y = log(F);
%plot(X,Y,'o');
%hold on
p1 = polyfit(X,Y,1);
Yfit = polyval(p1,X);
%plot(X,Yfit,'r');
beta = (Yfit(end)-Yfit(1))/(X(end)-X(1));
H = beta;
