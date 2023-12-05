function DataV=Box_Outlier_eliminating(data,a)
%%% this function is to eliminating outlier with the method of boxplots
%%% we replace the outlier with nan
%%% DataV is the output dataset after eliminating outlier
%%% data is the input matrix
 [m,n]=size(data);
 DataV=nan(m,n);
 for i = 1:n
 Datai=data(:,i);
 aa=Datai;
 Q3=prctile(aa,75);
 Q1=prctile(aa,25);
 IRQ=Q3-Q1;
 Ud=Q3+a*IRQ;
 Ld=Q1-a*IRQ;
 Datai(Datai>Ud | Datai<Ld)=nan;
 DataV(:,i)=Datai;
 end
end