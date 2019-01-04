-module(station_server).
-compile(export_all).
-include_lib("wx/include/wx.hrl").
%-include_lib("wx/include/wx.hrl").
-import(station, [start/0]).
-import(station_generator, [generate_train/0, generate_platforms/0]).

%idz kursorem do x,y
print({gotoxy, X, Y}) ->
    io:format("\e[~p;~pH", [Y,X]);
%na pozycji x, y wydrukuj msg
print({printxy, X, Y, Msg}) ->
    io:format("\e[~p;~pH~p", [Y,X,Msg]);
%wyczysc ekran
print({clear}) ->
    io:format("\e[2J", []).

printxy({X,Y,Msg}) ->
   io:format("\e[~p;~pH~p~n",[Y,X,Msg]).

%init the app
init() ->
    print({clear}),
    print({printxy, 10, 3, '+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+'}),
    print({printxy, 10, 4, '|S|t|a|c|j|a| |k|o|l|e|j|o|w|a|'}),
    print({printxy, 10, 5, '+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+'}),
    print({printxy, 6, 8, "station_server:auto(): TRYB AUTOMATYCZNY"}),
    print({printxy, 6, 10, "station_server:user(): TRYB UZYTKOWNIKA"}),
    print({gotoxy, 10, 13}),
    io:format("\n",[]),
    Wx = make_window().

  make_window() ->
      Server = wx:new(),
      Frame = wxFrame:new(Server, -1, "Train station simulation", [{size,{1000,500}}]),
      End_Button = wxButton:new(Frame, ?wxID_STOP, [{label, "End simulation"}, {pos, {300,70}}]),
      Platform6 = [{6, wxStaticText:new(Frame, 0, "Peron 6", [{pos, {200, 350}}])}],
      Platform5 = [{5, wxStaticText:new(Frame, 0, "Peron 5", [{pos, {200, 300}}])}|Platform6],
      Platform4 = [{4, wxStaticText:new(Frame, 0, "Peron 4", [{pos, {200, 250}}])}|Platform5],
      Platform3 = [{3, wxStaticText:new(Frame, 0, "Peron 3", [{pos, {200, 200}}])}|Platform4],
      Platform2 = [{2, wxStaticText:new(Frame, 0, "Peron 2", [{pos, {200, 150}}])}|Platform3],
      Platform1 = [{1, wxStaticText:new(Frame, 0, "Peron 1", [{pos, {200, 100}}])}|Platform2],
      PlatformsView = Platform1,


      wxFrame:createStatusBar(Frame),
      wxFrame:show(Frame),

      wxFrame:connect(Frame, close_window),
      wxButton:connect(End_Button, command_button_clicked),
      io:format("TEST"),
      % {Server, Frame, End_Button, Time_Text, ClientsR, ClientsS}.
      {Server, Frame, End_Button, PlatformsView}.


loop() ->
    station_generator:generate_train(),
    timer:apply_after(3000, ?MODULE, loop, []).
%tu sie powinno odpalac tez gui
%tryb automatyczny: generuje losowa ilosc peronow z przedzialu 0-6
%oraz co sekunde generuje pociag o losowej 4-literowej nazwie i losowym czasie
%odjazdu z przedzialu 0-15s
auto() ->
    station:start(),
    PlNo = station_generator:generate_platforms(),
    loop().

%TODO
user() ->
    {ok, [X]} = io:fread("Number of platforms: ","~d"),
    X.
