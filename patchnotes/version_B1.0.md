# Pecto Beta 1.0 Patch Notes

---

## Overview

This will be the final update before the Pecto Pounding Invitational. This update ended up being a lot larger than expected. This update will now be the new baseline for the game, and as such the game will now enter Beta, moving out of Alpha.

This update also introduces several foundational changes that simplify gameplay, improve consistency, and better support competitive play.

Beta 1.0 introduces major structural improvements to Pecto:

- Influence replaced with the Level Cap
- Updated card draw system
- Updated combat
- Face-down cards introduced
- Token behavior standardized
- Enter trigger terminology improved
- Card templates refined

These changes improve clarity, consistency, and competitive integrity ahead of the Pecto Pounding Invitational.

---

## Core Rule Updates

### Level Cap

The Influence system has been removed and replaced by a new resource called the Level Cap.

Your Level Cap determines the highest LVL card you may play (from your hand).
Your LVL cap is equal to the higher of 2 things:

- Its baseline value, which increases by 1 at the start of each turn except the first turn of the game.
- The highest LVL card you control plus one.

This value constantly updates throughout the game.

Additional Changes:

- All effects that modified Influence have been removed or redesigned.
- Most of these effects now modify card LVL instead.

### Card Draw/Opening Hand/Mulligans

It was often the case that games would result in one player using up their hand in an early turn and then be unable to recover for the rest of the game. This usually meant previously that the better opening hand always won.

To fix this, opening hands are being nerfed (but becoming more consistent), and card draw is being buffed.

Note: Along with these changes, you can no longer choose to go first or second. If you win the coin flip/dice roll at the start, you always go first (going first is almost always better anyways).

- Opening Hand
  - You now start with 3 cards in your opening hand.

- Mulligans
  - After seeing your opening 3 cards, you can send up to 3 cards back to your deck and draw a new replacement card.
  - If the player replaced any cards this way, shuffle your deck.

- Card Draw
  - At the start of your turn, you now draw up to 3 cards.
  - If you already have 3 or more cards, instead draw 1 card.

### Movement Phase

Movement is being nerfed a decent amount since it often created unwinnable scenerios. Movement now functions as such:

- Once per turn, you can swap 2 cards you control, unless they are static or inactive.

This means that you can swap any 2 cards and neither will become inactive, but you can no longer move a card to an open zone. It also means you cannot attack, swap, attack with new card, but you can swap 2 cards to have them attack different targets. This also removes any confusing adjaceny based rules and streamlines things further.

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

### Casting Cards

This change helps to make casting a bit easier to understand, as well as fixing some annoying templating issues with casting.

When you cast a card:

1. It becomes inactive
2. Its cast ability resolves
3. It is sent to the discard (does not count as perishing)

This means that if a card's cast ability interacts with the discard in any way, this card is not included (unless the ability itself sends it to the discard first somehow).

A card also can never target itself with its cast ability. The card is considered to not exist anymore the second the cast trigger resolves, despite staying on the field. Because of this, if a card had an ability that sets a card, you can set it in the zone this card was cast from.

---

## General Gameplay updates

### Tokens

Tokens now follow standard destruction rules.

- Tokens now enter the discard pile when they perish, then dissapear (not adding to your discard count)
- Celestial tokens now have the Doom keyword to compensate.

Tokens are now universally considered LVL 1 unless stated otherwise.

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
- Effectively this now means that quick cards always win trades on your turn.

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
4. The card then perishes and is sent to the discard.

Similar to casting, the card is already considered to have perished so it cannot be targetted by its own perish effect.

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
- All instances of “? FORCE” have been replaced with 0 FORCE, since they defaulted to 0 anyways.

### LVL Display Improvements

- LVL is now displayed in card text with a ciruclar icon with a number
- This puts it more in line with FORCE, instead of saying LVL 1 (even though it reads the same)

This improves readability and removes ambiguity.

### Set number

- Each card now displays its official set number.
- This improves identification, collection tracking, and draft functionality.
