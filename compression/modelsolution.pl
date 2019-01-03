decompress(Compressed, Decompressed):-
	decompress(Compressed, [], Decompressed).

decompress([], Acc, Acc).

decompress([C|T], Acc, Decompressed):-
	code(Orig, C),
	append(Acc,Orig, NewAcc),
	decompress(T, NewAcc, Decompressed).

decompress([C|T], Acc, Decompressed):-
	\+ integer(C),
	append(Acc, [C], NewAcc),
	decompress(T, NewAcc, Decompressed).


compress(Uncompressed, Compressed):-
	compress(Uncompressed, [], Compressed).

compress([], Acc, RevAcc):-
	reverse(Acc, RevAcc).

compress(Uncompressed, Acc, Compressed) :-
	findall(Id-T, (code(Code, Id), append(Code, T, Uncompressed)), Poss),
	length(Poss, NbPos),
	NbPos > 0,
	!,
	member(Id-T, Poss),
	compress(T, [Id|Acc], Compressed).

compress([C|T], Acc, Compressed):-
	compress(T, [C|Acc], Compressed).

optcompression(Uncompressed, Compressed):-
	findall(L-C, (compress(Uncompressed, C), length(C, L)), Poss),
	sort(Poss, [L-C|SortedPossTail]),
	member(L-Compressed, [L-C|SortedPossTail]).
