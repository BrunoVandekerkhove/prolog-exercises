

decode(N_,Codes_,Res) :-
  decode(N_,0,Codes_,[],RRes),
  reverse(RRes,Res).

decode(N_,N_,[],CurScheme_,CurScheme_).
decode(N_,CurN_,Codes_,CurScheme_,Res) :-
  % Guard, CurN < N (backtracking from base case)
  CurN_ < N_,
  % Step 1: Pick a code for CurN
  pickCode(NewCode,RemainingCodes,Codes_),
  NewCode \== [],
  % Step 2: Check prefix constraint on generated code
  checkPrefix(NewCode,CurScheme_),
  % Step 3: execute recursively
  NewN is CurN_ + 1,
  decode(N_,NewN,RemainingCodes,[CurN_-NewCode|CurScheme_],Res).

pickCode(NewC,RemainingC,Codes_) :-
  getPrefix(NewC,Codes_),
  append(NewC,RemainingC,Codes_).

getPrefix([],_).
getPrefix([X|Rest1],[X|Rest2]) :-
  getPrefix(Rest1,Rest2).

checkPrefix(_,[]).
checkPrefix(Code_,[_-CodeList|RestScheme]) :-
  % 1) check prefix for Code vs de CodeList
  not(getPrefix(Code_,CodeList)),
  not(getPrefix(CodeList,Code_)),
  % 2) call recursively
  checkPrefix(Code_,RestScheme).

  
best(N_,Codes_,Freqs_,Res) :-
  % 1) Collect solution from decode
  findall(Scheme,decode(N_,Codes_,Scheme),AllSchemes),
  % 2) Calculate best cost
  getBest(AllSchemes,Freqs_,BestCost),
  % 3) Retrieve all solutions with that cost
  member(BestScheme,AllSchemes),
  hasCost(BestScheme,Freqs_,BestCost).
  
hasCost(Scheme_,Freqs_,Cost) :-
  % find all costs of individual characters
  findall(CharCost,(member(Char-Code,Scheme_),getCharCost(Char,Code,Freqs_,CharCost)), AllCharCosts),
  % sum those costs
  sum_list(AllCharCosts,Cost).


getCharCost(Char_,Code_,Freqs_,Cost) :-
  member(Char_-Freq,Freqs_),
  length(Code_,LenCode),
  Cost is Freq * LenCode.

getBest([],_,_).
getBest([Scheme|RestSch],Freqs_,BestCost) :-
  hasCost(Scheme,Freqs_,CurBest),
  getBest(RestSch,Freqs_,CurBest,BestCost).
  
getBest([],_,CurBest,CurBest).
getBest([Scheme|RestSch],Freqs_,CurBest_,BestCost) :-
  hasCost(Scheme,Freqs_,NewCost),
  NewCost < CurBest_,
  getBest(RestSch,Freqs_,NewCost,BestCost).
getBest([Scheme|RestSch],Freqs_,CurBest_,BestCost) :-
  hasCost(Scheme,Freqs_,NewCost),
  NewCost >= CurBest_,
  getBest(RestSch,Freqs_,CurBest_,BestCost).

altGetBest(Schemes_,Freqs_,BestCost) :-
  findall(Cost,(member(Scheme,Schemes),hasCost(Scheme,Freqs_,Cost)),AllCosts),
  min_list(AllCosts,BestCost).











  
  
  
  
  
  
  
  
  
  
  
  