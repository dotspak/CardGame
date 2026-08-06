# 🃏 Pecto Beta 2.0 Patch Notes — The Unredacted Update 🃏

---

## Overview

This update makes several large-scale changes that move the game in a much cleaner direction overall. While some of these changes make Pecto slightly more similar to other card games—particularly its resource system—the game still retains plenty of the flair that makes it unique.

---

## System Updates

### REWORKED: Targeting

* Anything that targets a card or player now follows more conventional fizzling rules.
* If the target or declarer of an action is no longer valid when that action resolves, the action fizzles.
* This change primarily affects attacking, as the previous retargeting rules have been removed.
* Castable cards are now strong defensive tools: if one is attacked, you can cast it in response, gain its effect, and cause the attack to fizzle.

### REWORKED: Harmless Keyword → Passive Mechanic

The Harmless keyword had become oversaturated, so it has been replaced with a built-in mechanic rather than remaining a keyword.

* A card can now be **Passive**.
* Passive cards cannot declare attacks.
* A passive card is represented by a greyed-out FORCE icon.
* Being passive does not change how the card’s FORCE works in combat; it only prevents the card from attacking.
* Overall, this is a much cleaner system than the Harmless keyword.

### REINTRODUCED: The Stack

* After a lot of deliberation, Pecto will once again use a full stack system, functioning essentially the same way as the stack in *Magic: The Gathering*.
* The stack was previously replaced with a queue in an attempt to simplify the game’s logic, but the queue ultimately made interactions more complicated rather than easier.
* Reintroducing the stack makes card effects less clunky to explain and allows interactions to resolve much more cleanly.

### REWORKED: Bleed and Leech

* Bleed and Leech have been updated to **Bleed X** and **Leech X**.
* Each keyword now applies its effect according to its X value.

### REWORKED: Healing

* Healing is no longer limited by maximum health.

---

## Resources

The resource system is the largest change in this patch. I loved the chaining system and the interesting games it created around 60% of the time. However, the other 40% often became non-games where one player popped off, wiped the opponent’s board, and effectively ended the game on the spot. Even worse, players could sometimes begin with completely dead hands, making the game feel unplayable from turn one.

Because of this, I am replacing the chaining system with a more conventional resource system while preserving Pecto’s no-ramping structure.

*Note: I am still working out the best way to visually represent this system, but its mechanics are complete.*

### NEW: Resource System

* At the start of each turn, you receive 6 resources to play cards.
* Your resources always reset to exactly 6. They cannot normally be stockpiled between turns.
* A card’s LVL determines how many resources you must spend to play it.

  * Card LVLs now range from 0–4 instead of 1–3.
  * LVL 0 and LVL 4 cards are intentionally rare. LVL 0 cards generally serve as simple utility pieces, while LVL 4 cards represent huge tempo swings or potential checkmate pieces.

These changes prevent truly dead hands and create a more consistent push and pull around resource management while preserving the board-centric, sequencing-first gameplay Pecto is known for.

### NEW: Cost Reduction

* Rather than generating additional resources, cards can reduce the cost of the next card you play.
* For example: **“PERISH: Your next card costs 2 less.”** This reduces that card’s LVL by 2 when determining its cost.
* A card’s cost can be reduced to 0, but never below 0.
* Cost reduction carries over between turns and can be stockpiled.
* This is the closest the new system comes to allowing resources to be saved between turns.

### REWORKED: Card Draw, Mulligans, and Opening Hands

* At the start of each turn, draw 2 cards.

While I liked the back-row draw system in theory, it was simply too snowball-heavy and punishing in practice. Drawing 2 cards each turn avoids the sluggishness of drawing only 1 card, without creating the excessive hand replenishment caused by drawing up to a fixed hand size. It also slightly reduces the value of additional card-draw effects.

* After turn order is decided, each player draws an opening hand of 4 cards.
* You may choose any number of those cards and place them on the bottom of your deck.
* After making all of your choices, draw the same number of replacement cards.
* This mulligan can only be performed once.

---

## Format Updates

### REWORKED: Standard Draft

Standard Draft now follows a more traditional pack-drafting structure.

* The draft must include at least 2 packs per player.
* Each pack contains 12 cards, for a total of 24 drafted cards per player, as before.
* Each player looks at the 12 cards in their pack, chooses 2, and then passes the remaining cards to the next player.
* This process repeats until every pack is empty.
* Once drafting is complete, each player cuts 4 cards from their pool to build a 20-card deck.

Draft formats now allow any number of copies of the same card. This does not affect Full Set Draft, since that format only includes one copy of each card to begin with.

### REWORKED: Constructed

* Constructed decks may now contain up to 2 copies of each card.

Constructed is moving away from singleton because allowing 2 copies of a card creates more room for focused strategies. Pecto’s card pool is much more mechanically open than those of many other card games—there are no traditional card types and only one universal resource—so this added consistency does not feel overly repetitive. A 20-card deck is not simply dominated by monsters or spells; it is shaped by the strategy the player chooses to pursue.

Alongside this change, I plan to eventually introduce a limited and banned list that will not apply to draft formats. The list will not become active until after the game’s official release and the formation of a proper metagame, though I will maintain a soft watchlist in the meantime. I also hope to avoid standard rotation and instead use the limited and banned list only when necessary, ideally limiting problematic cards rather than banning them outright.

I will be watching and testing this change very closely. I want to move away from singleton for several reasons, but Constructed may eventually need to increase from 20-card decks to 30-card decks. Draft decks will remain at 20 cards regardless.
