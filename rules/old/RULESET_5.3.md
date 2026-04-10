# :book: Pecto TCG — Official Rulebook :book:

**Cole Smith-Evans 2026**
*PectoTCG V5.3*

---

## Game Overview

Pecto is a tactical card game where players deploy cards onto a shared battlefield. The objective of the game is to create a board state stronger than your opponents, and ultimately redue their life to 0 as a result.

Each player manages:

- A Deck
- A Discard
- A Void
- Life
- Influence

---

## Deck Construction

Each deck contains 20 cards, which is then divided during the game.

- Deck
  - Your draw pile.
- Hand
  - Your playable cards.
- Discard
  - Where perished cards go.
- Void
  - A removed-from-game pile. Cards here typically cannot return.

---

## Card Anatomy

Each card contains the following elements:

### Name

The name of the specific card.

### LVL

The influence requirement needed to Set the card.

### Force

Force represents both a card’s health and combat damage. Cards perish if they take damage and their force is 0 or less.

### Cards with 0 Force

Do not perish when they are set, instead perish when they take damage.

### Cards with No Force

Acts the same as a 0 force card, but cannot gain Force.

### Text Boxes

- Type
  - Categorizes the card (Ghost, Golem, etc.)
- Keywords
  - Modifies how a card behaves (Bleed, Static, Quick).
- Ritual Box
  - An extra cost your must complete to set the card from your hand, put in a red box. Ignore rituals if a card is set via card effect.
- Effect Box
  - Passive or continuous abilities, put in a black box.
- Cast Box
  - If present, the card is considered a Spell card and may be cast to the Discard during any action or response opportunity, put in a blue box.
- Skill Box
  - Activated abilities. Pink skills make the card inactive. Green skills do not. Put in a pink or green box.

Cards may attack, cast, or activate skills immediately upon being Set. Cards cannot attack on each player's first turn.

---

## Turn Structure

Each player’s turn follows this order:

1. Draw Phase — Draw a card from the top of your deck.
2. Influence Phase — Gain +1 Influence (except the first turn of the game), and trigger any "start of turn" effects.
3. Action Phase — You may:
   - Set cards
   - Declare attacks
   - Cast spells
   - Activate skills
   - Move their cards

### Starting a Game

Before the game begins, roll a D20 (or any die) and whoever rolls the higher number can choose to go first or second. It is typically advised to go first if unsure. Then each player draws 5 cards.

Each player starts with:

- 10 Life
- 1 Influence

Once the game begins, the player doing first draws a card and begins their turn, moving directly to the action phase.

### Setting Cards

You may Set cards from your hand onto the board or via card effect onto the board you cannot set a card if there is no available space on your board. A card can be Set from your hand if:

- Its LVL is less than or equal to your Influence.
- Its LVL is +1 higher than the highest-LVL card you control.

> Example:
> If your Influence is 1 and you control a LVL 1 card, you may Set LVL 2 cards.

### Drawing Cards

At the start of each turn, you draw 1 card. If you would draw and your Deck is empty: Shuffle your Discard to form a new Deck. If you were to draw a card and shuffle your discard but your discard is empty, you lose the game.

This effect only applies when you specifically "draw" from your deck, not when cards are being searched or discarded/voided.

### Responses

When a player performs an action it resolves immediately. After the action resolves, the opponent may perform a response. Only 1 response per action is allowed. Any action that can be used as a response is considered "response speed".

The following actions can be performed at response speed by default:

- Casting spells
- Activating skills
- Setting cards with the Response keyword

If one of these actions cannot be used as a response, the text describing the action will end with, "cannot be used as a response".

### Card Combat

At any point during your turn, you can declare an attack with any one of your cards (unless stated otherwise). When you do so, the card you declared the attack with will attack the zone directly in front of it. If there is no card in front of it, you may choose to attack an opposing back row card or the player directly, dealing damage to their life as if they were a card.

When cards enter combat, both cards deal damage equal to their Force at the same time. If a card’s Force is 0 or less after combat, it perishes and is sent to the Discard.

Declaring an attack is an action. The opponent may respond before the attack resolves. If the attacker is destroyed during this response, the attack does not happen.

---

## The Grid

Cards are Set onto a 5-zone grid:

> [ LF ] [ CF ] [ RF ]
>> [ LB ] [ RB ]

Cards may be placed in any zone unless otherwise stated.

### Front Row

Cards in the front row may declare attacks. They must attack the card directly in front of them. If no card is present they may attack the opposing back row card or the opponent directly. The opposing back row card is the back row card in the same side as the zone of your card. If your card is in the center zone you may attack either back row zone.

### Back Row

Cards in the back row cannot declare attacks unless specified. The back row is typically for support or utility cards.

### Moving Cards/Movement Phase

Once per turn, you may declare you are moving your cards. When this happens, you may move any number of cards to an adjacent zone, front row or back row. Only active cards can move during this phase. If two cards are adjacent to each other and are able to move, you may swap their positions. A card can only move 1 zone away from where it started during this phase.

If a card can move in a different way (for example, via card effect), these rules are irrelevant and the card will determine how the movement can be made.

---

## Extra Mechanics

### Shuffling Your Discard

Some cards ask you to shuffle your discard pile (and then typically ask for you to draw X number of cards from the top). When this happens, take your discard pile, flip it upside down and shuffle it. Then flip it over again so the bottom card is now face up.

### Searhing for Cards

Some cards ask you to search your deck for specific cards. When this happens, take your deck and look until you find a suitable card. At this point, do whatever you are supposed to do with the card (typically adding it to your hand). Afterwards, shuffle your deck.

### Tokens

Tokens are temporary cards created by effects. Tokens enter play as specified. Tokens are treated as cards while on the board. When tokens perish, they go to the Void instead of the discard. Tokens do not count towards the respective pile's total that they reside in. For example, if your void has 2 cards and a token perishes and is sent to the void, the count is still 2, not 3 (the same applies if a token were to be sent to the discard for any reason).

### Counters

If a card requires you to add a counter to another card or player, add a dice (or any other representation) to the target to represent the counter. If the counters ever hit 0, you may remove the coutner respresentation.

---

## Glossary

### Basic Terms

- Set
  - When a card is placed onto the board.
- Draw
  - Draw from the top of your deck.
- Perish
  - Destroyed and sent to the Discard.
- Cast
  - Send a Spell from the board to the Discard and apply its effect.
- Void
  - Removed-from-game pile.

### Keywords

Keywords are special words that are short-hand for a specific mechanic.

- Static
  - Cannot move during the movement phase.
- Bleed
  - When a card with bleed connects an attack with a target (regardless of damage dealt), they receive a bleed counter. If a target has 3 or more bleed counters, they perish (including players).
- Quick
  - A card with quick deals damage before non quick cards. If both cards are quick, damage resolves normally.
- Muted
  - Cannot deal combat damage to players.
- Safe
  - Cannot be targetted by destruction effects (can still be sacrificed).
- Sick
  - At the start of each turn, lose half of their current force, rounded up (always takes at least 1 damage). If a sick card connects an attack with a card (regardless of damage dealt), the card also becomes sick.
- Fragile
  - If a card with fragile takes damage, they immediately perish.

### Triggers

Triggers are represented by yellow badges and activate automatically when their condition is met. Triggered effects resolve immediately.

- Set
  - When the card is set to the board.
- Begin
  - At the start of the owner's turn.
- End
  - During the end step of the owner's turn.
- Perish
  - When the card is destroyed.
- Victor
  - When the card deals combat damage. Does not trigger if the card perishes after.
