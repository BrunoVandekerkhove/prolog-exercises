%
%   ASSIGNMENT 1
%

% Decode the given list of codes.
decode(N, Codes, Res) :-
    decode(N, 0, Codes, [], ResReverse),
    reverse(ResReverse, Res).
decode(0, _, [], Res, Res).
decode(N, Index, Codes, AccumulatedRes, Res) :-
    NewN is N - 1,
    0 =< NewN,
    prefix(NewCode, Codes),
    length(NewCode, Length),
    0 < Length,
    no_prefix(NewCode, AccumulatedRes),
    delete_prefix(NewCode, Codes, NewCodes),
    NewIndex is Index + 1,
    decode(NewN, NewIndex, NewCodes, [Index-NewCode|AccumulatedRes], Res).

% Make sure the given code is not a prefix for an already used code (or vice versa).
no_prefix(_, []).
no_prefix(Code, [_-OtherCode|OtherCodes]) :-
    \+ prefix(Code, OtherCode),
    \+ prefix(OtherCode, Code),
    no_prefix(Code, OtherCodes).

% Delete the given prefix from a given list.
%   Assumes that Prefix is actually one.
delete_prefix([], List, List).
delete_prefix([Element|Elements], [Element|ListElements], List) :-
    delete_prefix(Elements, ListElements, List).

%
%   ASSIGNMENT 2
%

best(N, Codes, Freqs, Res) :-
    findall(PossibleRes, decode(N, Codes, PossibleRes), ResList),
    best(ResList, Freqs, inf, [], BestRes),
    member(Res, BestRes).
best([], _, _, BestRes, BestRes).
best([Res|ResList], Freqs, MaxLength, CurrentBestRes, BestRes) :-
    decode_length(Res, Freqs, Length),
    (Length < MaxLength ->
        NewCurrentBestRes = [Res],
        NewMaxLength is Length
    ;   (Length == MaxLength ->
            NewCurrentBestRes = [Res|CurrentBestRes]
        ;
            NewCurrentBestRes = CurrentBestRes
        )
    ),
    best(ResList, Freqs, NewMaxLength, NewCurrentBestRes, BestRes).

% Get the length of the given encoding for the given frequency table.
decode_length(Res, Freqs, Length) :-
    decode_length(Res, Freqs, 0, Length).
decode_length([], _, Length, Length).
decode_length([N-Code|Res], [N-Freq|Freqs], CurrentLength, Length) :-
    length(Code, CodeLength),
    CharacterLength is CodeLength * Freq,
    NewCurrentLength is CurrentLength + CharacterLength,
    decode_length(Res, Freqs, NewCurrentLength, Length).
