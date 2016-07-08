%%%-------------------------------------------------------------------
%% @doc prime_number_producer top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(prime_number_producer_sup).

-include("definitions.hrl").

-behaviour(supervisor).

%% API
-export([start_link/1]).

%% Supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).

%%====================================================================
%% API functions
%%====================================================================
%%				module with init/1
-spec start_link(Settings :: settings()) -> ignore | {error, any()} | {ok, pid()}.
start_link(Settings) ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, Settings).

%%====================================================================
%% Supervisor callbacks
%%====================================================================

%% Child :: {Id,StartFunc,Restart,Shutdown,Type,Modules}
-spec init(Settings :: settings()) -> {ok, {#{}, [#{}]}}.
init(Settings) ->
    SupFlags = #{strategy => one_for_one,
                 intensity => 100,
                 period => 1},
    ChildSpecs = [#{
                   id => server_proc,
                   start => {producer_server, start_link, Settings},
                   restart => transient,
                   modules => [producer_server]
                   }],
    {ok, {SupFlags, ChildSpecs} }.

%%====================================================================
%% Internal functions
%%====================================================================
