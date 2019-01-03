:- [steinerfacts].


edges(Nodes, Edges):-
	findall(e(X,Y,D), (member(X, Nodes), member(Y, Nodes), X @< Y, distance(X,Y,D)), Edges).


distance(NodeA, NodeB, D) :-
	point(NodeA,X1,Y1),
	point(NodeB,X2,Y2),
	D is sqrt((X1-X2)^2 + (Y1-Y2)^2).


%% Question 2
%% sort the edges by their length

transform(e(A,B,D),D-(A,B)).
reversetransform(D-(A,B),e(A,B,D)).

sort_edges(Edges,SortedEdges) :-
 	maplist(transform,Edges,TransformedEdges),
 	sort(TransformedEdges,SortedTransformedEdges),
 	maplist(reversetransform,SortedTransformedEdges,SortedEdges).

% Alternative:
% sort_edges(Edges, SortedEdges):-
%   sort(3,@<, Edges, SortedEdges).


%% Question 3
%% check if path exists in forest

path(X,Y,Forest) :-
	(member(e(X,Y,_),Forest);member(e(Y,X,_),Forest)),!.
path(X,Y,Forest) :-
	select(e(X,Z,_),Forest,NewForest),
	path(Z,Y,NewForest).
path(X,Y,Forest) :-
	select(e(Z,X,_),Forest,NewForest),
	path(Z,Y,NewForest).


% Question 4:
% Given some nodes, find the minimal spanning tree.
% ?- mst([])
mst(Nodes,MST) :-
	edges(Nodes,Edges),
	sort_edges(Edges,SortedEdges),
	span(SortedEdges,[],MST).

span([],MST,MST).
span([Edge|Edges],Forest,MST) :-
	is_in_forest(Edge,Forest) ->
		span(Edges,Forest,MST)
	;
		span(Edges,[Edge|Forest],MST)
	.

% If there is already a path between X and Y in the existing forest, than
% adding an edge(X,Y,_) would create a loop.
is_in_forest(e(X,Y,_),Forest) :-
	path(X,Y,Forest).

% Question 5:
% Write the treelength predicate that computes the total length
% of a given tree.
treelength(Tree,D) :-
	treelength(Tree,0,D).

treelength([],D,D).
treelength([e(_,_,D)|Edges],DAcc,TotalD) :-
	NDAcc is D + DAcc,
	treelength(Edges,NDAcc,TotalD).

% Question 6
% Given some nodes, and some possible steiner nodes,
% give the minimal steiner tree.
% The minimal steiner tree is the tree with the lowest total length
% and the smallest number of edges
steiner(Nodes,SteinerNodes,K,SteinerTree) :-
	findall(Tree,
		(subsetk(S,SteinerNodes,K),
		append(Nodes,S,UsedNodes),
		mst(UsedNodes,Tree)),
		Trees),
	sortlist(key,Trees,SortedTrees),
	[SteinerTree|_] = SortedTrees.


/* We can do the sorting like this in a general way or we can also define
 a transform/2 and reversetransform/2 predicate like in exercise 2. */

sortlist(Keypred,List,SortedList) :-
	keylist(Keypred,List,KeyList),
	sort(KeyList,SortedKeyList),
	maplist(snd,SortedKeyList,SortedList).

keylist(_,[],[]) :-!.
keylist(Keypred,[X|Xs],[Y-X|Rest]) :-
	G =.. [Keypred,X,Y],
	G,
	keylist(Keypred,Xs,Rest).

snd(_-V,V).

key(Tree,TL-NbEdges) :-
	treelength(Tree,TL),
	length(Tree,NbEdges).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DO NOT EDIT BELOW THIS LINE %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% The subsetk predicate generates all subsets
% with a maximal length of K.

subsetk(SubSet,Set,K) :-
	mysubset(SubSet,Set),
	length(SubSet,L),
	L =< K.

mysubset([],[]):-!.
mysubset(L, [_|S]) :-
    mysubset(L,S).
mysubset([X|L],[X|S]) :-
    mysubset(L,S).
