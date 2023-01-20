-module(factorial).
-export([fac/1]).

fac(N) -> 
	lists:foldl(fun(I,[{X,R}|Q]) -> 
					[{I,R*I},{X,R}|Q] 
				end, [{0,1}], lists:seq(1,N)).