import Html exposing (Html, beginnerProgram, text, div, button)
import Html.Events exposing (onClick)

type Suit = Diamonds | Clubs | Hearts | Spades

type alias Card =
    { suit: Suit
    , value: Int 
    }

type alias Hand = 
    List Card

type alias Deck = 
    List Card

type Msg = DrawCard | PlayCard

threeOfClubs: Card
threeOfClubs = 
    { suit = Clubs, value = 3}

twoOfClubs: Card
twoOfClubs = 
    { suit = Clubs, value = 2}

deck: Deck
deck = 
    [twoOfClubs, threeOfClubs]

playerOneHand: Hand
playerOneHand = 
    [twoOfClubs, threeOfClubs]

playerTwoHand: Hand
playerTwoHand = 
    [twoOfClubs, threeOfClubs]

getCardString: Card -> String
getCardString card = 
    toString card.suit ++ " " ++ toString card.value 

getMaybeCardString: Maybe Card -> String
getMaybeCardString card =
    case card of
        Just card-> toString card.suit ++ " " ++ toString card.value

        Nothing -> "oops no card"

getHandString: Hand ->  String 
getHandString hand = 
    List.map getCardString hand |>
    List.foldr (++) "" 

drawFromDeck: Deck -> Maybe Card
drawFromDeck deck = 
    List.head deck

main = 
    beginnerProgram {model = 0, view = view, update = update}

update msg model = 
    case msg of 
        DrawCard ->
            1
        PlayCard ->
            2

view model =
    div []
        [ button [onClick DrawCard ] [ text "Draw Card" ]
        , button [onClick PlayCard ] [ text "Play Card" ]
        ]
