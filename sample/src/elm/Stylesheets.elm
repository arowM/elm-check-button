port module Stylesheets exposing (..)

import Css.File exposing (CssFileStructure, CssCompilerProgram)
import Html.CssHelpers exposing (withNamespace)
import CheckButton
import CheckButtons


port files : CssFileStructure -> Cmd msg


mynamespace : CheckButton.Namespace
mynamespace = "checkbuttons"


fileStructure : CssFileStructure
fileStructure =
  Css.File.toFileStructure
    [ ( "index.css"
      , Css.File.compile
        [ CheckButton.css <| withNamespace mynamespace
        , CheckButtons.css <| withNamespace mynamespace
        ]
      )
    ]


main : CssCompilerProgram
main =
    Css.File.compiler files fileStructure
