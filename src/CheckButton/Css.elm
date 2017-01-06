module CheckButton.Css
  exposing
    ( css
    , CssClasses(..)
    )

{-| This module expose a function to generate CSS
  for `CheckButton` in a manner of [`elm-css`](https://github.com/rtfeldman/elm-css).

# CSS

@docs css
@docs CssClasses
-}

import Css exposing (..)


{-| A CSS classes.
-}
type CssClasses
  = CheckButtonWrapper
  | CheckButtonCore
  | CheckButtonLabel


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
    , (.) CheckButtonWrapper
      [ display inlineBlock
      ]
    , (.) CheckButtonCore
      [ display none
      , checked
        [ adjacentSiblings [
          (.) CheckButtonLabel
            [ backgroundColor darkColor
            , borderColor darkColor
            , backgroundColor mainColor
            , borderColor mainColor
            , color textColor
            , fontWeight bold
            ]
          ]
        ]
      ]
    , (.) CheckButtonLabel
      [ display block
      , borderRadius (em 0.4)
      , borderStyle solid
      , backgroundColor darkColor
      , borderColor darkColor
      , textAlign center
      , padding2 (em 0.3) (em 0.4)
      , cursor pointer
      , color white
      ]
    ]


mainColor : Color
mainColor = hex "ffaaaa"

darkColor : Color
darkColor = hex "cc8888"

textColor : Color
textColor = hex "554444"

white : Color
white = hex "ffffff"
