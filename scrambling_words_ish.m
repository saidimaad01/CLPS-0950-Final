%scrambling words while keeping the first and last letters the same
scrambledWords_ish = cell(1,25); %Creates a new cell to store the scrambled words; make the second number equal to the length of the word scrambling list
for i = 1:25 %make the second number the length of the word list
    inputScramble2 = char(wordsToScramble(1,i)); %uses list wordsToScramble as the input list
    outputScramble2 = scrambleish(inputScramble2); 
    if outputScramble2 ~= inputScramble2
        scrambledWords_ish{1,i} = outputScramble2;
    else 
        outputScramble2 = scrambleish(inputScramble2);
        scrambledWords_ish{1,i} = outputScramble2;
    end
end 