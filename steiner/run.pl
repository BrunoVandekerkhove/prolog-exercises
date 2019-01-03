loadfiles :-
    ['solution'], % If needed, edit your name file here
    ['steinerfacts'].

test_assignment_1 :-
	writeln("SOLUTION ASSIGNMENT 1: EDGES"),
	edges([a,b,c,g],L) ->
		writeln(L)
	;
		writeln(fail).

test_assignment_2 :-
	writeln("SOLUTION ASSIGNMENT 2: SORTING"),
	sort_edges([e(a,c,5.0),e(a,b, 3.0), e(c,g, 2.5)],L) ->
		writeln(L)
	;
		writeln(fail).

test_assignment_3 :-
	writeln("SOLUTION ASSIGNMENT 3: PATH IN FOREST"),
	(path(a,g,[e(a,c,5.0),e(b,c,4.0),e(e,f,2.0),e(b,g,2.5)]) ->
		writeln("succes: (a,g) was found")
	;
		writeln(fail)),
	(path(_,_,_),
	\+ path(b,f,[e(a,c,5.0),e(b,c,4.0),e(e,f,2.0),e(b,g,2.5)]) ->
		writeln("succes: (b,f) was not found")
	;
		writeln(fail)
	).

test_assignment_4 :-
	writeln("SOLUTION ASSIGNMENT 4: MINIMAL SPANNING TREE"),
	(mst([a,b,c,d],Tree) ->
		writeln(Tree)
	;
		writeln(fail)
	).


test_assignment_5 :-
	writeln("SOLUTION ASSIGNMENT 5: TREELENGTH"),
	(treelength([e(a, b, 3.0), e(b, c, 4.0)],L) ->
		write("length of tree: "),
		write(L),
		writeln(" (expected length = 7.0)")
	;
		writeln(fail)
	).

test_assignment_6 :-
	writeln("SOLUTION ASSIGNMENT 6: STEINER TREE"),
	(steiner([a,b,c,d],[e,f,g,h,i],1,Tree1),treelength(Tree1,L1) ->
		write("Tree = "),
		writeln(Tree1),
		write("L = "),
		writeln(L1)
	;
		writeln(fail)
	),
	(steiner([a,b,c,d],[e,f,g,h,i],2,Tree2),treelength(Tree2,L2) ->
		write("Tree = "),
		writeln(Tree2),
		write("L = "),
		writeln(L2)
	;
		writeln(fail)
	),
	(steiner([a,b,c,d],[e,f,g,h,i],3,Tree3),treelength(Tree3,L3) ->
		write("Tree = "),
		writeln(Tree3),
		write("L = "),
		writeln(L3)
	;
		writeln(fail)
	).

lineskip :-
	writeln('').

:- loadfiles.
:- test_assignment_1.
:- lineskip.
:- test_assignment_2.
:- lineskip.
:- test_assignment_3.
:- lineskip.
:- test_assignment_4.
:- lineskip.
:- test_assignment_5.
:- lineskip.
:- test_assignment_6.
:- halt.