-module(factorial).

-export([start/1, ping/3, pong/0]).

ping(Current, N, Result)  when Current =< N ->
    Pong_PID = spawn_link(factorial, pong, []),
    Pong_PID ! {ping, self(), Current, Result},
    receive
        {pong, NewResult} ->
            ping(Current+1, N, NewResult)
    end;

ping(_Current, _N, Result) ->
	io:format("Result = ~w~n", [Result]).

pong() ->
    receive
        {ping, Ping_PID, Current, Result} ->
            Ping_PID ! {pong, Current*Result}
    end.

start(N) ->
    spawn(factorial, ping, [1, N, 1]).