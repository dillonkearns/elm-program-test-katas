module TicTacToe exposing (Model, Msg(..), init, update, view)

import Browser
import Dict exposing (Dict)
import Html exposing (Html)
import Html.Attributes exposing (for, id, type_, value)
import Html.Events exposing (onClick, onInput)
import Http
import Json.Decode
import Json.Encode


type Player
    = X
    | O


type alias Model =
    { fields : Dict ( Int, Int ) Player
    , nextPlayer : Player
    , gameState : GameState
    }


type alias Coordinate =
    ( Int, Int )


type GameState
    = Ongoing
    | Draw
    | Won Player


coordinates : List Coordinate
coordinates =
    [ ( 1, 1 )
    , ( 1, 2 )
    , ( 1, 3 )
    , ( 2, 1 )
    , ( 2, 2 )
    , ( 2, 3 )
    , ( 3, 1 )
    , ( 3, 2 )
    , ( 3, 3 )
    ]


type Msg
    = CheckSquare ( Int, Int )


type alias Flags =
    ()


init : Flags -> ( Model, Cmd Msg )
init () =
    ( { fields = Dict.empty
      , nextPlayer = X
      , gameState = Ongoing
      }
    , Cmd.none
    )


togglePlayer : Player -> Player
togglePlayer player =
    case player of
        X ->
            O

        O ->
            X


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        CheckSquare coordinate ->
            ( if Dict.member coordinate model.fields then
                model

              else
                let
                    newFields =
                        Dict.insert coordinate model.nextPlayer model.fields
                in
                { model
                    | fields = newFields
                    , nextPlayer = togglePlayer model.nextPlayer
                    , gameState = updateGameState newFields
                }
            , Cmd.none
            )


updateGameState : Dict ( Int, Int ) Player -> GameState
updateGameState fields =
    case Dict.get ( 1, 3 ) fields of
        Just player ->
            Won player

        Nothing ->
            Ongoing


view : Model -> Browser.Document Msg
view model =
    { title = ""
    , body =
        viewScore model.gameState :: List.map (viewField model) coordinates
    }


viewScore : GameState -> Html msg
viewScore gamestate =
    Html.text <|
        case gamestate of
            Won player ->
                "Player " ++ playerToText player ++ " won!"

            _ ->
                ""


playerToText : Player -> String
playerToText player =
    case player of
        X ->
            "X"

        O ->
            "O"


viewField : Model -> Coordinate -> Html Msg
viewField model ( x, y ) =
    Html.span [ id <| (String.fromInt x ++ "-" ++ String.fromInt y) ]
        [ Html.button [ Html.Events.onClick (CheckSquare ( x, y )) ]
            [ Html.text
                (model.fields
                    |> Dict.get ( x, y )
                    |> Maybe.map
                        playerToText
                    |> Maybe.withDefault " "
                )
            ]
        ]


main : Program Flags Model Msg
main =
    Browser.document
        { init = init
        , subscriptions = \_ -> Sub.none
        , update = update
        , view = view
        }
