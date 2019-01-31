function digit=detect(x,fs)
    symbol = {'1','2','3','4','5','6','7','8','9','*','0','#'};
    lowFrequency = [697 770 852 941];
    highFrequency = [1209 1336 1477];
    F  = [];
    for i=1:4
        for j=1:3
            tmp = [lowFrequency(i) highFrequency(j)];
            F = [F; tmp];
        end
    end

    idx=1:((fs/2)*(length(x) / fs));    
    ft = abs(fft(x));                        
    [value,i]=max(ft(idx));    
    f1= i / (length(x) / fs);
    
    near = 10;
    ft(i-near:i+near) = 0;
    
    [value,i]=max(ft(idx));
    f2 = i / (length(x) / fs);
    
    fHigh = max(f1, f2);
    fLow = min(f1, f2);
    
    idxLow = 1;
    for i = 1:4
        if abs(fLow - lowFrequency(i)) < 25
            idxLow = i;
        end
    end
    
    idxHigh = 1;
    for i = 1:3
        if abs(fHigh - highFrequency(i)) < 25
            idxHigh = i;
        end
    end
    
    % fprintf('%d %d\n',fLow,fHigh);
    
    digit = '-';
    for i = 1:12
        if lowFrequency(idxLow) == F(i,1) && highFrequency(idxHigh) == F(i,2)
            digit = symbol(i);
        end
    end   