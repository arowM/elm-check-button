module CheckButton
  exposing
    ( Model
    , Namespace
    , Value
    , defaultModel
    , setChecked
    , setUnchecked
    , setIsChecked
    , setActive
    , setDisabled
    , setLabel
    , getIsChecked
    , getIsActive
    , getValue
    , getLabel
    , view
    )

{-| A button component that can be checked or unchecked ([demo](https://arowm.github.io/elm-check-button/)).
  `CheckButton.Css` exposes a function to generate CSS
  in a manner of [`elm-css`](https://github.com/rtfeldman/elm-css).

# Model

@docs Model

## Constructors

@docs defaultModel

## Setters

@docs setChecked
@docs setUnchecked
@docs setIsChecked
@docs setActive
@docs setDisabled
@docs setLabel

## Getters

@docs getIsChecked
@docs getIsActive
@docs getValue
@docs getLabel

# Renderers

@docs view

# Aliases
@docs Namespace
@docs Value

-}

import Html exposing (..)
import Html.Attributes as Attributes exposing (..)
import Html.CssHelpers as CssHelpers exposing (withNamespace)
import Html.Events exposing (..)
import CheckButton.Css as MyCss exposing (CssClasses(..))


-- Exposed aliases


{-| An alias for readability
-}
type alias Namespace =
  String


{-| An alias for readability
-}
type alias Value =
  String



-- Model


{-| An opaque type representing a check button state.
  To construct an actual value of this type, use constructors and modifiers bellow.

  Example usage.

  button =
    defaultModel "red" "Red"
    |> setChecked
    |> setDisabled

-}
type Model
  = CheckButton
    { value : Value
    , label : String
    , isChecked : Bool
    , isActive : Bool
    }



-- Constructors


{-| A constructor for a check button.
  By providing a value and a label name, you can construct an unchecked active button.
-}
defaultModel : Value -> String -> Model
defaultModel value label =
  CheckButton
    { value = value
    , label = label
    , isChecked = False
    , isActive = True
    }


{-| Set the state of a check button to be checked.
-}
setChecked : Model -> Model
setChecked =
  setIsChecked True


{-| Set the state of a check button to be unchecked.
-}
setUnchecked : Model -> Model
setUnchecked =
  setIsChecked False


{-| Modify the state of a check button to be checked/unchecked.

  setChecked = setIsChecked True
  setUnchecked = setIsChecked False
-}
setIsChecked : Bool -> Model -> Model
setIsChecked isChecked (CheckButton button) =
  CheckButton
    { button
      | isChecked = isChecked
    }


{-| Set the state of a check button to be active.
-}
setActive : Model -> Model
setActive =
  setIsActive True


{-| Set the state of a check button to be disabled.
-}
setDisabled : Model -> Model
setDisabled =
  setIsActive False


{-| Modify the state of a check button to be active/disabled.
  This is an inner function.

  setActive = setIsActive True
  setDisabled = setIsActive False
-}
setIsActive : Bool -> Model -> Model
setIsActive isActive (CheckButton button) =
  CheckButton
    { button
      | isActive = isActive
    }


{-| Set a check button label name.
-}
setLabel : String -> Model -> Model
setLabel label (CheckButton button) =
  CheckButton
    { button
      | label = label
    }



-- Getters


{-| Get if a check button is checked.
-}
getIsChecked : Model -> Bool
getIsChecked (CheckButton { isChecked }) =
  isChecked


{-| Get if a check button is active.
-}
getIsActive : Model -> Bool
getIsActive (CheckButton { isActive }) =
  isActive


{-| Get value of a button.
-}
getValue : Model -> Value
getValue (CheckButton { value }) =
  value


{-| Get label name of a button.
-}
getLabel : Model -> String
getLabel (CheckButton { label }) =
  label



-- View


{-| A renderer for check button.

  The first argument is a name space for
  [elm-css](https://github.com/rtfeldman/elm-css).
  It is supposed to be a unique value.

  The second argument is called if a user checked/unchecked a check button.
-}
view : Namespace -> (Bool -> msg) -> Model -> Html msg
view namespace onToggle (CheckButton checkButton) =
  let
    { id, class, classList } =
      withNamespace namespace

    { value, isChecked } =
      checkButton

    uniqueId =
      namespace ++ "-" ++ value
  in
    div
      [ class [ CheckButtonWrapper ]
      ]
      [ input
        [ type_ "checkbox"
        , id uniqueId
        , class [ CheckButtonCore ]
        , name namespace
        , checked isChecked
        , onCheck onToggle
        , Attributes.value value
        ]
        []
      , label
        [ for uniqueId
        , class [ CheckButtonLabel ]
        ]
        [ text checkButton.label
        ]
      ]
