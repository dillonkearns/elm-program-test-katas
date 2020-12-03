module TicTacToe exposing (Model, Msg(..), init, update, view)

import Browser
import Dict exposing (Dict)
import Html
import Html.Attributes exposing (for, id, type_, value)
import Html.Events exposing (onClick, onInput)
import Http
import Json.Decode
import Json.Encode


type Mark
    = X
    | O


type alias Model =
    Dict ( Int, Int ) Mark


type Msg
    = CheckSquare ( Int, Int )


type alias Flags =
    ()


init : Flags -> ( Model, Cmd Msg )
init () =
    ( Dict.empty
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        CheckSquare coordinate ->
            ( model |> Dict.insert coordinate X, Cmd.none )


view : Model -> Browser.Document Msg
view model =
    { title = ""
    , body =
        [ Html.div [ id "1-1" ]
            [ Html.button [ Html.Events.onClick (CheckSquare ( 1, 1 )) ]
                [ Html.text
                    (model
                        |> Dict.get ( 1, 1 )
                        |> Maybe.map (\value -> "X")
                        |> Maybe.withDefault ""
                    )
                ]
            ]
        ]
    }


main : Program Flags Model Msg
main =
    Browser.document
        { init = init
        , subscriptions = \_ -> Sub.none
        , update = update
        , view = view
        }
