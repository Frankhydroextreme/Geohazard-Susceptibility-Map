data=load('G:\projects\codes\hot\ygafactors.txt');
%data=data_load(:,2:14);
[N, D]=size(data);
%The correlation coefficient between the solution dimensions
[rho,pval]= corr(data, 'type','pearson');

 matrixplot(rho,'TextColor','k','FigShap','d','FigSize','Full','ColorBar','on','FigStyle','Triu');
