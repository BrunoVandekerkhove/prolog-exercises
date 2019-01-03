pumpjack(1, 1, north).
pumpjack(3, 6, east).
pumpjack(6, 15, west).
pumpjack(21, 9, south).

pumpjack_output(pumpjack(X,Y,north), OutputX, OutputY) :-
    OutputX is X + 1,
    OutputY is Y + 2.
pumpjack_output(pumpjack(X,Y,east), OutputX, OutputY) :-
    OutputX is X + 2,
    OutputY is Y - 1.
pumpjack_output(pumpjack(X,Y,south), OutputX, OutputY) :-
    OutputX is X - 1,
    OutputY is Y - 2.
pumpjack_output(pumpjack(X,Y,west), OutputX, OutputY) :-
    OutputX is X - 2,
    OutputY is Y + 1.

outputs(Outputs) :-
    findall((OutputX,OutputY), (pumpjack(X,Y,Z), pumpjack_output(pumpjack(X,Y,Z), OutputX, OutputY)), Outputs).

overlaps_pumpjack(Pumpjack, X, Y) :-
    pumpjack(PX, PY, _),
    Pumpjack = pumpjack(PX, PY, _),
    close_to(PX, PY, X, Y),
    !.

close_to(X1, Y1, X2, Y2) :-
    2 > abs(X2 - X1),
    2 > abs(Y2 - Y1).

neighbour(X, Y, NX, NY) :-
    is_next(X, Y, NX, NY),
    \+ overlaps_pumpjack(_, NX, NY).
is_next(X, Y, NX, NY) :-
    NX is X - 1,
    NY is Y.
is_next(X, Y, NX, NY) :-
    NX is X + 1,
    NY is Y.
is_next(X, Y, NX, NY) :-
    NX is X,
    NY is Y - 1.
is_next(X, Y, NX, NY) :-
    NX is X,
    NY is Y + 1.

shortest_path(Target,Source,Distance) :-
    shortest_path(Target,[qi(Source,0)],[],Distance).
shortest_path((X,Y), [qi((X,Y),Distance)|_], _, Distance) :- !.
shortest_path(Node, [qi((X,Y),D)|Queue], Visited, Distance) :-
    NewD is D + 1,
    findall(qi((NX,NY),NewD), (neighbour(X,Y,NX,NY), \+ member(qi((NX,NY),_), Visited)), Neighbours),
    append(Queue, Neighbours, NewQueue),
    append(Visited, Neighbours, NewVisited),
    shortest_path(Node, NewQueue, NewVisited, Distance).

shortest_paths([], _).
shortest_paths(Nodes, Paths) :-
    findall(edge(Distance, Node, OtherNode), shortest_paths_helper(Nodes, Node, OtherNode, Distance), Paths).
shortest_paths_helper(Nodes, Node, OtherNode, Distance) :-
    member(Node, Nodes),
    member(OtherNode, Nodes),
    Node \= OtherNode,
    shortest_path(Node, OtherNode, Distance).

iterate_edges([], _, MST, MST).
iterate_edges([edge(D,Node1,Node2)|Edges], Labels, MSTIn, MSTOut) :-
    (identical_labels(Labels, Node1, Node2) ->
        iterate_edges(Edges, Labels, MSTIn, MSTOut)
    ;
        unify_labels(Labels, Node1, Node2),
        iterate_edges(Edges, Labels, [edge(D,Node1,Node2)|MSTIn], MSTOut)
    ).

minimal_spanning_tree(Nodes, Edges, MST) :-
    sort(Edges, SortedEdges),
    create_labels(Nodes, Labels),
    iterate_edges(SortedEdges, Labels, [], MST).

%
% Do not edit below this line
%

plan(MST) :-
    outputs(Outputs),
    shortest_paths(Outputs, Paths),
    minimal_spanning_tree(Outputs, Paths, MST).

create_labels(Nodes,Labels) :- findall(N-_,member(N,Nodes),Labels).
identical_labels(Labels,N1,N2) :-
    member(N1-L1,Labels),
    member(N2-L2,Labels),
    !,
    L1 == L2.
unify_labels(Labels,N1,N2) :-
    member(N1-L1,Labels),
    member(N2-L2,Labels),
    !,
    L1 = L2.