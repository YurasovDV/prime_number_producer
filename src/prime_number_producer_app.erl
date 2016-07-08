%%%-------------------------------------------------------------------
%% @doc prime_number_producer public API
%% @end
%%%-------------------------------------------------------------------

-module(prime_number_producer_app).

-include("include/definitions.hrl").

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%%====================================================================
%% API
%%====================================================================


-spec start(any(), any()) -> none().
start(_StartType, _StartArgs) ->
    {ok, UpperBound} = application:get_env(upper_bound),
    {ok, RedisHost} = application:get_env(redis_host),
    {ok, RedisPort} = application:get_env(redis_port),
    {ok, RedisDb} = application:get_env(redis_db),
    {ok, QueueKey} = application:get_env(queue_key),
    {ok, ResultSetKey} = application:get_env(result_set_key),
    Settings = #settings{
                upper_bound = UpperBound,
                redisHost = RedisHost,
                redis_port = RedisPort,
                redis_db = RedisDb,
                queue_key = QueueKey,
                result_set_key = ResultSetKey
    },
    prime_number_producer_sup:start_link(Settings),
    {ok, self()}.

%%--------------------------------------------------------------------
-spec stop(any()) -> ok.
stop(_State) ->
    ok.

%%====================================================================
%% Internal functions
%%====================================================================
