function [kavg,gavg]= khash(k1,k2,mu1,mu2,f1,f2)

n=length(f1);
kper=1/(k2-k1);
muper=1/(mu2-mu1);
vel1=(k1+(4/3)*mu1);
vel2=(k2+(4/3)*mu2);
kavg=[];
gavg=[];

for i=1:n;
kupper=k1+(f2(i)/(kper+(f1(i)/vel1)));
klower=k2+(f1(i)/(kper+(f2(i)/vel2)));
k(i)=(kupper+klower)/2;

gupper=mu1+(f2(i)/(muper+((2*f1(i)*(k1+2*mu1))/(5*mu1*vel1))));
glower=mu2+(f1(i)/(muper+((2*f2(i)*(k2+2*mu2))/(5*mu2*vel2))));
g(i)=(gupper+glower)/2;

kavg=[kavg k(i)];
gavg=[gavg g(i)];

end
kavg=kavg';
gavg=gavg';
end
