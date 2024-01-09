module Availability exposing (..)

import Html exposing (text)
import Array exposing (Array)
import Html.Attributes exposing (type_)
import Debug exposing (..)


type MarketClass = ClassI | ClassII | ClassIII | ClassIV | ClassV | ClassVI
type Rarity = Common | Uncommon | Rare | VeryRare | Legendary
type alias MarketRarity = { name : Rarity, amount : Int , chance : Int }
type alias AvailabilityResult = { name : Rarity, amount : Int, chance : Int, roll : Int }
type alias Roll = (MarketRarity, Int)
marketRarity : MarketClass -> List MarketRarity
marketRarity market = 
    case market of
        ClassI ->
            [{ name = Common, amount = 20,chance = 100 },{ name = Uncommon, amount = 2, chance = 100 },{name = Rare,amount = 1,chance = 60},{name = VeryRare,amount = 1, chance = 10}, { name = Legendary, amount = 1, chance = 1}]
        ClassII ->
            [{ name = Common, amount = 2,chance = 100 },{ name = Uncommon, amount = 1, chance = 20 },{name = Rare,amount = 1,chance = 5},{name = VeryRare,amount = 1, chance = 1}, { name = Legendary, amount = 0, chance = 0}]
        ClassIII ->
            [{ name = Common, amount = 1,chance = 100 },{ name = Uncommon, amount = 2, chance = 2 },{name = Rare,amount = 1,chance = 1},{name = VeryRare,amount = 0, chance = 0}, { name = Legendary, amount = 0, chance = 0}]
        ClassIV ->
            [{ name = Common, amount = 1,chance = 50 },{ name = Uncommon, amount = 1, chance = 1 },{name = Rare,amount = 1,chance = 60},{name = VeryRare,amount = 0, chance = 0}, { name = Legendary, amount = 0, chance = 0}]
        ClassV ->
            [{ name = Common, amount = 1,chance = 30 },{ name = Uncommon, amount = 0, chance = 0 },{name = Rare,amount = 1,chance = 60},{name = VeryRare,amount = 0, chance = 0}, { name = Legendary, amount = 0, chance = 0}]
        ClassVI ->
            [{ name = Common, amount = 1,chance = 15 },{ name = Uncommon, amount = 0, chance = 0 },{name = Rare,amount = 1,chance = 60},{name = VeryRare,amount = 0, chance = 0}, { name = Legendary, amount = 0, chance = 0}]
            

getAvailabilityOfTier : (MarketRarity, Int) -> AvailabilityResult
getAvailabilityOfTier pair =
    let
        rarity = Tuple.first pair
        roll = Tuple.second pair
    in
    if roll <= rarity.chance then
        { name = rarity.name, amount = rarity.amount, chance = rarity.chance, roll = roll}
    else 
        { name = rarity.name, amount = 0, chance = rarity.chance, roll = roll}
    
    
marketAvailability : List Int -> MarketClass -> List AvailabilityResult
marketAvailability rolls mc = 
    let
        rarity = marketRarity(mc)
        combined = List.map2 Tuple.pair rarity rolls
    in
        Debug.log(Debug.toString(List.map getAvailabilityOfTier combined))
        List.map getAvailabilityOfTier combined
        
    


isAvailable : AvailabilityResult -> Bool
isAvailable result =
    result.roll <= result.chance
    
displayAvailable : List AvailabilityResult -> String
displayAvailable results =    
    let
        availableTiers = List.filter isAvailable results
        formatted = List.map formatAvailable availableTiers
        combined = List.foldr (++) "\n NEWLINE \n" formatted
        outString = combined
        
    in
        Debug.log(Debug.toString(availableTiers))
        Debug.log(Debug.toString(formatted))
        Debug.log(Debug.toString(combined))
        outString

fromJust : Maybe a -> a
fromJust x = case x of
    Just y -> y
    Nothing -> Debug.todo "error: fromJust Nothing"       
rarityString : Rarity -> String
rarityString rarity =
    case rarity of
        Common ->
            "Common"
        Uncommon ->
            "Uncommon"
        Rare ->
            "Rare"
        VeryRare ->
            "Very Rare"
        Legendary ->
            "Legendary"
            
marketString : MarketClass -> String
marketString market =
    case market of
        ClassI ->
            "ClassI"
        ClassII ->
            "ClassII"
        ClassIII ->
            "ClassIII"
        ClassIV ->
            "ClassIV"
        ClassV ->
            "ClassV"
        ClassVI ->
            "ClassVI"

formatAvailable : AvailabilityResult -> String
formatAvailable result =
    "There are " ++ String.fromInt result.amount ++ " " ++ rarityString result.name ++ " henchmen available in this market. The target was " ++ String.fromInt result.chance ++ " with a roll of " ++ String.fromInt result.roll ++ "."
    