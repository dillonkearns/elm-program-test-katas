module TicTacToeTest exposing (all)

import ProgramTest exposing (ProgramTest, check, clickButton, expectView, expectViewHas, fillIn, update)
import Test exposing (..)
import Test.Html.Query as Query
import Test.Html.Selector as Selector exposing (id, tag, text)
import TicTacToe as Main


start : ProgramTest Main.Model Main.Msg (Cmd Main.Msg)
start =
    ProgramTest.createDocument
        { init = Main.init
        , update = Main.update
        , view = Main.view
        }
        |> ProgramTest.start ()


all : Test
all =
    describe "tic tac toe"
        [ test "check a single box" <|
            \() ->
                start
                    |> ProgramTest.within
                        (Query.find [ id "1-1" ])
                        (ProgramTest.clickButton "")
                    |> expectView
                        (\view ->
                            view
                                |> Query.find [ id "1-1" ]
                                |> Query.has [ text "X" ]
                        )
        , test "check another box" <|
            \() ->
                start
                    |> ProgramTest.within
                        (Query.find [ id "1-2" ])
                        (ProgramTest.clickButton "")
                    |> expectView
                        (\view ->
                            view
                                |> Query.find [ id "1-2" ]
                                |> Query.has [ text "X" ]
                        )
        , test "check two boxes" <|
            \() ->
                start
                    |> ProgramTest.within
                        (Query.find [ id "1-1" ])
                        (ProgramTest.clickButton "")
                    |> ProgramTest.within
                        (Query.find [ id "1-2" ])
                        (ProgramTest.clickButton "")
                    |> expectView
                        (\view ->
                            view
                                |> Query.find [ id "1-2" ]
                                |> Query.has [ text "O" ]
                        )
        , test "check three boxes" <|
            \() ->
                start
                    |> ProgramTest.within
                        (Query.find [ id "1-1" ])
                        (ProgramTest.clickButton "")
                    |> ProgramTest.within
                        (Query.find [ id "1-2" ])
                        (ProgramTest.clickButton "")
                    |> ProgramTest.within
                        (Query.find [ id "2-2" ])
                        (ProgramTest.clickButton "")
                    |> expectView
                        (\view ->
                            view
                                |> Query.find [ id "2-2" ]
                                |> Query.has [ text "X" ]
                        )
        , test "check same box twice" <|
            \() ->
                start
                    |> ProgramTest.within
                        (Query.find [ id "1-1" ])
                        (ProgramTest.clickButton "")
                    |> ProgramTest.within
                        (Query.find [ id "1-1" ])
                        (ProgramTest.clickButton "")
                    |> expectView
                        (\view ->
                            view
                                |> Query.find [ id "1-1" ]
                                |> Query.has [ text "X" ]
                        )
        , test "X wins in a row" <|
            \() ->
                start
                    |> ProgramTest.within
                        (Query.find [ id "1-1" ])
                        (ProgramTest.clickButton "")
                    |> ProgramTest.within
                        (Query.find [ id "3-2" ])
                        (ProgramTest.clickButton "")
                    |> ProgramTest.within
                        (Query.find [ id "1-2" ])
                        (ProgramTest.clickButton "")
                    |> ProgramTest.within
                        (Query.find [ id "2-2" ])
                        (ProgramTest.clickButton "")
                    |> ProgramTest.within
                        (Query.find [ id "1-3" ])
                        (ProgramTest.clickButton "")
                    |> expectView
                        (\view ->
                            view
                                |> Query.has [ text "Player X won!" ]
                        )
        , test "O wins in a row" <|
            \() ->
                start
                    |> ProgramTest.within
                        (Query.find [ id "3-3" ])
                        (ProgramTest.clickButton "")
                    |> ProgramTest.within
                        (Query.find [ id "1-1" ])
                        (ProgramTest.clickButton "")
                    |> ProgramTest.within
                        (Query.find [ id "3-2" ])
                        (ProgramTest.clickButton "")
                    |> ProgramTest.within
                        (Query.find [ id "1-2" ])
                        (ProgramTest.clickButton "")
                    |> ProgramTest.within
                        (Query.find [ id "2-2" ])
                        (ProgramTest.clickButton "")
                    |> ProgramTest.within
                        (Query.find [ id "1-3" ])
                        (ProgramTest.clickButton "")
                    |> expectView
                        (\view ->
                            view
                                |> Query.has [ text "Player O won!" ]
                        )
        ]
