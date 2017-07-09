function TOCpred=callpassey(depth,GR,ILD,DT,LOM,RTbase,DTbase,ndata)

DLogR=[];
DLog=0;
for i=1:ndata;
    if GR(i)>-999.25
    elseif ILD(i)>-999.25
    elseif DT(i)>-999.25
        DLog=log10*(ILD(i)/RTbase)+0.02*(DT(i)-DTbase);
    else
        DLog==0;
    end
    DLogR=[DLogR;DLog];
end
TOCpred=DLogR';