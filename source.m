[x,fs] = audioread('test.wav'); % fs: frequency
% x_int = round(x(:,1) .* 1024 - 1);
N = length(x);              % length of signal
t = (0:N-1)/fs;
totalDuration = N / fs;

soundsc(x,fs); %%%play the tones

% chuy?n th�nh c�c frame, t�nh energy, n?u l?n h?n threshold cho tr??c s?
% ch?n
inc = 250;
x_frame=enframe(x(:,1), 500, inc)';
energy = sum(x_frame .* x_frame);
maxE = max(energy);
idxE = find(energy > maxE * 0.8);

% g?p nh?ng frame g?n nhau
idxE = [idxE 9999];
Z = [];
tmp = idxE(1);
for i = 1:length(idxE) - 1
    if idxE(i + 1) - idxE(i) > 1
        Z = [Z; [tmp idxE(i)]];
        tmp = idxE(i+1);
    end
end

% v?i m?i nh�m frame, l� c�c t�n hi?u dtmf, g?i h�m detect ?? detect
result = [];
for i = 1:length(Z)
    left = (Z(i,1) - 1) * inc + 1;
    right = (Z(i,2) - 1) * inc + 1;
    digit = detect(x(left:right), fs);
   
    % disp(digit);
    result = [result digit];
end
disp(result);

% segment=findSegment(idxE);
% 
% result = [];
% for i = 1:length(segment)
%     left = (segment(i).begin - 1) * inc + 1;
%     right = (segment(i).end - 1) * inc + 1;
%     digit = detect(x(left:right), fs);
%     
%     % disp(digit);
%     result = [result digit];
% end
% disp(result);

