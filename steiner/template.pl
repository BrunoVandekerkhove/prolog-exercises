%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CHANGE THIS TO YOUR OWN PERSONAL INFO %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Jan Jansen
% r0123456
% master cw
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% Uncomment this for debugging.
%:- [steinerfacts].


%% Question 1:
%% Generate all edges of the fully connected graph of the given nodes.

% edges(Nodes,Edges)
edges(_,_) :- fail.


%% Question 2
%% Sort the edges by their length

% sort_edges(Edges,SortedEdges)
sort_edges(_,_) :- fail.


%% Question 3
%% Check if path exists in forest

% path(A,B,Forest)
path(_,_,_) :- fail.


%% Question 4:
%% Given some nodes, find the minimal spanning tree.

% mst(Nodes,MST)
mst(_,_) :- fail.


%% Question 5:
%% Write the treelength predicate that computes the total length
%% of a given tree.

% treelength(Tree,L)
treelength(_,_) :- fail.


%% Question 6
%% Given some nodes, and some possible steiner nodes,
%% find the minimal steiner tree.
%% The minimal steiner tree is the tree with 
%% the lowest total length and the smallest number of edges

% steiner(Nodes,SteinerNodes,K,Tree)
steiner(_,_,_,_) :- fail.




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
