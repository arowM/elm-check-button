module CheckButtons.Css
  exposing
    ( css
    , CssClasses(..)
    )

import Css exposing (..)
import Css.Namespace exposing (namespace)
import Html.CssHelpers


type CssClasses
  = ButtonSet


css : Html.CssHelpers.Namespace String class id msg -> Stylesheet
css mynamespace =
  (stylesheet << namespace mynamespace.name)
    [ everything
      [ boxSizing borderBox
      , fontFamily cursive
      , padding zero
      , margin zero
      , lineHeight (num 1.15)
      , height auto
      , width auto
      , property "border" "none"
      , textDecoration none
      , fontWeight normal
      , fontStyle normal
      , fontSize (em 1)
      , boxShadow none
      ]
    , (.) ButtonSet
      [
      ]
    ]
