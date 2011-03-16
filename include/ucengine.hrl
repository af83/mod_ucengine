%% inherited from ucengine api

-record(uce_event, {
          %% Id
          id = none,
          % date (ms from epoch)
          datetime = none,
          %% location
          location = "",
          %% From: uid|brick
          from,
          %% Type event : list
          type,
          %% parent id
          parent = "",
          %% to id
          to = "",
          %% MetaData : list
          metadata = []}).

-define(UCE_API_VERSION, "0.4").
