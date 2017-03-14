function H = filterbank(nFilters, freqBand, nFFT, fs)
    melLower = 1125 *  log(1 + freqBand(1) / 700);
    melUpper = 1125 * log(1 + freqBand(2) / 700);
    
    melFrequencies = linspace(melLower, melUpper, nFilters + 2)
    linFrequencies = 700 * (exp(melFrequencies ./ 1125) - 1);
    
    f = floor((nFFT + 1) * linFrequencies / fs);
    H = zeros(nFilters, nFFT + 1);
    for m = 2 : length(f) - 1
        for k = 1:nFFT + 1
%             fprintf('m is %d\n', m);
            if (k < f(m - 1))
                H(m, k)=0;
            elseif (k >= f(m - 1) && k <= f(m))
                H(m, k) = (k - f(m - 1)) / ...
                (f(m) - f(m - 1));
            elseif (k >= f(m) && k <= f(m + 1))
                H(m, k) = (f(m + 1) - k) / ...
                    (f(m + 1) - f(m));
            elseif (k > f(m + 1))
                H(m, k) = 0;
            end
        end
    end
end