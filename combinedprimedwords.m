%Priming word lists
combinedprime = cell(1,25);
combinedprime{1,1} = ['b' 'o' 't' 't' 'l' 'e'];
combinedprime{1,2} = ['j' 'a' 'c' 'k' 'e' 't'];
combinedprime{1,3} = ['l' 'i' 'b' 'r' 'a' 'r' 'y'];
combinedprime{1,4} = ['p' 'a' 'p' 'e' 'r'];
combinedprime{1,5} = ['f' 'e' 'r' 'n' 's'];
combinedprime{1,6} = ['h' 'e' 'a' 't'];
combinedprime{1,7} = ['p' 'l' 'a' 'n' 'e' 't'];
combinedprime{1,8} = ['p' 'a' 'i' 'n' 't'];
combinedprime{1,9} = ['p' 'e' 'n'];
combinedprime{1,10} = ['t' 'e' 'x' 't' 'b' 'o' 'o' 'k'];
combinedprime{1,11} = ['c' 'o' 'm' 'p' 'u' 't' 'e' 'r'];
combinedprime{1,12} = ['d' 'u' 'm' 'b' 'e' 'l' 'l'];
combinedprime{1,13} = ['b' 'r' 'e' 'a' 'd'];
combinedprime{1,14} = ['w' 'a' 't' 'e' 'r'];
combinedprime{1,15} = ['a' 'v' 'o' 'c' 'a' 'd' 'o'];
combinedprime{1,16} = ['l' 'e' 'm' 'o' 'n' 'a' 'd' 'e'];
combinedprime{1,17} = ['a' 'u' 'b' 'e' 'r' 'g' 'i' 'n' 'e'];
combinedprime{1,18} = ['p' 'o' 'p' 's' 'i' 'c' 'l' 'e'];
combinedprime{1,19} = ['c' 'a' 'n' 'd' 'y'];
combinedprime{1,20} = ['j' 'e' 'l' 'l' 'y' ];
combinedprime{1,21} = ['p' 'a' 's' 't' 'a'];
combinedprime{1,22} = ['b' 'u' 'r' 'g' 'e' 'r'];
combinedprime{1,23} = ['s' 'o' 'u' 'p'];
combinedprime{1,24} = ['t' 'o' 'm' 'a' 't' 'o'];
combinedprime{1,25} = ['c' 'a' 'p' 's' 'i' 'c' 'u' 'm'];

combinedprimeshuffled = combinedprime(randperm(numel(combinedprime)));
for i = 1:randi(25,1)
    allprimedWords = char(combinedprimeshuffled(1,i));
end
disp(allprimedWords)