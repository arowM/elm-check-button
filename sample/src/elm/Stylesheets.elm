port module Stylesheets exposing (..)

import Css exposing (..)
import Css.File exposing (CssFileStructure, CssCompilerProgram)
import Css.Namespace exposing (namespace)
import Html.CssHelpers exposing (withNamespace)
import CheckButton
import CheckButton.Css exposing (CssClasses(..))
import CheckButtons.Css


port files : CssFileStructure -> Cmd msg


mynamespace : CheckButton.Namespace
mynamespace = "checkbuttons"


fileStructure : CssFileStructure
fileStructure =
  Css.File.toFileStructure
    [ ( "index.css"
      , Css.File.compile
        [ (stylesheet << namespace (withNamespace mynamespace).name)
          <| CheckButtons.Css.css ++
            CheckButton.Css.css ++
            [ (.) CheckButtonWrapper
              [ margin (em 0.2)
              ]
            ]
        ]
      )
    ]


main : CssCompilerProgram
main =
    Css.File.compiler files fileStructure
