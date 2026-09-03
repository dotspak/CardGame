# 🃏 Pecto Beta 2.0 Patch Notes — The Unredacted Update 🃏

---

## Overview

This update makes several large-scale changes to ensure games of Pecto do not result in non-games like previous updates often did.

---

## System Updates

### REWORKED: Targeting

* Anything that targets a card or player now follows more conventional fizzling rules.
* If the target or declarer of an action is no longer valid when that action resolves, the action fizzles.
* This change primarily affects attacking, as the previous retargeting rules have been removed.
* You can no longer choose to attack a card in the back row if there is a card in the front row.
* You may only choose to attack a card in the back row if the front row is open instead of your player attack.
* Castable cards are now strong defensive tools: if one is attacked, you can cast it in response, gain its effect, and cause the attack to fizzle.

### REWORKED: Harmless Keyword → Passive Mechanic

The Harmless keyword had become oversaturated, so it has been replaced with a built-in mechanic rather than remaining a keyword.

* A card can now be **Passive**.
* Passive cards cannot declare attacks or deal damage in combat.
* A passive card is represented by a greyed-out :NULL: icon.

### REWORKED: FORCE/Damage/Loss of Force

* Any instance of "a card loses X:FORCE:" has now been replaced with "a card takes X non-lethal damage".
* In addition to this, cards can now be at the lowest 1:FORCE:.
* If a card were to perish due to non-lethal damage, it instead survives at 1:FORCE: (any excess damage does not count as being dealt).
  * If a card ever has 0 or less :FORCE:, it perishes.
* A card can now have ?:FORCE:.
  * A card with ? :FORCE: effectively doesn't interact with the :FORCE: system at all.
  * These cards cannot gain or lose :FORCE:, deal 0 damage if they enter combat, and always perish if they are dealt damage.
  * This category of cards largely applies to "spell type cards" that solely exist to be activated.
  * Note: Due to these cards effectively having no :FORCE:, they do not take Sick damage.

### REINTRODUCED: The Stack

* After a lot of deliberation, Pecto will once again use a full stack system.
* The stack was previously replaced with a queue in an attempt to simplify the game’s logic, but the queue ultimately made interactions more complicated rather than easier.
* Reintroducing the stack makes card effects less clunky to explain and allows interactions to resolve much more cleanly.
* In addition to this, you can now ONLY respond to a card being activated (attack, skill, cast).
  * This means you can not respond to a card being played or moved. Triggers also cannot be responded to.
* If a card is destroyed before its effect resolves, the effect fizzles.

*In addition to this change, the categories of game actions are being removed.*

---

## Resources

The resource system was actually meant to change this patch to something more traditional, but after heavy testing, the other changes this patch have nullified the issues that the old chaining system has so it will be staying. However, card draw and mulligans are being updated.

### Card Draw

* At the start of each turn, draw 2 cards.
* The first time you destroy an opponent's card each turn, draw a card.

### Opening Hand/Mulligans

* Both players start with 5 cards and don't draw on their first turn.
* Similar to Pokemon, if you have no LVL 1 cards in your hand, reveal your hand and then mulligan (shuffle your hand into your deck and draw 5 new cards). Repeat this process until you have at least 1 LVL 1 card in your hand.
* You get to choose whether you go first or second after seeing your opening hand.

*This system was introduced to ensure players can always play on their first turn, as well as removing some opening hand consistency.*

---

## Balance Updates

### NEW: Flank keyword

* A card with **Flank** attacks the player directly when declaring an attack, but cannot attack cards.
* This keyword is being introduced to re-add some power to aggro strategies, mainly bugs.

### NERF: Victor Trigger

* Similar to the **Quick** keyword, the Victor trigger now only occurs when attacking, not blocking.

### BUFF: Card Draw Cards

* Most card draw cards are now lower LVL than before due to card draw being a turn extender more than straight advantage.

### BUFF: Bleed and Leech

* Bleed and Leech have been updated to **Bleed X** and **Leech X**.
* Each keyword now applies its effect according to its X value.

### BUFF: Healing

* Healing is no longer limited by maximum health.

### BUFF: Sick

* **Sick** damage is now rounded up and can therefore be lethal.

### REMOVED: Warden Keyword

* Due to the back row targetting change being removed, Warden is also being removed as its redundant.

### BUFF: Durability

* To counteract the increasing threat of control and splashable damage, most engine pieces that can't attack have been buffed to at least 2:FORCE:.
* Some cards have alternatively received the **Safe** keyword instead.
* Cards that can only be activated on the opponent's turn now have the **Safe** keyword (Powder, Null and Creation)

### Bead Tokens

* Removed in favour of Ghost tokens.

### Mineral Tokens

* Removed in favour of Object tokens.

---

## Format Updates

### Standard Draft

Standard Draft now follows a more traditional pack-drafting structure.

* The draft must include at least 2 packs per player.
* Each pack contains 12 cards, for a total of 24 drafted cards per player, as before.
* Each player looks at the 12 cards in their pack, chooses 2, and then passes the remaining cards to the next player.
* This process repeats until every pack is empty.
* Once drafting is complete, each player cuts 4 cards from their pool to build a 20-card deck.

Draft formats now allow any number of copies of the same card. This does not affect Full Set Draft, since that format only includes one copy of each card to begin with.
