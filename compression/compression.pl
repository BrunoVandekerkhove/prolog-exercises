code([a,b], 1).
code([b,e], 2).
code([b,c,d,e], 3).
code([b,c], 4).
code([c,d],5).
code([a,b,c],6).

%
% Assignment 1
%

decompress(Compressed, Decompressed) :-
    decompress(Compressed, [], Decompressed).
decompress([], Decompressed, Decompressed).
decompress([Code|Codes], CurrentDecompression, Decompressed) :-
    (code(Decoding,Code) ->
        append(CurrentDecompression, Decoding, NewCurrentDecompression)
    ;
        append(CurrentDecompression, [Code], NewCurrentDecompression)
    ),
    decompress(Codes, NewCurrentDecompression, Decompressed).

%
% Assignment 2
%

compress(Uncompressed, Compressed) :-
    compress(Uncompressed, [], Compressed).
compress([], Compressed, Compressed).
compress(Uncompressed, CurrentCompression, Compressed) :-
    prefix_code(Uncompressed, NewUncompressed, N),
    append(CurrentCompression, [N], NewCurrentCompression),
    compress(NewUncompressed, NewCurrentCompression, Compressed).
compress([Symbol|Uncompressed], CurrentCompression, Compressed) :-
    \+ prefix_code([Symbol|Uncompressed], _, _),
    append(CurrentCompression, [Symbol], NewCurrentCompression),
    compress(Uncompressed, NewCurrentCompression, Compressed).
prefix_code(Uncompressed, NewUncompressed, N) :-
    prefix(Code, Uncompressed),
    length(Code, CodeLength),
    CodeLength > 0,
    code(Code, N),
    append(Code, NewUncompressed, Uncompressed).

%
% Assignment 3
%

optcompression(Uncompressed, Compressed) :-
    findall(L-C, (compress(Uncompressed, C), length(C,L)), Compressions),
    sort(Compressions, [LMin-C|SortedCompressions]),
    member(LMin-Compressed, [LMin-C|SortedCompressions]).