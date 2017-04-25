import Html exposing (Html, beginnerProgram, text, div, button)
import Html.Events exposing (onClick)

type Suit = Diamonds | Clubs | Hearts | Spades
type Msg = DrawCard | PlayCard | ShowHand

type alias Card =
    { suit: Suit
    , value: Int 
    }

type alias Cards = 
    List Card

type alias Game = 
    { playerOneHand: Cards
    , deck: Cards
    , playArea : Cards
    }

game : Game
game = 
    let 
        playArea : Cards
        playArea = []

        threeOfClubs : Card
        threeOfClubs = { suit = Clubs, value = 3}

        twoOfClubs: Card
        twoOfClubs = { suit = Clubs, value = 2}

        deck: Cards
        deck =  [twoOfClubs, threeOfClubs]

        playerOneHand: Cards
        playerOneHand = [twoOfClubs, threeOfClubs]
    in
    {
    playerOneHand = playerOneHand,
    deck = deck,
    playArea = playArea
    }


getCardString: Card -> String
getCardString card = 
    toString card.suit ++ " " ++ toString card.value ++ " " 

getCardsString: Cards ->  String 
getCardsString hand = 
    List.map getCardString hand |>
    List.foldr (++) "" 

getTopCard: Cards -> Maybe Card
getTopCard cards = 
    List.head cards

removeTopCard: Cards -> Cards
removeTopCard hand =
    List.drop 1 hand

addCard: Maybe Card -> Cards -> Cards
addCard card cards =
    case card of 
        Just card ->
            card::cards
        Nothing ->
            cards

drawCardFromDeck: Game -> Game
drawCardFromDeck game =
    {
        playerOneHand = addCard (getTopCard game.deck) game.playerOneHand ,
        deck = removeTopCard game.deck,
        playArea = game.playArea
    }


playCardFromHand: Game -> Game
playCardFromHand game =
    {
        playerOneHand = removeTopCard  game.playerOneHand ,
        deck = game.deck,
        playArea = addCard (getTopCard game.playerOneHand) game.playArea
    }


main = 
    beginnerProgram {model = game, view = view, update = update}

update: Msg -> Game -> Game
update msg model = 
    case msg of 
        DrawCard ->
            drawCardFromDeck model
        PlayCard ->
            playCardFromHand model
        ShowHand ->
            model
        

view model =
    div []
        [ button [onClick DrawCard ] [ text "Draw Card" ]
        , button [onClick PlayCard ] [ text "Play Card" ]
        , button [onClick PlayCard ] [ text "Show Hand" ]
        , div [] [text ("deck: " ++ getCardsString model.deck)]
        , div [] [text ("playerOne: " ++  getCardsString model.playerOneHand )]
        , div [] [text ("playArea"  ++ getCardsString model.playArea)]
        ]
