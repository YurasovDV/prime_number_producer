-export_type([settings/0]).

-record(settings, {
                upper_bound :: integer(),
                redisHost :: string(),
                redis_port :: string(),
                redis_db :: string(),
                queue_key :: string(),
                result_set_key :: string()
    }).

-type settings():: #settings{}.
