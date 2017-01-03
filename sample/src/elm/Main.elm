module Main exposing (..)

import Html exposing (..)

import CheckButton exposing (Value)
import CheckButtons
import Stylesheets exposing (mynamespace)
import Debug



-- APP


main : Program Never Model Msg
main =
  program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }



-- MODEL


type alias Model =
  { buttons : CheckButtons.Model
  }


init : (Model, Cmd Msg)
init =
  ( { buttons =
    CheckButtons.emptyModel
      |> CheckButtons.addBottomButton
        (CheckButton.defaultModel "red" "Red")
      |> CheckButtons.addBottomButton
        (CheckButton.defaultModel "pink" "Pink")
      |> CheckButtons.addBottomButton
        (CheckButton.defaultModel "purple" "Purple")
      |> CheckButtons.addBottomButton
        (CheckButton.defaultModel "blue" "Blue")
      |> CheckButtons.addBottomButton
        (CheckButton.defaultModel "green" "Green")
    }
  , Cmd.none
  )



-- UPDATE


type Msg
  = OnChange (List Value)


update : Msg -> Model -> (Model, Cmd Msg)
update message model =
  let foo = Debug.log "model" model.buttons
  in
    case message of
      OnChange vals ->
        ( Debug.log "after" { model
          | buttons =
            model.buttons
              |> CheckButtons.setChecked (Debug.log "checked" vals)
          }
        , Cmd.none
        )



-- VIEW


view : Model -> Html Msg
view model =
  div
    []
    [ CheckButtons.view mynamespace OnChange model.buttons
    , div
      []
      [ text
        <| "Checked: " ++
          (String.concat << List.intersperse ", ")
            (CheckButtons.getCheckedValues model.buttons)
      ]
    ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ = Sub.none
