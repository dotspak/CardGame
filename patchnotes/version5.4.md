# Pecto 5.4 Patch Notes

---

## Overview

This is the last update before the Pecto Pounding invitational event, so it mostly focues on card balances and small gameplay tweaks/card udpates/terminology to smooth out rough areas of the game.

---

## Game format Updates

I have made the decision to restrict the game to 1v1 or 2v2. There are a few reasons for this, the main one being an update to the resource system to improve clarity, but also it greatly simplfies alot of wording with cards. This means the previous effort to make cards work in a 1v1v1v1 setting will be reverted.

### Influence

The influence system is being reworked. That being that the term "influence" is being removed from the game. Instead, a functionaly similar mechanic will be replacing it called turn count. The turn count will function the exact same as Yugioh, where it is a global counter that increases by 1 at the start of each player's turn. The turn counter will now act as the highest LVL card you can play from your hand outside of chaining.

This also means that any effects related to modifying influence will be removed from the game entirely. Most of these effects are being moved over to card LVL modification for easier chaining, and some will effect the turn counter itself.

Overall, this change should make the game more clear and have 1 less thing to keep track of since both players keep track of the same resource counter now.

## General Gameplay updates

### Tokens

- Tokens no longer enter the void when perishing: they enter the discard like any other card.

Tokens entering the void was intended to be a buff to the Celestial cards, but upon further examination this was not really necessary. To compensate, all Celestial tokens will now have the *doom* keyword (enters the void when they perish).

This will buff based discard strategies, but void based strategies typically have stronger payoffs and more consistentcy so this is a fine tradeoff.

### Bleed Keyword

- Cards now perish when they have 2 bleed counters
- Players now perish when they have 4 bleed counters

### Set Trigger

- Renamed to *Enter*, now also applies when an effect card is attached (note: *Enter* triggers do not apply if a non-effect card is attached).

---

## Template Updates

- Each text box now has a label at the top left indicating what the box represents.
- Triggers now have an arrow symbol to the left of the badge.
- Standard Skills now have a star symbol to the left of the badge.
- Free Skills now have a cycle symbol to the left of the badge.
- Cards with no force now have a greyed out force icon instead of lacking the symbol all together.
- All instances of ? force cards have been replaced with 0 force for more clarity as they functionaly were the same.

### Rarities

Rarities were temporarily removed while I finalized the card list. In preparation for the simulator's dedicated draft mode, card rarities will now be returning.

- Cards can have 1 of 4 rarities:
  - Basic
  - Rare
  - Super Rare
  - Divine Rare
- These rarities are represented by a small circle symbol in the bottom right, as well as different FX on the card background.
  - Basic cards have the default dark grey border
  - Rare cards have a coloured border
  - Super Rare cards have a gradient border
  - Divine Rare cards have a special border

### Card Number

- Now that the set count has been finalized, each card now has a card number saying which card in the set it is.

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
  - Now gains 1 force upon procing its discard effect.

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
  - Force increased from 2 to 4.
  - Gained Muted keyword
  - New Passive: "ENTER: Attach a unit from your hand or control. PERISH: Set an attached unit."

- Red Imp 🟨
  - Now causes an opponent's units to lose LVL equal to its damage.

- Green Imp 🟨
  - Now causes an opponent's unit to lose force equal to its damage (non-lethal).

- Blue Imp 🟥
  - Can now only mill the opponent.

- Grave Digger 🟩
  - Now has a mill doubler effect and 2 force as opposed to being a pure spell card.

- Combat Idol 🟨
  - No longer nullifies muted.
  - Now gives cards "VICTOR: If this card destroyed a card: deal 1 damage to an opponent".

- Drop of Marlita 🟨
  - Renamed to "Precipitation"
  - Is now a 1 turn random burst card setter.
  - Is now a response.

- Abyssal Maw 🟨
  - Now adds bleed counters when it destroys a card.
  - Sacrifice skill is now infnite below a certain amount of force.

- Sacrifcial Knife 🟩
  - Now forces ALL players to sacrifice a card and draw a card (which gets around the "safe" keyword).
  - Force reduced from 3 to 1.
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
  - Gains 2 Force on victor trigger.
  - Gained Immortal.

- Border of Life 🟨
  - Makes face down cards unable to be destroyed through battle or card effect.
  - Flips 2 cards you control face down until the end of the turn.

- Shadow Prince 🟨
  - Now flips all face down cards you control face up once per summon.