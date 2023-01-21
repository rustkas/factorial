-module(factorial).

-export([start/1, pong/4]).

calc_fact(_Size, X, N, R) when X > N ->
  R;
calc_fact(Size, X, N, R) ->
  calc_fact(Size, X+Size, N, X*R).

pong(Pid, Size, X, N)  ->
  Pid ! {pong, calc_fact(Size, X,N,1)}.

start(N) ->
    Size = erlang:system_info(logical_processors_available),
    Pids = [ spawn_link(factorial, pong, [self(), Size, X, N]) || X <- lists:seq(1, Size)],
    
    lists:foldl(fun(_I, A) -> 
                      receive 
                        {pong, NewResult} ->
                          NewResult* A
                      end     
                    end, 1, Pids).
