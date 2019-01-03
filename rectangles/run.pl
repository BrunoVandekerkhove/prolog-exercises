:- use_module(library(lists)).

writeall(List) :- writeall(List,' ','').
writeall([],_,_).
writeall([X|R],Prefix,Postfix) :-
write(Prefix),
write(X),
writeln(Postfix),
writeall(R,Prefix,Postfix).


writeNrDiffs(List) :-
sort(List,SortedList),
length(SortedList,Len),
writeln(Len).


loadfiles :-
[myprolog].

test_opdracht_1 :-
R1 = [[.,c,c,.],
[a,c,c,a],
[a,c,c,a]],
findall(Rect, color_rectangle(R1,Rect), L1),
writeln('\nALLE OPLOSSINGEN VOOR OPDRACHT 1.1: [a-rhk(1, 4, 2, 3), c-rhk(2, 3, 1, 3)]'),
writeall(L1),

R2 =
[[b,b,b,6,6,6],
[.,5,5,5,x,5],
[a,5,5,c,c,5],
[a,5,5,c,c,5],
[a,6,6,6,6,6]],
findall(Rect, color_rectangle(R2,Rect), L2),
%Rect = [5-rhk(2, 6, 2, 4), 6-rhk(2, 6, 1, 5), a-rhk(1, 1, 3, 5),
% b-rhk(1, 3, 1, 1), c-rhk(4, 5, 3, 4), x-rhk(5, 5, 2, 2)]
writeln('\nALLE OPLOSSINGEN VOOR OPDRACHT 1.2:[5-rhk(2, 6, 2, 4), 6-rhk(2, 6, 1, 5), a-rhk(1, 1, 3, 5), b-rhk(1, 3, 1, 1), c-rhk(4, 5, 3, 4), x-rhk(5, 5, 2, 2)] '),
writeall(L2),

R3 =
[ [4,4],
[7,4]],
findall(Rect, color_rectangle(R3,Rect), L3),
%Rect = [4-rhk(1, 2, 1, 2), 7-rhk(1, 1, 2, 2)]
writeln('\nALLE OPLOSSINGEN VOOR OPDRACHT 1.3: [4-rhk(1, 2, 1, 2), 7-rhk(1, 1, 2, 2)]'),
writeall(L3),

R4 =
[ [.,4,3],
[7,.,3]],
findall(Rect, color_rectangle(R4,Rect), L4),
writeln('\nALLE OPLOSSINGEN VOOR OPDRACHT 1.4:[3-rhk(3,3,1,2),4-rhk(2,2,1,1),7-rhk(1,1,2,2)]'),
writeall(L4).




test_opdracht_2 :-
writeln('Start 2'),
R1 = [[.,c,c,.],
[a,c,c,a],
[a,c,c,a]],
findall(Rect, sequence(R1,Rect), L1),
writeln('\nALLE OPLOSSINGEN VOOR OPDRACHT 2.1: [a,c]'),
writeall(L1),

R2 =
[[b,b,b,6,6,6],
[.,5,5,5,x,5],
[a,5,5,c,c,5],
[a,5,5,c,c,5],
[a,6,6,6,6,6]],
findall(Rect, sequence(R2,Rect), L2),
writeln('\nALLE OPLOSSINGEN VOOR OPDRACHT 2.2: [6,5,a,b,c,x] '),
writeall(L2),

R3 =
[ [4,4],
[7,4]],
findall(Rect, sequence(R3,Rect), L3),
writeln('\nALLE OPLOSSINGEN VOOR OPDRACHT 2.3: [4,7]'),
writeall(L3),

R4 =
[ [.,4,3],
[7,.,3]],
findall(Rect, sequence(R4,Rect), L4),
writeln('\nALLE OPLOSSINGEN VOOR OPDRACHT 2.4: [3,4,7]'),
writeall(L4).




:- loadfiles.
:- test_opdracht_1.
:- test_opdracht_2.
:- halt.
