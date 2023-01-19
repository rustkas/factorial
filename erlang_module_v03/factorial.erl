-module(factorial).
-export([fac/1]).


fac(N) when N > 1 ->
    io:format("Calling from ~w.~n", [N]),
	Result = N * fac(N-1),
	io:format("~w yields ~w.~n", [N, Result]),
	Result;

fac(N) when N =< 1 ->
    io:format("Calling from 1.~n"),
	io:format("1 yields 1.~n"),
	1.
