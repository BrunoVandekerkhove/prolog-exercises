%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PART I: pumpjacks.

pumpjack(1,1,north).
pumpjack(3,6,east).
pumpjack(6,15,west).
pumpjack(21,9,south).
% Assume output is always accessible

pumpjack_output(pumpjack(X,Y,north),OX,OY) :-
    OX is X+1, OY is Y + 2.
pumpjack_output(pumpjack(X,Y,east),OX,OY) :-
    OX is X + 2, OY is Y - 1.
pumpjack_output(pumpjack(X,Y,south),OX,OY) :-
    OX is X-1, OY is Y - 2.
pumpjack_output(pumpjack(X,Y,west),OX,OY) :-
    OX is X-2, OY is Y+1.

outputs(Outputs) :-
    findall((OX,OY),
	    (pumpjack(X,Y,Dir),pumpjack_output(pumpjack(X,Y,Dir),OX,OY)),
	    Outputs).

overlaps_pumpjack(pumpjack(PX,PY,_),X,Y) :-
    PX - 1 =< X, X =< PX + 1,
    PY - 1 =< Y, Y =< PY + 1.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PART II: Neighbours & Shortest Paths

neighbour(X,Y,NX,NY) :-
    (
	(NX is X + 1, NY = Y)
    ;
        (NX is X - 1, NY = Y)
    ;
        (NX = X, NY is Y + 1)
    ;
        (NX = X, NY is Y - 1)
    ),
    \+( (pumpjack(PX,PY,Dir),overlaps_pumpjack(pumpjack(PX,PY,Dir),NX,NY)) ).

shortest_path(Target,Source,Distance) :-
    shortest_path(Target,[qi(Source,0)],[],Distance).

shortest_path(_Target,Queue,_Visited,_Distance) :-
    Queue = [],
    !,
    fail.
shortest_path(Target,Queue,_Visited,Distance) :-
    Queue = [qi(Target,DTarget)|_],
    !,
    Distance = DTarget.    
shortest_path(Target,Queue,Visited,Distance) :-
    Queue      = [qi((X,Y),DNode)|RestQueue],
    DNeighbour is DNode + 1,
    findall(qi((NX,NY),DNeighbour),
	    (
		neighbour(X,Y,NX,NY),
		not(member(qi((NX,NY),_),Visited))
	    ),
	    Neighbours),
    append(RestQueue,Neighbours,NewQueue),
    append(Neighbours,Visited,NewVisited),
    shortest_path(Target,NewQueue,NewVisited,Distance).

shortest_paths(Nodes,Paths) :-
    findall(edge(D,N1,N2),
	    (member(N1,Nodes),
	     member(N2,Nodes),
	     N1 \== N2,
	     shortest_path(N1,N2,D)),
	    Paths).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PART III: finding the minimal spanning tree

minimal_spanning_tree(Nodes,Edges,MST) :-
    create_labels(Nodes,Labels),
    sort(Edges,SortedEdges),
    iterate_edges(SortedEdges,Labels,[],MST).

iterate_edges([],_,MSTIn,MSTOut) :- !, MSTIn = MSTOut.
iterate_edges([edge(D,N1,N2)|Edges],Labels,MSTIn,MSTOut) :-
    ( (identical_labels(Labels,N1,N2),
       iterate_edges(Edges,Labels,MSTIn,MSTOut))
    ;
      (\+ identical_labels(Labels,N1,N2),
       unify_labels(Labels,N1,N2),
       iterate_edges(Edges,Labels,[edge(D,N1,N2)|MSTIn],MSTOut))
    ).

plan(MST) :-
    outputs(Outputs),
    shortest_paths(Outputs,Paths),
    minimal_spanning_tree(Outputs,Paths,MST).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Predicates to create, test and unify labels. DO NOT CHANGE.

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
