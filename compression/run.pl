:- use_module(library(lists)).

writeall([],_,_).
writeall([X|R],Prefix,Postfix) :-
    write(Prefix),
    write(X),
    writeln(Postfix),
    writeall(R,Prefix,Postfix).

loadfiles :-
    [prolog],
    [compressionfacts].

test_opdracht_1 :-
    findall(D, decompress([2], D), L),
    writeln('\nALLE OPLOSSINGEN VOOR OPDRACHT 1.1:'),
    writeall(L, '   ',''),
    findall(D,(decompress([1,3], [a, b, c, d, e]), D=nil),L2),
    writeln('\nALLE OPLOSSINGEN VOOR OPDRACHT 1.2:'),
    writeall(L2, '   ',''),
    findall(D,decompress([a, 2, c, 3], D),L3),
    writeln('\nALLE OPLOSSINGEN VOOR OPDRACHT 1.3:'),
    writeall(L3, '   ','').

% ALLE OPLOSSINGEN VOOR OPDRACHT 1.1:
%    [b,e]
%
% ALLE OPLOSSINGEN VOOR OPDRACHT 1.2:
%    (niets)
%
% ALLE OPLOSSINGEN VOOR OPDRACHT 1.3:
%    [a,b,e,c,b,c,d,e]


test_opdracht_2 :-
  findall(D, (compress([a,b,c], [1,c]), D=yes), L),
  writeln('\nALLE OPLOSSINGEN VOOR OPDRACHT 2.1:'),
  writeall(L, '   ',''),
  findall(D, (compress([a,b,c], [a,4]), D=nil), L2),
  writeln('\nALLE OPLOSSINGEN VOOR OPDRACHT 2.2:'),
  writeall(L2, '   ',''),
  findall(C,compress([b,c,d,e], C), L3),
  writeln('\nALLE OPLOSSINGEN VOOR OPDRACHT 2.3:'),
  writeall(L3, '   ','').

% ALLE OPLOSSINGEN VOOR OPDRACHT 2.1:
%    yes
%
% ALLE OPLOSSINGEN VOOR OPDRACHT 2.2:
%    (niets)
%
% ALLE OPLOSSINGEN VOOR OPDRACHT 2.3:
%    [3]
%    [4, d, e]

test_opdracht_3 :-
    findall(C,optcompression([a,b,c,d,f], C), L),
    writeln('\nALLE OPLOSSINGEN VOOR OPDRACHT 3.1:'),
    writeall(L, '   ',''),
    findall(C,optcompression([b,c,d,e], C), L2),
    writeln('\nALLE OPLOSSINGEN VOOR OPDRACHT 3.2:'),
    writeall(L2, '   ',''),
    findall(C,(optcompression([a,b,c,d,e], [a, 3]), C=nil), L3),
    writeln('\nALLE OPLOSSINGEN VOOR OPDRACHT 3.3:'),
    writeall(L3, '   ','').

% OPLOSSING VOOR OPDRACHT 3.1:
%    [6, d, f]
%    [1, 5, f]
%
% OPLOSSING VOOR OPDRACHT 3.2:
%    [3]
%
% OPLOSSING VOOR OPDRACHT 3.3:
%    (niets)

:- loadfiles.
:- test_opdracht_1.
:- test_opdracht_2.
:- test_opdracht_3.
:- halt.
