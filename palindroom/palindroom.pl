%%%
%%% PALINDROMEN
%%%

% Vraag 1

allesgelijk(Invoer, Kost, Uitvoer) :-
    list_to_set(Invoer, Uniek), % Geen duplicaten ...
    findall(V-E, (member(E,Uniek),voorkomen(E,Invoer,0,V)), Voorkomens),
    max_member(K-_, Voorkomens),
    member(K-Element, Voorkomens),
    length(Invoer, L),
    Kost is L - K,
    findall(Element, between(1,L,_), Uitvoer).

voorkomen(_, [], V, V).
voorkomen(E, [I|Invoer], Acc, V) :-
    (I == E -> NewAcc is Acc + 1 ; NewAcc is Acc),
    voorkomen(E, Invoer, NewAcc, V).

% Vraag 2

palindroom(Invoer, Kost, Uitvoer) :-
    reverse(Invoer, Omkering),
    findall(S, (member(E,Invoer),sequentie(E,Invoer,Omkering,S)), Ss),
    list_to_set(Ss, Sequenties),
    vervangsequenties(Invoer, Sequenties, 0, Kost, Invoer, Uitvoer).

vervangsequenties(_, [], KostAcc, Kost, Uitvoer, Uitvoer) :- Kost is KostAcc.
vervangsequenties(Invoer, [S|Sequenties], KostAcc, Kost, UitvoerAcc, Uitvoer) :-
    allesgelijk(S, K, [E|_]),
    vervang(UitvoerAcc, S, E, [], NieuwUitvoer),
    vervangsequenties(Invoer, Sequenties, KostAcc + K, Kost, NieuwUitvoer, Uitvoer).

vervang([], _, _, Acc, Uitvoer) :- reverse(Acc,Uitvoer).
vervang([U|Us], S, E, Acc, Uitvoer) :-
    (member(U,S) -> NewAcc = [E|Acc] ; NewAcc = [U|Acc]),
    vervang(Us, S, E, NewAcc, Uitvoer).

sequentie(E, Invoer, Omkering, Sequentie) :-
    matches([E], Invoer, Omkering, [], Matches),
    findall(El, (member(El,Invoer),member(El,Matches)), Sequentie).

matches([], _, _, Matches, Matches).
matches([E|Elements], Invoer, Omkering, Acc, Matches) :-
    findall(M, match(E, Invoer, Omkering, [E|Acc], M), Ms),
    append(Ms, Elements, NEs),
    matches(NEs, Invoer, Omkering, [E|Acc], Matches).
match(Element, Invoer, Omkering, Exclusions, Match) :-
    nth0(X, Invoer, Element),
    nth0(X, Omkering, Match),
    \+ member(Match, Exclusions).