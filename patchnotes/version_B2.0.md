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
* Castable cards are now strong defensive tools: if one is attacked, you can cast it in response, gain its effect, and cause the attack to fizzle.

### REWORKED: Attacking

* When you declare an attack, you declare whether you are attacking an opponent or a back-row card in the same column (if one exists).
* After declaring your attack, if the targetted player controls a front-row card in the same column, they choose whether or not the card blocks.
* This change was intended to make the game less board wipey, if you need key pieces alive you aren't always forced to lose them now.
  * This change was also intended to add an additional small layer of interaction to the game since interaction isn't as high as some card games.

### REWORKED: Harmless Keyword → Passive Mechanic

The Harmless keyword had become oversaturated, so it has been replaced with a built-in mechanic rather than remaining a keyword.

* A card can now be **Passive**.
* Passive cards cannot declare attacks or deal damage in combat.
* A passive card is represented by a greyed-out :NULL: icon.

### REWORKED: FORCE/Damage/Loss of Force

* Any instance of "a card loses X:FORCE:" has now been replaced with "a card takes X non-lethal damage".
* In addition to this, cards can now be at the lowest 1:FORCE: if it entered above 1.
* If a card were to perish due to non-lethal damage, it instead survives at 1:FORCE: (any excess damage does not count as being dealt).
  * If a card ever has 0 or less :FORCE:, it perishes.
* A card can still enter with 0:FORCE:.
  * A card with 0:FORCE: effectively doesn't interact with the :FORCE: system at all.
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

* The old chaining system has returned with some slight changes.
* For one, cards now range from LVL 1-4.
* Your Chain is equal to the highest LVL card you control + 1.
* You may play any card with LVL less than or equal to your Chain, and you can always play LVL 1 cards.
* In addition to this, you may now only play 3 cards from your hand each turn.
  * This change was intended to more so give limits to turns.
  * There are now more turns to the game, but each turn is much quicker so the game is roughly the same length regardless.
  * This change also adds much more interaction between players since there is more back and forth.
* There is no longer a turn counter that increases each turn.
* Your chain is entirely dependant on the cards you control.

### Card Draw

* At the start of each turn except your first turn of the game, draw 2 cards.

### Opening Hand/Mulligans

* Both players start with 5 cards.
* You turn order is decided before seeing your opening hand.
* Similar to Pokemon, if you have no LVL 1 cards in your hand, you may mulligan your hand.
  * To mulligan your hand, reveal it to all players and place it on the bottom of the deck in whatever order you like.
  * After you do this, draw 5 new cards.
  * Repeat this process until you have at least 1 LVL 1 in hand.

*This system was introduced to ensure players can always play on their first turn, as well as removing some opening hand consistency.*

---

## Balance Updates

### NEW: Flank keyword

* A card with **Flank** can attack from the back-row.

### REWORKED: Muted -> Breaker

* A card with Breaker must target a the back-row if possible, and must always be blocked by the opposing front-row card.
* Cards with Breaker can deal combat damage to the player, but the opposing column must be empty.

### BUFF: Bleed and Leech

* Bleed and Leech now apply 2 wounds and HEAL 2 respectively.

### BUFF: Sick

* **Sick** damage is now rounded up and can therefore be lethal.
* Cards no longer gain **Sick** when a **Sick** card deals combat damage to another card.

### NERF: Victor Trigger

* Similar to the **Quick** keyword, the Victor trigger now only occurs when attacking, not blocking.

### BUFF: Card Draw Cards

* Most card draw cards are now lower LVL than before due to card draw being a turn extender more than straight advantage.

### BUFF: Healing

* Healing is no longer limited by maximum health.

### REMOVED: Warden Keyword

* Due to the back row targetting change being removed, Warden is also being removed as its redundant.

### REMOVED: Quick Keyword

* Quick has been a historically toxic design for the game and is typically given to strong VICTOR cards.
* It is being removed to promote more healthy design for these cards instead of an auto win tool.

### BUFF: Durability

* To counteract the increasing threat of control and splashable damage, most engine pieces that can't attack have been buffed to at least 2:FORCE:.
* Some cards have alternatively received the **Safe** keyword instead.
* Cards that can only be activated on the opponent's turn now have the **Safe** keyword (Powder, Null and Creation)

### Ghost Tokens

* Ghost Tokens are now 1FORCE/FLANK.

### Bead Tokens

* Removed in favour of Ghost tokens.

### Mineral Tokens

* Removed.

---

## Format Updates

### Constructed

Constructed deck size is increasing to allow duplicates of cards in a deck

* Mimimum deck size increased from 20 -> 30
* Maximum copy per card increased from 1 -> 2
* These changes are being done to make strategies more specific.
* This also allows players to get to their key pieces easier hopefully lowering luck and increasing skill.

### Standard Draft

Standard Draft now follows a more traditional pack-drafting structure.

* The draft must include at least 3 packs per player.
* Each pack contains 12 cards, for a total of 36 drafted cards per player, as before.
* Each player looks at the 12 cards in their pack, chooses 2, and then passes the remaining cards to the next player.
* This process repeats until every pack is empty.
* Once drafting is complete, each player cuts 6 cards from their pool to build a 30-card deck.

Draft formats now allow any number of copies of the same card. This does not affect Full Set Draft, since that format only includes one copy of each card to begin with.
