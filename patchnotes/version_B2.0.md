# 🃏 Pecto Beta 2.0 Patch Notes — The Unredacted Update 🃏

---

## Overview

This update makes several large-scale changes that move the game in a much cleaner direction overall, notably the new resource system.

---

## System Updates

### REWORKED: Targeting

* Anything that targets a card or player now follows more conventional fizzling rules.
* If the target or declarer of an action is no longer valid when that action resolves, the action fizzles.
* This change primarily affects attacking, as the previous retargeting rules have been removed.
* Castable cards are now strong defensive tools: if one is attacked, you can cast it in response, gain its effect, and cause the attack to fizzle.

* You can no longer choose to attack a card in the back row if there is a card in the front row.
* You may only choose to attack a card in the back row if the front row is open.

### REWORKED: Harmless Keyword → Passive Mechanic

The Harmless keyword had become oversaturated, so it has been replaced with a built-in mechanic rather than remaining a keyword.

* A card can now be **Passive**.
* Passive cards cannot declare attacks.
* A passive card is represented by a greyed-out :NULL: icon.
* Being passive does not change how the card’s :FORCE: works in combat; it only prevents the card from attacking.
* Overall, this is a much cleaner system than the Harmless keyword.

### REINTRODUCED: The Stack

* After a lot of deliberation, Pecto will once again use a full stack system, functioning essentially the same way as the stack in *Magic: The Gathering*.
* The stack was previously replaced with a queue in an attempt to simplify the game’s logic, but the queue ultimately made interactions more complicated rather than easier.
* Reintroducing the stack makes card effects less clunky to explain and allows interactions to resolve much more cleanly.

*In addition to this change, the categories of game actions are being removed. Triggers can now be responded to.*

---

## Resources

The resource system is the largest change in this patch. I loved the chaining system and the interesting games it created around 60% of the time. However, the other 40% often became non-games where one player popped off, wiped the opponent’s board, and effectively ended the game on the spot. Even worse, players could sometimes begin with completely dead hands, making the game feel unplayable from turn one.

Because of this, I am replacing the chaining system with a more conventional resource system while preserving Pecto’s no-ramping structure.

*Note: I am still working out the best way to visually represent this system, but its mechanics are complete. This is why the mechanic is just being called "resources" for now instead of a proper name.*

### Resource System

* At the start of each turn, you receive 6 resources to play cards.
* Your resources always reset to exactly 6. They cannot be stockpiled between turns.
* A card’s LVL determines how many resources you must spend to play it.
  * Card LVLs now range from 0–4 instead of 1–3.
  * LVL 0 and LVL 4 cards are intentionally rare. LVL 0 cards generally serve as simple utility pieces, while LVL 4 cards represent huge tempo swings or potential checkmate pieces.

These changes prevent truly dead hands and create a more consistent push and pull around resource management while preserving the board-centric, sequencing-first gameplay Pecto is known for.

### Card Draw/Opening Hands/Mulligans

* At the start of each turn, draw until you have 5 cards in hand.
* This also means you have an opening hand of 5 now.

---

## Balance Updates

### NERF: Victor Trigger

* Similar to the Quick keyword, the Victor trigger now only occurs when attacking, not blocking.

### BUFF: Card Draw Cards

* Most card draw cards are now lower LVL than before due to card draw being a turn extender more than straight advantage.

### BUFF: Bleed and Leech

* Bleed and Leech have been updated to **Bleed X** and **Leech X**.
* Each keyword now applies its effect according to its X value.

### BUFF: Healing

* Healing is no longer limited by maximum health.

### BUFF: Sick

* Sick damage is now rounded up and can therefore be lethal.

### REMOVED: Warden Keyword

* Due to the back row targetting change being removed, Warden is also being removed as its redundant.

### BUFF: Durability

* To counteract the increasing threat of control and splashable damage, most engine pieces that can't attack have been buffed to at least 2:FORCE:.
* Some cards have alternatively received the SAFE keyword instead.
* Cards that can only be activated on the opponent's turn now have the SAFE keyword (Powder, Null and Creation)
* Spell type cards that exist only to be immediately CAST remain as 0:NULL:.

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
