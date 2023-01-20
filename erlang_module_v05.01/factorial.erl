-module(factorial).
-export([calc/1]).

fact(N) -> fact(1, N, 1). 

fact(0, R,_) -> R;

fact(Current, N, Result) when Current =< N ->
	NewResult = Result*Current,
	fact(Current+1, N, NewResult);

fact(_, _, Result) ->
	Result.

calc(N) ->
    Self = self(),
    Pids = [ spawn_link(fun() -> Self ! {self(), {X, fact(X)}} end)
            || X <- lists:seq(1, N) ],
    [ receive {Pid, R} -> R end || Pid <- Pids ].
