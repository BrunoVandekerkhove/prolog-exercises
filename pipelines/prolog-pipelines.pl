%% NAME
%% NUMBER
%% PROGRAM

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PART I: pumpjacks.


pumpjack_output(_,_,_) :-
    fail.

outputs(_) :-
    fail.

overlaps_pumpjack(_,_,_) :-
    fail.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PART II: Neighbours & Shortest Paths

neighbour(_,_,_,_) :-
    fail.

shortest_path(Target,Source,Distance) :-
    shortest_path(Target,[qi(Source,0)],[],Distance).

shortest_path(_,_,_,_) :-
    fail.

shortest_paths(_,_) :-
    fail.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PART III: finding the minimal spanning tree

minimal_spanning_tree(_,_,_) :-
    fail.

iterate_edges(_,_,_,_) :-
    fail.

plan(MST) :-
    outputs(Outputs),
    shortest_paths(Outputs,Paths),
    minimal_spanning_tree(Outputs,Paths,MST).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% DO NOT EDIT BELOW THIS LINE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Predicates to create, test and unify labels. 

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
