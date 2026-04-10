# :star:Pecto v5.0 Patch Notes - Warden Update:star:

---

## Overview

For a long time, it has been somewhat difficult to balance playing the cards you want with how limited the board space is. The main factor contributing to this in my opinon are offsite cards. Offsite cards have been notoriously difficult to balance, jumping from far too strong to far too weak with simple knob turns. To me, this indicates the card type is fundamentally flawed, and I think i've been ignoring this for too long. With this patch the offsite card type is being effectively removed and renamed to the Warden card type, with new abilities, and greatly expanded gameplay options (they will continue to be referred to as offsites until the warden section).

---

## Ruleset Updates

### Game Board

In 4.2, the board was moved over to 3 units and 2 offsite zones. This was partially to prepare for this update. In 5.0, there is no longer the restriction of playing units in the front line and "offsites" in the back line: you can now play any controllable card in any open zone on your board. When you have the opportunity to move a card, you can now move cards into the back row. Cards in the back row cannot attack, but they can use skills. Any card in the backrow is a possible target when a card attacks an open lane. With this change, the rows are being renamed. The 3 zones in front are referred to as the "frontline" and the 2 in the back are the "backline". Some card effects can only target the front or back line.

In addition to this, movement is being changed. At the start of your turn, you may now position your non-static cards however you please. This is now the only time you can move around your cards during your turn. Moving cards in this way does not cause them to become inactive.

### LVL System

Player LVL is being reworked one last time. Both players now start the game at LVL 0. At the start of your turn, you gain 1 LVL: this value cannot be lowered except by card effect. You may play cards less than or equal to your LVL. In addition to this, you may also play cards 1 LVL higher than the highest LVL card you control. For example, if you control a LVL 2 card, you may play LVL 3 cards as well. Floating LVL contributes to your base LVL, but fizzles out at the end of the current turn.

When a player hits LVL 10 not including floating LVL, the game will end. At this point, add up the LVLs of all cards you control. Whichever player has the higher number wins the game.
*Note: most of these changes already happened in 4.2, just reiterating here for clarity's sake*

---

## Card Updates

### Wardens

With this update, as previously stated, offsites are being renamed to Wardens. Wardens will now act as largely supportive or defensive cards. Starting with this update, units will no longer have the ability to move to block: this ability will be exclusive to wardens. To balance this, Wardens will not be able to deal damage to the player, but can still damage back row cards.

Also in addition to this, the sealed keyword is being removed. Cards that previously had the sealed keyword will either lose it or become wardens.

To make this perfectly clear, lets reiterate the two card types and their purposes/capabilities:

Units:

- Main attacker card type.
- Can deal player damage unless they have the "sealed" keyword.

Wardens:

- Main supporter card type.
- Can move to block cards if active. This makes them inactive (note: this overrides static).
- Cannot deal player damage, effectively have the "sealed" keyword.

Tokens:

- Do not have any benefits of Units or Wardens.
- Are just a basic card type that deals damage.
- When a Token perishes, it enters the void instead of the discard and then fizzles out (it does not contribute to your void count).
- Note: tokens are now considered units while on the grid.

With this change, alot of card effects that target controlled cards will be changed to indicate front row or back row. If it doesn't indicate front or back row, both are assumed as possible targets.

This is an update where the majority of cards have at least some small change. Because of this I will only list which units are becoming Wardens and which Wardens are becoming Units.

List of cards to become Wardens:

- Fungal Guardian
- Toxician
- Onyx Defender
- Sand Cube
- Miracle Machine
- Deconstructor
- Building Boulder
- Crusher Golem
- Blast Orb
- Raster Beast
- Banish Watcher
- Rat Mother
- Ethereal Archmage

List of Wardens to become Units:

- Serendipity
- Soul Baron
- Moon Angel

### Passives

With offsites becoming Wardens, passive spells once again have a place in the game, so they are being readded. Passive spells are assumed to have static, have 0 force, can't gain force, and cannot declare attacks (they also deal no combat damage). They can be targetted by effects that targets cards in play, but most of the time this doesn't do anything. Targetting a passive with any amount of dmg (greater than 0) causes it to perish.

Some passives now have no uses, as in the symbol is not in the cards name. This works the same as 0 force, where a passive with 0 uses exists on the board until it either takes damage or loses a use. Note: a 0 uses passive is effectively the same as a 1 uses passive that never loses their uses, a 0 use passive is mainly a syntax decision to represent an passive intended to be infinite.

Cards to Become Passives:

- Last Wish
- Jack in the Box
- Quick Play
- Big Catch
- Ectoplasm
- Creation From Nothing
- Transmogrify
- Death Pact
- Card Dispenser
- Royal Jelly
- The Seal

---

## Additional Changes

### Tribal Synergies

A lot of inherenent tribal synergies are being altered this patch. Most cards that had a specific tribal synergy like "give a bug you control 3 force" now are altered to have a weaker non tribal effect: "give a unit you control 1 force, 3 if its a bug".

Bee Archetype

- Removed, are now all bugs.
- Queen Bee cards have been changed to Bug God type.

### Individual Card Changes

Stun Counters

- Cards with stun counters no longer deal combat damage.

Beemoth Stinger

- Is now an effect spell.
- Effected card gains 2 force.
- War Cry (normal): Bugs you control gain Quick until the end of the turn.

Flying

- A card with flying can only be blocked by a Warden or a Unit with flying.

Quick

- Now applies when blocking as well.
- To compensate for this change, alot of Quick cards will gain the text to disable quick on block.

Static

- Now reads "cannot move during the move phase."
- This is made the case to make it clear that Wardens can still move to block, and movement effects like Sky Spirit still apply to static cards.

*Note: at the time of writing this not all individual card balance changes are finalized, so any changes will not cause it to become 5.1. 5.1 is going to be an update with 20 new cards to hopefully finish set 1, and likely nothing else.*
