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

## System updates

### LVL Cap

The Influence system has been removed and replaced by a new resource called the LVL Cap.

Your LVL Cap determines the highest LVL card you may play (from your hand).
Your LVL cap is equal to the higher of 2 things:

- Its baseline value, which increases by 1 at the start of each turn except the first turn of the game.
- The highest LVL card you control plus one.

This value constantly updates throughout the game.

Additional Changes:

- All effects that modified Influence have been removed or redesigned.
- Most of these effects now modify card LVL instead.

### Card Draw/Opening Hand/Mulligans

It was often the case that games would result in one player using up their hand in an early turn and then be unable to recover for the rest of the game. This often meant that the better opening hand always won.

To fix this, opening hands are being nerfed (but becoming more consistent), and card draw is being buffed/reworked.

Note: Along with these changes, you can no longer choose to go first or second. If you win the coin flip/dice roll at the start, you always go first (going first is almost always better anyways). You draw your opening hand and mulligan after finding out the turn order, so someone going second doesn't have to worry about pulling LVL 1s from the deck.

- Opening Hand
  - You now start with 3 cards in your opening hand.

- Mulligans
  - After seeing your opening 3 cards, you can send up to 3 cards back to your deck and draw a new replacement card.
  - If the player replaced any cards this way, shuffle your deck.

- Card Draw
  - At the start of your turn, you now draw up to 3 cards.
  - If you already have 3 or more cards, instead draw 1 card.

This change casuses opening turns to be less explosive, and reintroduces a proper resource curve to the game. In addition, this also nerfs sacrifice based strategies since cards are overall more sparse now. This change also allows the life total to remain at 10 (15 was considered for a while during this update).

### Movement Phase

Movement is being nerfed since it often created unwinnable scenerios. Movement now functions as such:

- Once per turn, you can swap the positions 2 cards you control, unless they are static or inactive. This does not cause them to re-enter play, but does activate any MOVE triggers.

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

The official rules for casting are as follows:

- When a card activates its Cast ability, discard it. The ability resolves using that card’s state as it last existed in play. The discarded card is not considered a card you control during this effect.

This means a card can never target itself with its cast ability inherently instead of making this a rules exception. In addition to this, if a card had an ability that sets a card, you can set it in the zone this card was cast from.

---

## Gameplay/formatting updates

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
- When a target with Bleed counters takes an instance of damage, they also take an instance of bleed damage equal to the amount of bleed counters on them, then all bleed counters are removed.
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

---

## Template Updates

### Visual Indicators

- Each text box now includes a label indicating its function
- Trigger badges now display an arrow symbol
- Standard Skills now display a star symbol
- Free Skills now display a cycle symbol

### FORCE Display Improvements

- The concept of no-force cards have been removed, in favour of 0 FORCE with text that says "cannot gain FORCE".
- All instances of “? FORCE” have been replaced with 0 FORCE, since they defaulted to 0 anyways.

### Set number

- Each card now displays its official set number.
- This improves identification, collection tracking, and draft functionality.
