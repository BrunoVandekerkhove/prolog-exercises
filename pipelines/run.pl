:- use_module(library(lists)).

writeall([],_,_).
writeall([X|R],Prefix,Postfix) :-
    write(Prefix),
    write(X),
    writeln(Postfix),
    writeall(R,Prefix,Postfix).

    loadfiles :-
    ['prolog-pipelines-facts.pl'],
    ['prolog-pipelines.pl'].

test_assignment_1 :-
    findall((X,Y), pumpjack_output(pumpjack(1,1,north),X,Y), L1),
    writeln('\nOPLOSSING VOOR OPDRACHT 1.1:'),
    writeall(L1, '   ',''),
    findall((X,Y), pumpjack_output(pumpjack(1,1,east),X,Y), L2),
    writeln('\nOPLOSSING VOOR OPDRACHT 1.2:'),
    writeall(L2, '   ',''),
    findall((X,Y), pumpjack_output(pumpjack(1,1,south),X,Y), L3),
    writeln('\nOPLOSSING VOOR OPDRACHT 1.3:'),
    writeall(L3, '   ',''),
    findall((X,Y), pumpjack_output(pumpjack(1,1,west),X,Y), L4),
    writeln('\nOPLOSSING VOOR OPDRACHT 1.4:'),
    writeall(L4, '   ','').


% OPLOSSING VOOR OPDRACHT 1.1:
%    2,3
%
% OPLOSSING VOOR OPDRACHT 1.2:
%    3,0
% OPLOSSING VOOR OPDRACHT 1.3:
%    0,-1
% OPLOSSING VOOR OPDRACHT 1.4:
%    0,2


test_assignment_2 :-
    findall(Outputs,outputs(Outputs),L1),
    writeln('\nOPLOSSING VOOR OPDRACHT 2'),
    writeall(L1, '   ','').

% OPLOSSING VOOR OPDRACHT 2.1:
%    [(2,3),(5,5),(4,16),(20,7)]


test_assignment_3 :-
    findall(yes,overlaps_pumpjack(pumpjack(1,1,north),0,0) ,L1),
    writeln('\nOPLOSSING VOOR OPDRACHT 3.1:'),
    writeall(L1, '   ',''),
    findall(yes,overlaps_pumpjack(pumpjack(1,1,east),0,0) ,L2),
    writeln('\nOPLOSSING VOOR OPDRACHT 3.2:'),
    writeall(L2, '   ',''),
    findall(no,\+overlaps_pumpjack(pumpjack(3,6,east),0,1) ,L3),
    writeln('\nOPLOSSING VOOR OPDRACHT 3.3:'),
    writeall(L3, '   ',''),
    findall(no,\+overlaps_pumpjack(pumpjack(3,6,east),5,16) ,L4),
    writeln('\nOPLOSSING VOOR OPDRACHT 3.4:'),
    writeall(L4, '   ','').


% OPLOSSING VOOR OPDRACHT 3.1:
%    yes
%
% OPLOSSING VOOR OPDRACHT 3.2:
%    yes
%
% OPLOSSING VOOR OPDRACHT 3.3:
%    no
%
% OPLOSSING VOOR OPDRACHT 3.4:
%    no


test_assignment_4 :-
    findall((NX,NY),neighbour(2,3,NX,NY), Neighbours),
    writeln('\nOPLOSSING VOOR OPDRACHT 4:'),
    writeall(Neighbours, '   ','').

% OPLOSSING VOOR OPDRACHT 4:
%    3,3
%    1,3,
%    2,4


test_assignment_5 :-
    findall(D,shortest_path((5,4),[qi((2,3),0)],[],D),L1),
    writeln('\nOPLOSSING VOOR OPDRACHT 5.1:'),
    writeall(L1, '   ',''),
    findall(D,shortest_path((1,6),[qi((5,6),0)],[],D),L2),
    writeln('\nOPLOSSING VOOR OPDRACHT 5.2:'),
    writeall(L2, '   ',''),
    findall(D,shortest_path((5,4),[qi((2,3),1)],[],D),L3),
    writeln('\nOPLOSSING VOOR OPDRACHT 5.3:'),
    writeall(L3, '   ','').

% OPLOSSING VOOR OPDRACHT 5.1:
%    4
%
% OPLOSSING VOOR OPDRACHT 5.2:
%    8
%
% OPLOSSING VOOR OPDRACHT 5.3:
%    5
%
	    

test_assignment_6 :-
    findall(Paths,shortest_paths([(2,3),(5,5)],Paths),L1),
    writeln('\nOPLOSSING VOOR OPDRACHT 6:'),
    writeall(L1, '   ','').

% OPLOSSING VOOR OPDRACHT 6:
%    [edge(5,(2,3),(5,5)),edge(5,(5,5),(2,3))]


test_assignment_7 :-
    findall(MST,(create_labels([(2,3),(5,5),(4,16)],Labels),
		 Edges = [edge(5,(2,3),(5,5)),
			  edge(12,(4,16),(5,5)),
			  edge(17,(2,3),(4,16))],
		 iterate_edges(Edges,Labels,[],MST)
		),
	    L1),
    writeln('\nOPLOSSING VOOR OPDRACHT 7:'),
    writeall(L1, '   ','').

% OPLOSSING VOOR OPDRACHT 7:
%    [edge(12,(4,16),(5,5)),edge(5,(2,3),(5,5)),]


test_assignment_8 :-
    findall(MST,plan(MST),L1),
    writeln('\nOPLOSSING VOOR OPDRACHT 8:'),
    writeall(L1, '   ','').

% OPLOSSING VOOR OPDRACHT 8:
%    [edge(17,(5,5),(20,7)),edge(12,(4,16),(5,5)),edge(5,(2,3),(5,5))]


:- loadfiles.
:- test_assignment_1.
:- test_assignment_2.
:- test_assignment_3.
:- test_assignment_4.
:- test_assignment_5.
:- test_assignment_6.
:- test_assignment_7.
:- test_assignment_8.
:- halt.
