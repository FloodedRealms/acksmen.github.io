module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes as Attr exposing (..)
import Browser
import Availability exposing (..)

type alias Model =
    { marketClass : String, availabilitySummary : String }
    
initialModel : Model
initialModel =
    { marketClass = "None", availabilitySummary = "" }
    
    
view : Model -> Html Msg
view model =
    div [Attr.id "flex"] [
    aside [] [
        div [ Attr.class "sibebar-title"][text "Which market class?"]
    ,div [ Attr.class "buttons" ]
        [ ul [] [ 
            li [Attr.class "main-btn" ] [button [ onClick ClassI ] [ text "Class I" ] ]
        ,li [Attr.class "main-btn"][ button [onClick ClassII ] [ text "Class II" ]]
        ,li [Attr.class "main-btn"][ button [onClick ClassIII ] [ text "Class III" ]]
        ,li [Attr.class "main-btn"][ button [onClick ClassIV ] [ text "Class IV" ]]
        ,li [Attr.class "main-btn"][ button [onClick ClassV ] [ text "Class V" ]]
        ,li [Attr.class "main-btn"][ button [onClick ClassVI ] [ text "Class VI" ]]
        ]
        ]
    ]
    , Html.main_ [] [ div [Attr.id "title"] [text "Welcome! Grab your henchmen!"]
    , div [Attr.class "content"] [text model.marketClass]
    , div [Attr.class "content"] [text model.availabilitySummary]
    ]
    ]
        
        
type Msg 
    = ClassI
    | ClassII
    | ClassIII
    | ClassIV
    | ClassV
    | ClassVI




    
update : Msg -> Model -> Model 
update msg model =
    case msg of
        ClassI ->
            { model | marketClass = Availability.marketString Availability.ClassI, availabilitySummary = Availability.displayAvailable <| Availability.marketAvailability [100 , 1, 25, 11, 67] Availability.ClassI }
        ClassII ->
            { model | marketClass = Availability.marketString Availability.ClassII, availabilitySummary = Availability.displayAvailable <| Availability.marketAvailability [100 , 1, 25, 11, 67] Availability.ClassII }
        ClassIII ->
            { model | marketClass = Availability.marketString Availability.ClassIII, availabilitySummary = Availability.displayAvailable <| Availability.marketAvailability [100 , 1, 25, 11, 67] Availability.ClassIII }
        ClassIV ->
            { model | marketClass = Availability.marketString Availability.ClassIV, availabilitySummary = Availability.displayAvailable <| Availability.marketAvailability [100 , 1, 25, 11, 67] Availability.ClassIV }
        ClassV ->
            { model | marketClass = Availability.marketString Availability.ClassV, availabilitySummary = Availability.displayAvailable <| Availability.marketAvailability [100 , 1, 25, 11, 67] Availability.ClassV }
        ClassVI ->
            { model | marketClass = Availability.marketString Availability.ClassVI, availabilitySummary = Availability.displayAvailable <| Availability.marketAvailability [100 , 1, 25, 11, 67] Availability.ClassVI }




main : Program () Model Msg
main =
    Browser.sandbox {
        init = initialModel
        , view = view
        , update = update
    } 