module CheckButtons
  exposing
    ( Model
    , emptyModel
    , addTopButton
    , addBottomButton
    , setChecked
    , setUnchecked
    , setActive
    , setDisabled
    , getValues
    , getCheckedValues
    , map
    , filter
    , view
    )

{-| A set of button component that can be checked or unchecked.
  This module also expose a function to generate CSS
  in a manner of [`elm-css`](https://github.com/rtfeldman/elm-css).

# Model

@docs Model

## Constructors

@docs emptyModel

## Setters

@docs addTopButton
@docs addBottomButton
@docs setChecked
@docs setUnchecked
@docs setActive
@docs setDisabled

## Getters

@docs getValues
@docs getCheckedValues

## Modifiers

@docs map
@docs filter

# Renderers

@docs view

-}

import CheckButton exposing (Namespace, Value)
import Html exposing (..)
import Html.CssHelpers as CssHelpers exposing (withNamespace)
import CheckButtons.Css as MyCss exposing (CssClasses(..))


-- Model


{-| An opaque type representing state of check buttons.
-}
type Model
  = CheckButtons (List CheckButton.Model)


toList : Model -> List CheckButton.Model
toList (CheckButtons buttons) =
  buttons


{-| A constructor for `Model`. It contains no buttons.
-}
emptyModel : Model
emptyModel =
  CheckButtons []


{-| Prepend an element onto the front of the check buttons.
-}
addTopButton : CheckButton.Model -> Model -> Model
addTopButton b (CheckButtons bs) =
  CheckButtons <| b :: bs


{-| Add an element onto the back of the check buttons.
-}
addBottomButton : CheckButton.Model -> Model -> Model
addBottomButton b (CheckButtons bs) =
  CheckButtons <| bs ++ [ b ]


{-| Make only buttons with provided values are checked.
-}
setChecked : List Value -> Model -> Model
setChecked vals (CheckButtons bs) =
  CheckButtons <|
    List.map (modifyMember vals CheckButton.setChecked CheckButton.setUnchecked) bs


{-| Make only buttons with provided values are unchecked.
-}
setUnchecked : List Value -> Model -> Model
setUnchecked vals (CheckButtons bs) =
  CheckButtons <|
    List.map (modifyMember vals CheckButton.setUnchecked CheckButton.setChecked) bs


{-| Make only buttons with provided values are active.
-}
setActive : List Value -> Model -> Model
setActive vals (CheckButtons bs) =
  CheckButtons <|
    List.map (modifyMember vals CheckButton.setActive CheckButton.setDisabled) bs


{-| Make only buttons with provided values are disabled.
-}
setDisabled : List Value -> Model -> Model
setDisabled vals (CheckButtons bs) =
  CheckButtons <|
    List.map (modifyMember vals CheckButton.setDisabled CheckButton.setActive) bs


modifyMember : List Value -> (CheckButton.Model -> CheckButton.Model) -> (CheckButton.Model -> CheckButton.Model) -> CheckButton.Model -> CheckButton.Model
modifyMember vs f f_ cb =
  if List.member (CheckButton.getValue cb) vs then
    f cb
  else
    f_ cb


{-| Get values of all check buttons.
-}
getValues : Model -> List Value
getValues (CheckButtons bs) =
  List.map CheckButton.getValue bs


{-| Get values of checked buttons.
-}
getCheckedValues : Model -> List Value
getCheckedValues (CheckButtons bs) =
  List.map CheckButton.getValue
    << List.filter CheckButton.getIsChecked
  <|
    bs


{-| Apply a function to each check button.
-}
map : (CheckButton.Model -> CheckButton.Model) -> Model -> Model
map f (CheckButtons bs) =
  CheckButtons (List.map f bs)


{-| Keep only elements that satisfy the predicate.
-}
filter : (CheckButton.Model -> Bool) -> Model -> Model
filter f (CheckButtons bs) =
  CheckButtons (List.filter f bs)



-- View


{-| A renderer for check buttons.

  The first argument is a name space for
  [elm-css](https://github.com/rtfeldman/elm-css).
  It is supposed to be a unique value.

  The second argument is button values currently checked. It is called if a user checked/unchecked any check button.
-}
view : Namespace -> (List Value -> msg) -> Model -> Html msg
view namespace onChange buttons =
  let
    { id, class, classList } =
      withNamespace namespace

    renderCheckButton_ =
      renderCheckButton namespace
        (getCheckedValues buttons)
        onChange
  in
    div
      [ class [ ButtonSet ]
      ]
    <|
      List.map renderCheckButton_ <|
        toList buttons


renderCheckButton : Namespace -> List Value -> (List Value -> msg) -> CheckButton.Model -> Html msg
renderCheckButton namespace checked onChange checkButton =
  let
    value =
      CheckButton.getValue checkButton

    onToggle : Bool -> msg
    onToggle add =
      onChange <|
        if add then
          value :: checked
        else
          List.filter ((/=) value) checked
  in
    CheckButton.view namespace onToggle checkButton
