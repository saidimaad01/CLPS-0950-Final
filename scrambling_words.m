%scrambling words %Creates a new cell to store the scrambled words
wordsToScramble = cell(1, 25);
wordsToScramble{1,1} = ['k' 'n' 'i' 'f' 'e'];
wordsToScramble{1,2} = ['a' 'r' 't' 'i' 's' 't'];
wordsToScramble{1,3} = ['p' 'a' 'i' 'n' 't' 'e' 'r'];
wordsToScramble{1,4} = ['c' 'h' 'e' 'f'];
wordsToScramble{1,5} = ['v' 'e' 'r' 'd' 'a' 'n' 't'];
wordsToScramble{1,6} = ['c' 'r' 'e' 'a' 't' 'i' 'o' 'n'];
wordsToScramble{1,7} = ['b' 'u' 'i' 'l' 'd' 'i' 'n' 'g'];
wordsToScramble{1,8} = ['t' 'e' 'a' 's' 'e'];
wordsToScramble{1,9} = ['b' 'u' 'b' 'b' 'l' 'e' 's'];
wordsToScramble{1,10} = ['c' 'o' 'f' 'f' 'e' 'e'];
wordsToScramble{1,11} = ['s' 'u' 's' 'h' 'i'];
wordsToScramble{1,12} = ['b' 'o' 'o' 'k' 's' 't' 'o' 'r' 'e'];
wordsToScramble{1,13} = ['o' 'f' 'f' 'i' 'c' 'e'];
wordsToScramble{1,14} = ['f' 'l' 'a' 'g'];
wordsToScramble{1,15} = ['n' 'a' 't' 'i' 'o' 'n'];
wordsToScramble{1,16} = ['l' 'a' 'k' 'e'];
wordsToScramble{1,17} = ['p' 'o' 'n' 'd'];
wordsToScramble{1,18} = ['f' 'a' 'm' 'i' 'l' 'y'];
wordsToScramble{1,19} = ['m' 'o' 't' 'h' 'e' 'r'];
wordsToScramble{1,20} = ['o' 'k' 'r' 'a'];
wordsToScramble{1,21} = ['b' 'a' 'n' 'k'];
wordsToScramble{1,22} = ['k' 'a' 'b' 'o' 'b'];
wordsToScramble{1,23} = ['y' 'e' 'l' 'l' 'o' 'w'];
wordsToScramble{1,24} = ['v' 'e' 'g' 'a' 'n'];
wordsToScramble{1,25} = ['c' 'l' 'e' 'm' 'e' 'n' 't' 'i' 'n' 'e'];
for i = 1:randi(25,1)
    inputScramble = char(wordsToScramble(1,i)); %uses list wordsToScramble as the input list
    outputScramble = randomizeStr(inputScramble);
    if outputScramble ~= inputScramble
        scrambledWords{1,i} = outputScramble;
    else 
        outputScramble = randomizeStr(inputScramble);
        scrambledWords{1,i} = outputScramble;
    end
end 
disp(inputScramble)