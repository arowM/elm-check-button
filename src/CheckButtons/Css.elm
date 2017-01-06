module CheckButtons.Css
  exposing
    ( css
    , CssClasses(..)
    )

{-| This module expose a function to generate CSS
  for `CheckButtons` in a manner of [`elm-css`](https://github.com/rtfeldman/elm-css).

# CSS

@docs css
@docs CssClasses
-}

import Css exposing (..)
import Css.Namespace exposing (namespace)
import Html.CssHelpers


{-| A CSS classes.
-}
type CssClasses
  = ButtonSet


{-| A CSS component.
Please reffer to the [elm-css](https://github.com/rtfeldman/elm-css) for detail.
-}
css : List Snippet
css =
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
