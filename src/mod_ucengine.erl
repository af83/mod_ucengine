%%%----------------------------------------------------------------------
%%% File    : mod_ucengine.erl
%%% Author  : François de Metz <fdemetz@af83.com>
%%% Purpose : U.C.Engine gateway
%%%
%%%
%%% af83, Copyright (C) 2011 af83
%%%
%%% This program is free software; you can redistribute it and/or
%%% modify it under the terms of the GNU General Public License as
%%% published by the Free Software Foundation; either version 2 of the
%%% License, or (at your option) any later version.
%%%
%%% This program is distributed in the hope that it will be useful,
%%% but WITHOUT ANY WARRANTY; without even the implied warranty of
%%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
%%% General Public License for more details.
%%%
%%% You should have received a copy of the GNU General Public License
%%% along with this program; if not, write to the Free Software
%%% Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
%%% 02111-1307 USA
%%%
%%%----------------------------------------------------------------------

-module(mod_ucengine).
-author('fdemetz@af83.com').

-behaviour(gen_mod).

-include("jlib.hrl").
-include("include/ucengine.hrl").

%% gen_mod callbacks
-export([start/2,
         stop/1]).

%% hooks callbacks
-export([log_packet/3]).

start(Host, Opts) ->
    UCEHost = gen_mod:get_opt(host, Opts),
    UCEPort = gen_mod:get_opt(port, Opts),
    UCEUid = gen_mod:get_opt(uid, Opts),
    UCECredential = gen_mod:get_opt(credential, Opts),

    ucengine_client:start_link(UCEHost, UCEPort),
    ucengine_client:connect(UCEUid, UCECredential),
    ejabberd_hooks:add(user_send_packet, Host, ?MODULE, log_packet, 55),
    ok.

stop(_Host) ->
    ok.

log_packet(From, #jid{user=MucName} = _To, Packet = {xmlelement, "message", Attrs, _Els}) ->
    case xml:get_attr_s("type", Attrs) of
        "groupchat" ->
            send_message(MucName, xml:get_path_s(Packet, [{elem, "body"}, cdata]), From),
            ok;
        _ ->
            ok
    end;
log_packet(_From, _To, _Packet) ->
    ok.

send_message(Location, Body, From) ->
    ucengine_client:publish(#uce_event{location=Location,
                                       type="chat.message.new",
                                       metadata=[{"text", Body},
                                                 {"lang", "en"},
                                                 {"from", jlib:jid_to_string(From)}]}).
