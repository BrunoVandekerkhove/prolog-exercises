%
% Assignment 1
%

maximalChains(MaxChains) :- 
        findall(chain(MaxChain), maximalChain(MaxChain), MaxChains).
maximalChain(Chain) :-
        gt(_, LastNode),
        \+ gt(LastNode, _),
        expandChain([LastNode], LastNode, Chain).

expandChain(Nodes, LastNode, Chain) :-
        gt(Node, LastNode),
        expandChain([Node|Nodes], Node, Chain).
expandChain(Chain, LastNode, Chain) :-
        \+ gt(_, LastNode).

%
% Assignment 2
%

mainarizumu(Solution) :-
        size(N),
        mainarizumu(N, 0, 0, [], Solution).
mainarizumu(N, 0, N, Solution, Solution).
mainarizumu(N, X, Y, Accumulator, Solution) :-
        Y < N,
        between(1, N, Z),
        NewAssignment = at(X,Y,Z),
        \+ invalid_gt(NewAssignment, Accumulator),
        \+ invalid_differ(NewAssignment, Accumulator),
        \+ member(at(X,_,Z), Accumulator),
        \+ member(at(_,Y,Z), Accumulator),
        NewX is X + 1,
        (NewX >= N ->
                NewY is Y + 1,
                mainarizumu(N, 0, NewY, [NewAssignment|Accumulator], Solution)
        ; 
                mainarizumu(N, NewX, Y, [NewAssignment|Accumulator], Solution)
        ).

invalid_gt(at(X,Y,Z), Assignments) :-
        gt((OtherX,OtherY),(X,Y)),
        member(at(OtherX,OtherY,OtherZ), Assignments),
        OtherZ =< Z.
invalid_gt(at(X,Y,Z), Assignments) :-
        gt((X,Y),(OtherX,OtherY)),
        member(at(OtherX,OtherY,OtherZ), Assignments),
        Z =< OtherZ.

invalid_differ(at(X,Y,Z), Assignments) :-
        differ((X,Y),(OtherX,OtherY),V),
        member(at(OtherX,OtherY,OtherZ), Assignments),
        Diff is abs(Z-OtherZ),
        V \= Diff.
invalid_differ(at(X,Y,Z), Assignments) :-
        differ((OtherX,OtherY),(X,Y),V),
        member(at(OtherX,OtherY,OtherZ), Assignments),
        Diff is abs(Z-OtherZ),
        V \= Diff.

%
% Assignment 3
%

island(Board, (X,Y), Isle) :- 
        island(Board, [(X,Y)], [], [(X,Y)], Isle).
island(_, [], _, Isle, Isle).
island(Board, [(X,Y)|ToVisit], Visited, Accumulator, Isle) :-
        member(at(X,Y,Z), Board),    
        findall((U,V), (valid_neighbor(Board,(X,Y,Z),(U,V)), \+ member((U,V),Visited)), Neighbors),
        append(ToVisit, Neighbors, NewToVisit),
        append(Accumulator, Neighbors, NewAccumulator),
        island(Board, NewToVisit, [(X,Y)|Visited], NewAccumulator, Isle).

valid_neighbor(Board, (X,Y,Z), (U,V)) :-
        neighbor((X,Y),(U,V)),
        member(at(U,V,W), Board),
        Diff is abs(W - Z),
        1 is Diff.
        
neighbor((X,Y),(U,V)) :-
        (U is X - 1 ; U is X + 1),
        V is Y.
neighbor((X,Y),(U,V)) :-
        (V is Y - 1 ; V is Y + 1),
        U is X.
