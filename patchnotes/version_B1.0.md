# Pecto Beta 1.0 Patch Notes

---

## Overview

This will be the final update before the Pecto Pounding Invitational. This update ended up being a lot larger than expected. This update will now be the new baseline for the game, and as such the game will now enter Beta, moving out of Alpha.

This update also introduces several foundational changes that simplify gameplay, improve consistency, and better support competitive play.

Version 5.4 introduces major structural improvements to Pecto:

- Influence replaced with the Level Cap
- Updated card draw
- Updated combat
- Face-down cards introduced
- Token behavior standardized
- Enter trigger terminology improved
- Card templates refined

These changes improve clarity, consistency, and competitive integrity ahead of the Pecto Pounding Invitational.

---

## Core Rule Updates

### Level Cap (Replaces Influence)

The Influence system has been removed and replaced by a new resource called the Level Cap.

Level Cap:

Your Level Cap determines the highest LVL card you may play (from your hand).
Your LVL cap is equal to the higher of 2 things:

- Its baseline value, which increases by 1 at the start of each turn except the first turn of the game.
- The highest LVL card you control plus one.

This value constantly updates throughout the game.

Additional Changes:

- All effects that modified Influence have been removed or redesigned.
- Most of these effects now modify card LVL instead.

### Combat

Combat is receiving a minor update with major rammifications.

- If a card takes damage greater than or equal to their FORCE, they perish at the end of combat.
- If a card survives combat, it now restores all damage received.
- When a card you control destroys a card in combat, draw a card.

*Note: this means that if 2 cards trade in combat, both players draw a card.*

This makes large FORCE cards much scarier while also heavily increasing board prescence.

This change also does a few things to the game overall:

- Makes direct damage/force loss stronger
- Indirectly nerfs sacrificing cards, which was too strong
- Causes cards to perish less often overall
- Buffs the VICTOR trigger
- Gives you a solid reason to play higher LVL cards (typically higher LVL = higher FORCE = easier to trade/kill)

### Movement

The movement phase is being removed. The movement phase was a secret outlier that caused games to be too fast, and is being partially reverted.

Movement now works as such:

- At any point during your turn when you could perform an action, you may declare you are moving a card.
- You may then swap zones with another card you control if they are both active and not static.
- The card that was swapped with then becomes inactive.

Here's a breakdown of how this works now:

1. Player 1 declares they are moving Card A.
2. They then swap zones with Card B.
3. Card B is now inactive, but Card A remains active allowing it to attack.

This now makes movement more punishing, but also less confusing overall.

### Healing

Cards can now have player healing effects.

- When you heal, you gain that much life.
- You can never go above your starting life total by healing.
- Card text that refers to this mechanic says "Heal X". This means you heal X life.
- These effects (at least for now) can only ever target the owner of the card they refer to.
- For example if Player A sets Card A that says "ENTER: Heal 1." Player A will gain 1 life when they set Card A.

### Face down cards

Face-down cards are a new mechanic of the game. Some cards flip cards upside down or right side up.

A face down card is treated as:

- LVL 1
- 0 FORCE
- No text, type, skill, cast
- Their original properties are hidden while face-down.

When destroyed while face-down:

- The card is sent to the discard pile.
- It is then flipped face-up in the discard.
- Due to this, Perish triggers do not occur.

Effects that reference: “If this card entered the discard while face-down” will trigger in this situation. These effects are unofficially known as Flip Tricks.

When flipped face-up on the board:

- The card re-enters play.
- All Enter triggers activate.
- Its LVL and FORCE reset to their original values.

### Tokens

Tokens now follow standard destruction rules.

- Tokens now enter the discard pile when they perish, then dissapear (not adding to your discard count)
- Celestial tokens now have the Doom keyword to compensate.

Tokens are now universally considered LVL 1 unless stated otherwise.

---

## General Gameplay updates

### Discard Standardization

Effects that previously instructed players to shuffle their discard and add cards from it to their hand have been standardized.

Old wording:

- Shuffle your discard, then add X cards from the top to your hand.

New wording:

- Add X random cards from your discard to your hand.

These are functionaly similar but the new version has less loopholes and is overall more clear.

### Bleed Keyword

- When a Bleed card hits a target, that target gains 1 Bleed counter.
- A target with a bleed counter takes additional combat damage equal to the number of bleed counters on them.
- This is intended to make bleed counters lethal while not being a hard instant kill.

*Note: the term target means players can gain bleed counters as well, unlike sick.*

### Quick Keyword

- Has now been universally changed to "deals damage first when attacking".
- This change was made so quick cards remain strong, but can actually be killed.

### Immortal Keyword

- A card with immortal is now immune to non-combat damage.
- This does not mean they are immune to direct FORCE loss (target card loses 1 FORCE).

### Sick Keyword

- Sick was proving to be a bit too strong of a hard control mechanic especially with the new combat, so its receiving this slap on the wrist.
- Sick damage is now rounded down, meaning it can no longer be lethal.

### Set Trigger

The Set trigger has been renamed to Enter. Enter triggers now occur when:

- A card enters play
- An effect card becomes attached to a card
- Enter triggers do not occur when attaching non-effect cards.

This terminology better reflects the mechanic’s actual behavior.

### Perish Trigger

The Perish trigger has been updated to now read "if this card were to perish".

- This now means that the trigger happens before the card hits the discard/void, making reanimation effects much simpler to template.
- This has some small consequences regarding cards that create tokens or set cards when they perish since there is no longer a guaranteed free open zone for the card to enter (this is fine since all create/set/clone effects are considered optional inherently due to board restrictions).

Here is how the trigger now functions:

1. Something causes the card to perish (combat, damage, destruction, etc).
2. The effects of the perish trigger are queued.
3. The effects of the perish trigger resolve.
4. The card actually perishing is queued.

### Mulligans

Mulligans are now being properly introduced.

- If and only if you have no LVL 1 cards in your hand, you can shuffle your hand into your deck and draw 5 new cards.
- You may mulligan as many times as you like under these conditions.

### Life

- Your starting life total is now 15 in standard 1v1.

---

## Template Updates

Several visual and structural improvements have been made to card templates.

### Visual Indicators

- Each text box now includes a label indicating its function
- Trigger badges now display an arrow symbol
- Standard Skills now display a star symbol
- Free Skills now display a cycle symbol

### FORCE Display Improvements

- The concept of no-force cards have been removed, in favour of 0 FORCE with text that says "cannot gain FORCE".
- All instances of “? FORCE” have been replaced with 0 FORCE

### LVL Display Improvements

- LVL is now displayed in card text with a ciruclar icon with a number
- This puts it more in line with FORCE, instead of saying LVL 1 (even though it reads the same)

This improves readability and removes ambiguity.

### Set number

- Each card now displays its official set number.
- This improves identification, collection tracking, and draft functionality.