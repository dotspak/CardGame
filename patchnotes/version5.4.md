# Pecto 5.4 Patch Notes

---

## Overview

Version 5.4 is the final update before the Pecto Pounding Invitational. This patch focuses on gameplay clarity, terminology refinement, and core system improvements.

This update also introduces several foundational changes that simplify gameplay, improve consistency, and better support competitive play.

Version 5.4 introduces major structural improvements to Pecto:

- Influence replaced with the Turn Counter
- Skills restricted from response usage
- Face-down cards introduced as a core mechanic
- Token behavior standardized
- Enter trigger terminology improved
- Card templates refined
- Rarity and card numbering systems restored

These changes improve clarity, consistency, and competitive integrity ahead of the Pecto Pounding Invitational.

---

## Game format Updates

### Turn Counter (Replaces Influence)

The Influence system has been removed and replaced by a new global resource called the Turn Counter.

Turn Counter Rules:

- The Turn Counter increases by 1 at the start of each round.
- A round begins after each player has completed their turn.
- The Turn Counter is global and shared by all players.
- Players may play cards with LVL less than or equal to the Turn Counter.

Additional Changes:

- All effects that modified Influence have been removed or redesigned.
- Most of these effects now modify card LVL instead.
- Some cards may directly modify the Turn Counter itself.

This change improves clarity by removing separate player-specific scaling resources and replacing them with a single shared progression system.

### Skills/Casts

Skills can no longer be used as responses. New universal rules:

- Skills cannot be used as responses.
- Cards may always be cast as responses.
- These rules have no exceptions.

This change reinforces the design philosophy that responses should require a meaningful resource investment. Since cards in Pecto resolve immediately when played, unrestricted skill responses created overly dominant early-game interactions.

Responses are now tied strictly to card usage, ensuring proper tradeoffs and counterplay.

### Face down cards

Face-down cards are now a core game mechanic. During your turn, you may play cards face-down.Face-down cards follow these rules:

They are treated as:

- LVL 1 Units
- 0 FORCE
- No text
- No type
- Their original properties are hidden while face-down.

When destroyed while face-down:

- The card is sent to the discard pile.
- It is then flipped face-up in the discard.
- Perish triggers do not occur.

Effects that reference: “If this card entered the discard while face-down” will trigger in this situation. These effects are known as Flip Tricks.

When flipped face-up on the board:

- The card re-enters play.
- All Enter triggers activate.
- Its LVL and FORCE reset to their original values.

This mechanic primarily reduces early-game bricking while also enabling new flip-based strategies.

## Discard Standardization

Effects that previously instructed players to shuffle their discard and add cards from it to their hand have been standardized.

Old wording example:
> Shuffle your discard, then add X cards from it to your hand.

New wording:
> Add X random cards from your discard to your hand.

This change improves clarity and removes unnecessary mechanical steps. Since the discard pile is already a public zone with no inherent ordering rules, shuffling it provided no meaningful gameplay value.

## General Gameplay updates

### Tokens

Tokens now follow standard destruction rules.

- Tokens now enter the discard pile when they perish, then dissapear (not adding to your discard count)
- Celestial tokens now have the Doom keyword.
- This maintains Celestial identity while improving consistency for discard-based strategies and also being easier to understand.

### Bleed Keyword

- Cards perish after receiving 2 Bleed counters
- Players perish after receiving 4 Bleed counters

### Set Trigger

The Set trigger has been renamed to Enter. Enter triggers now occur when:

- A card enters play
- An effect card becomes attached to a card
- Enter triggers do not occur when attaching non-effect cards.

This terminology better reflects the mechanic’s actual behavior.

---

## Template Updates

Several visual and structural improvements have been made to card templates.

### Visual Indicators

- Each text box now includes a label indicating its function
- Trigger badges now display an arrow symbol
- Standard Skills now display a star symbol
- Free Skills now display a cycle symbol

### FORCE Display Improvements

- Non-units (cards that can't gain FORCE) now display a greyed-out FORCE icon
- All instances of “? FORCE” have been replaced with 0 FORCE

### LVL Display Improvements

- LVL is now displayed in card text with a ciruclar icon with a number
- This puts it more in line with FORCE, instead of saying LVL 1 (even though it reads the same)

This improves readability and removes ambiguity.

### Set number

Each card now displays its official set number. This improves identification, collection tracking, and draft functionality.

---

### Card Updates

A lot of cards received updates this patch. Cards that only received small stat tweaks will not be mentioned below.
🟩 = Buff
🟨 = Rework
🟥 = Nerf

- Soul Stone 🟨
  - Now gains soul counters when spells are cast which can then be used to deal large direct damage to cards.

- Void Crawler 🟥
  - Card voiding is no longer optional.

- Cockroach 🟩
  - Discard effect's drawback has been buffed to once per turn.
  - Now gains 1 FORCE upon procing its discard effect.

- Kick The Hive 🟩
  - Now creates a bug token with bleed when it receives an instance of damage.
  - This allows Kick The Hive to feed its own gameplan as opposed to requiring a separate bug card.

- Sun Box 🟥
  - Now has the option to deal player damage again, increased void requirement from 3 to 4.

- Arbiter 🟥
  - Victor trigger now requires card destruction to proc.

- Prophecy Of Plague 🟩
  - Cast no longer cures other cards.

- Quick Play 🟥
  - Renamed to "Response Trick".
  - Effect is now until end of turn and is a cast effect.

- Living Home 🟨
  - Now fits into its golem archetype more.
  - FORCE increased from 2 to 4.
  - Gained Muted keyword
  - New Passive: "ENTER: Attach a unit from your hand or control. PERISH: Set an attached unit."

- Red Imp 🟨
  - Now causes an opponent's units to lose LVL equal to its damage.

- Green Imp 🟨
  - Now causes an opponent's unit to lose FORCE equal to its damage (non-lethal).

- Blue Imp 🟥
  - Can now only mill the opponent.

- Grave Digger 🟩
  - Now has a mill doubler effect and 2 FORCE as opposed to being a pure spell card.

- Combat Idol 🟨
  - No longer nullifies muted.
  - Now gives cards "VICTOR: If this card destroyed a card: deal 1 damage to an opponent".

- Drop of Marlita 🟨
  - Renamed to "Precipitation"
  - Is now a 1 turn random burst card setter.
  - Is now a response.

- Abyssal Maw 🟨
  - Now adds bleed counters when it destroys a card.
  - Sacrifice skill is now infnite below a certain amount of FORCE.

- Sacrifcial Knife 🟩
  - Now FORCEs ALL players to sacrifice a card and draw a card (which gets around the "safe" keyword).
  - FORCE reduced from 3 to 1.
  - Gained Bleed keyword.

- Pebble 🟩
  - Now has a face-down trick.

- Crusher Golem 🟨
  - Now flips the opposing card face down when they declare an attack.

- Secret Wizard 🟨
  - Now makes face down cards very strong.
  - Can flip up face down cards.

- Card Dispenser 🟨
  - Now flips cards you control face down as a cost.

- Tricky Orb 🟩
  - Now has a face-down trick.
  - Can flip itself down with flip skill.

- Hive Infiltrator 🟩
  - If it were to perish, it instead flips itself face down until the end of the turn (which causes it to re-enter).
  - Gains 2 FORCE on victor trigger.
  - Gained Immortal.

- Border of Life 🟨
  - Makes face down cards unable to be destroyed through battle or card effect.
  - Flips 2 cards you control face down until the end of the turn.

- Shadow Prince 🟨
  - Now flips all face down cards you control face up once per summon.