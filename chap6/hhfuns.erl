-module(hhfuns).
-export([map/2, filter/2, fold/3, reverse/1, map2/2, filter2/2]).  
map(_, []) -> [];
map(F, [H|T]) -> [F(H)|map(F, T)].

filter(Pred, L) -> lists:reverse(filter(Pred, L, [])).

filter(_, [], Acc) -> Acc;
filter(Pred, [H|T], Acc) ->
  case Pred(H) of
    true -> filter(Pred, T, [H|Acc]);
    false -> filter(Pred, T, Acc)
  end.

fold(_, Start, []) -> Start;
fold(F, Start, [H|T]) -> fold(F, F(H, Start), T).

reverse(L) ->
  fold(fun(X, Acc) -> [X|Acc] end, [], L).

map2(F, L) ->
  reverse(fold(fun(X, Acc) -> [F(X)|Acc] end, [], L)).

filter2(Pred, L) ->
  F = fun(X, Acc) ->
          case Pred(X) of
            true -> [X|Acc];
            false -> Acc
          end
      end,
  reverse(fold(F, [], L)).
