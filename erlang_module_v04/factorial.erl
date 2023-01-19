-module(factorial).
-export([fac/1]).


fac(N) ->
	fac(1, N, 1).

fac(Current, N, Result) when Current =< N ->
	NewResult = Result*Current,
	io:format("~w yields ~w!~n", [Current, NewResult]),
	fac(Current+1, N, NewResult);

fac(_, _, Result) ->
	io:format("Finished.~n"),
	Result.
