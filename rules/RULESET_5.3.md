# Pecto TCG — Official Rulebook

---

## Game Overview

Pecto is a tactical card game where players deploy cards onto a shared battlefield and battle using Force.

Each player manages:

- A Deck
- A Discard
- A Void
- Their Life
- Their Influence

The goal is simple: Reduce your opponent’s Life to 0.

---

## Deck Construction

Each deck contains 20 cards, which is then divided during the game.

| Pile | Purpose |
| - | - |
| Deck | Your draw pile. |
| Hand | Your playable cards |
| Discard | Where perished cards go. |
| Void | A removed-from-game pile. Cards here typically cannot return. |

### Drawing Cards

At the start of each turn, you draw 1 card. If you would draw and your Deck is empty: Shuffle your Discard to form a new Deck. If you were to draw a card and shuffle your discard but your discard is empty, you lose the game.

---

## Life & Influence

Each player starts with:

- 10 Life
- 1 Influence

### Winning the Game

To win, you must reduce your opponent's life to 0. A player loses immediately when their Life reaches 0.

### Influence Gain

At the start of each of your turns, you gain +1 Influence. The player going first does not gain Influence on their first turn.

---

## Card Anatomy

Each card contains the following elements:

### Name

The name of the specific card.

### LVL

The influence requirement needed to Set the card.

### Force

Force represents both a card’s health and combat damage. Cards perish if they take damage and their force is 0 or less.

#### Cards with 0 Force

Do not perish when they are set, instead perish when they take damage.

#### Cards with No Force

Acts the same as a 0 force card, but cannot gain Force.

### Text Boxes

| Box | Meaning |
| ---- | ---- |
| Type | A categorizes the card (Ghost, Golem, etc.) |
| Keywords | Modifies how a card behaves (Bleed, Static, Quick). |
| Ritual Box | An extra cost your must complete to set the card from your hand. Ignore rituals if a card is set via card effect. |
| Effect Box | Passive or continuous abilities. |
| Cast Box | If present, the card is considered a Spell card and may be cast to the Discard during any action or response opportunity. |
| Skill Box | Activated abilities. Pink skills make the card inactive. Green skills do not. |

Cards may attack, cast, or activate skills immediately upon being Set. Cards cannot attack on each player's first turn.

---

## Turn Structure

Each player’s turn follows this order:

1. Draw Phase — Draw a card from the top of your deck.
2. Influence Phase — Gain +1 Influence (except first player’s first turn).
3. Action Phase — You may:
   - Set cards
   - Declare attacks
   - Cast spells
   - Activate skills
   - Move their cards

### Setting Cards

You may Set cards from your hand onto the board or via card effect onto the board you cannot set a card if there is no available space on your board. A card can be Set if:

- Its LVL is less than or equal to your Influence.
- Its LVL is +1 higher than the highest-LVL card you control.

> Example:
If your Influence is 1 and you control a LVL 1 card, you may Set LVL 2 cards.

## Combat

Declaring an attack is an action. The opponent may respond before the attack resolves. If the attacker is destroyed during this response, the attack does not happen.

When 2 cards enter combat, both cards deal damage equal to their Force at the same time. If a card’s Force reaches 0 or less, it perishes and is sent to the Discard. If a card attacks a player, the player loses life equal to the cards force.

### Moving cards

Once per turn, if your card is active you may move it to an open adjacent zone if it is active, or swap with another adjancet card if they are both active. You are allowed to move any amount of cards during this, but they can only move 1 zone away max.

---

## The Board

Cards are Set onto a 5-zone grid:

> [ LF ] [ CF ] [ RF ]
> [ LB ] [ RB ]

Cards may be placed in any zone unless otherwise stated.

### Front Row

Cards in the front row may declare attacks. They must attack the card directly in front of them. If no card is present they may attack the opposing back row card or the opponent directly. The opposing back row card is the back row card in the same side as the zone of your card. If your card is in the center zone you may attack either back row zone.

### Back Row

Cards in the back row cannot declare attacks unless specified. The back row is typically for support or utility cards.

---

## Responses

When a player performs an action it resolves immediately. After the action resolves, the opponent may perform a response. Any action that can be used as a response is considered "response speed".

The following actions can be performed at response speed by default:

- Casting spells
- Activating skills
- Setting cards with the Response keyword

Only 1 response per action is allowed.

---

## Tokens

Tokens are temporary cards created by effects. Tokens enter play as specified. Tokens are treated as cards while on the board. When tokens perish, they go to the Void instead of the discard. Tokens sent to the Void do not count toward your Void total.

---

## Glossary

| Term | Meaning |
| - | - |
| Set | When a card is placed onto the board. |
| Perish | Destroyed and sent to the Discard. |
| Cast | Send a Spell from the board to the Discard and apply its effect. |
| Void | Removed-from-game pile. |

### Keywords

Keywords are special words that are short-hand for a specific mechanic.

| Keyword | Description |
| - | - |
| Static | Cannot move during the movement phase. |
| Bleed | When a card with bleed connects an attack with a target (regardless of damage dealt), they receive a bleed counter. If a target has 3 or more bleed counters, they perish (including players). |
| Quick | A card with quick deals damage before non quick cards. If both cards are quick, damage resolves normally. |
| Muted | Cannot deal combat damage to players. |
| Safe | Cannot be targetted by destruction effects (can still be sacrificed). |
| Sick | At the start of each turn, lose half of their current force, rounded up (always takes at least 1 damage). If a sick card connects an attack with a card (regardless of damage dealt), the card also becomes sick. |
| Fragile | If a card with fragile takes damage, they immediately perish. |

### Triggers

Triggers are represented by yellow badges and activate automatically when their condition is met. Triggered effects resolve immediately.

| Trigger | Activation |
| - | - |
| Set | When the card is set to the board |
| Begin | At the start of the owner's turn |
| End | During the end step of the owner's turn. |
| Perish | When the card is destroyed. |
| Victor | When the card deals combat damage. Does not trigger if the card perishes after. |
