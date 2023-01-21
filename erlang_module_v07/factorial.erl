-module(factorial).

-export([start/1, ping/5, pong/0]).

getPid(Pids, CurrentId) when length(Pids) >= CurrentId ->
	
	{lists:nth(CurrentId, Pids), CurrentId+1};
getPid(Pids, _CurrentId) ->
	{lists:nth(1, Pids), 2}.
	


ping(Current, N, Result,Pids,CurrentPidId)  when Current =< N ->
    {Pong_PID,NewCurrentPidId} = getPid(Pids, CurrentPidId),

    
    Pong_PID ! {ping, self(), Current, Result},
    receive
        {pong, NewResult} ->
            ping(Current+1, N, NewResult,Pids,NewCurrentPidId)
    end;

ping(_Current, _N, Result,_,_) ->
	io:format("Result = ~w~n", [Result]).

pong() ->
    receive
        {ping, Ping_PID, Current, Result} ->
            Ping_PID ! {pong, Current*Result},
			pong()
    end.

start(N) ->
    Pids = [ spawn_link(factorial, pong, []) || _X <- lists:seq(1, erlang:system_info(logical_processors_available))],
    spawn(factorial, ping, [1, N, 1,Pids,1]).