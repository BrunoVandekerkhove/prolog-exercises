% Geen toffe oplossing, gemaakt met max tijd van 1 uur, zit vol met list operations (lineair of linearitmisch)

color_rectangle(Input, Rect) :-
    findall(X, (member(Row,Input), member(X,Row), X \= '.'), Xs),
    list_to_set(Xs, Cs),
    findall(C-rhk(L,R,U,D), (member(C, Cs),rect(C,Input,L,R,U,D)), Output),
    sort(Output, Rect).

rect(C, Input, L, R, U, D) :-
    findall(I, (nth0(I, Input, Row), member(C, Row)), Is),
    min_list(Is, U0),
    max_list(Is, D0),
    findall(J, (member(Row, Input), nth0(J, Row, C)), Js),
    min_list(Js, L0),
    max_list(Js, R0),
    L is L0 + 1,
    R is R0 + 1,
    U is U0 + 1,
    D is D0 + 1.


% R = [[.,c,c,.],[a,c,c,a],[a,c,c,a]], color_rectangle(R,Rect).
% R = [[b,b,b,6,6,6],[.,5,5,5,x,5],[a,5,5,c,c,5],[a,5,5,c,c,5],[a,6,6,6,6,6]], color_rectangle(R,Rect).

sequence(Input, Volgorde) :-
    color_rectangle(Input, Bounds),
    findall(C, (member(C-Rect, Bounds), C \= '.', contains(C, Rect, Bounds, 0)), Clear),
    % sort(Clear),
    findall(N-C, (member(C-Rect, Bounds), C \= '.', contains(C, Rect, Bounds, N), N > 0), Sol),
    sort(Sol, RevSol),
    reverse(RevSol, SolNC),
    maplist(transform, SolNC, Solution),
    append(Solution, Clear, Volgorde).

transform(_-C, C).

contains(C, Rect, Bounds, N) :- % Contains how many other colors?
    findall(OR, (member(OC-OR, Bounds), OC \= '.', OC \= C, has(Rect, OR)), Colors),
    length(Colors, N).

has(rhk(L1,R1,U1,D1), rhk(L2,R2,U2,D2)) :-
    L1 =< L2,
    R1 >= R2,
    U1 =< U2,
    D1 >= D2.

% R = [[.,c,c,.],[a,c,c,a],[a,c,c,a]], sequence(R,Volgorde).
% R = [[b,b,b,6,6,6],[.,5,5,5,x,5],[a,5,5,c,c,5],[a,5,5,c,c,5],[a,6,6,6,6,6]], sequence(R,Volgorde).


