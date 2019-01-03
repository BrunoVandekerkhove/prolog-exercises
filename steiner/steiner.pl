% Steiner Facts

point(a,1,5).
point(b,4,5).
point(c,4,1).
point(d,1,1).
point(e,2.5,2).
point(f,2.5,4).
point(g,2.5,3).
point(h,6,6).
point(i,1.5,1.5).

%
% Assignment 1
%

edges(Nodes, Edges) :-
    edges(Nodes, [], Edges).
edges([], Edges, Edges).
edges([Node|Nodes], CurrentEdges, Edges) :-
    add_edges(Node, Nodes, CurrentEdges, NewCurrentEdges),
    edges(Nodes, NewCurrentEdges, Edges).

add_edges(_, [], Edges, Edges).
add_edges(Node, [OtherNode|Nodes], CurrentEdges, Edges) :-
    edge(Node, OtherNode, D),
    add_edges(Node, Nodes, [e(Node,OtherNode,D)|CurrentEdges], Edges).

edge(X, Y, D) :-
    point(X, X1, Y1),
    point(Y, X2, Y2),
    \+ X = Y,
    dist(X1, Y1, X2, Y2, D).

dist(X1, Y1, X2, Y2, D) :-
    XDiff is X1 - X2,
    XDiff2 is XDiff * XDiff,
    YDiff is Y1 - Y2,
    YDiff2 is YDiff * YDiff,
    D2 is XDiff2 + YDiff2,
    D is sqrt(D2).

%
% Assignment 2
%

transform(e(A,B,D),D-(A,B)).
reversetransform(D-(A,B),e(A,B,D)).

sort_edges(Edges,SortedEdges) :-
    maplist(transform,Edges,TransformedEdges),
    sort(TransformedEdges,SortedTransformedEdges),
    maplist(reversetransform,SortedTransformedEdges,SortedEdges).

%
% Assignment 3
%

path(A, B, Forest) :-
    path(A, B, Forest, [A]), !.
path(A, B, Forest, _) :-
    member(e(A,B,_), Forest).
path(A, B, Forest, _) :-
    member(e(B,A,_), Forest).
path(A, B, Forest, Visited) :-
    member(e(A,Z,_), Forest),
    \+ member(Z, Visited),
    path(Z, B, Forest, [Z|Visited]).
path(A, B, Forest, Visited) :-
    member(e(Z,A,_), Forest),
    \+ member(Z, Visited),
    path(Z, B, Forest, [Z|Visited]).

%
% Assignment 4
%

mst(Nodes, Tree) :-
    edges(Nodes, Edges),
    sort_edges(Edges, SortedEdges),
    mst(SortedEdges, [], Tree).
mst([], Tree, Tree).
mst([e(A,B,D)|Edges], Forest, Tree) :-
    (path(A, B, Forest) ->
        mst(Edges, Forest, Tree)
    ;
        mst(Edges, [e(A,B,D)|Forest], Tree)
    ).

%
% Assignment 5
%

treelength(Tree, Length) :-
    treelength(Tree, 0, Length).
treelength([], Length, Length).
treelength([e(_,_,D)|Edges], Accumulator, Length) :-
    NewAccumulator is Accumulator + D,
    treelength(Edges, NewAccumulator, Length).

%
% Assignment 6
%

steiner(Nodes, SteinerNodes, K, SteinerTree) :-
    findall(UsedNodes, subsetk(UsedNodes, SteinerNodes, K), UsedNodesList),
    length(UsedNodesList, Length),
    0 < Length,
    steiner_help(Nodes, UsedNodesList, empty, SteinerTree).
steiner_help(_, [], Tree, Tree).
steiner_help(Nodes, [UsedNodes|Rest], CurrentBestTree, BestTree) :-
    append(Nodes, UsedNodes, AllNodes),
    mst(AllNodes, Tree),
    (CurrentBestTree == empty ->
        NewBestTree = Tree
    ;
        best_tree(Tree, CurrentBestTree, NewBestTree)
    ),
    steiner_help(Nodes, Rest, NewBestTree, BestTree).

best_tree(Tree1, Tree2, BestTree) :-
    treelength(Tree1, Length1),
    treelength(Tree2, Length2),
    length(Tree1, Nodes1),
    length(Tree2, Nodes2),
    (Length1 < Length2 ->
        BestTree = Tree1
    ;
        (Nodes1 < Nodes2 ->
            BestTree = Tree1
        ;
            BestTree = Tree2
        )
    ).

%
% Intermezzo
%

% The subsetk predicate generates all subsets
%   with a maximal length of K.

subsetk(SubSet,Set,K) :-
    mysubset(SubSet,Set),
    length(SubSet,L),
    L =< K.

mysubset([],[]):-
    !.
mysubset(L, [_|S]) :-
    mysubset(L,S).
mysubset([X|L],[X|S]) :-
    mysubset(L,S).
