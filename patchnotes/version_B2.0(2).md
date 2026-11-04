# 🃏 Pecto Beta 2.0 Patch Notes — The Tapping Update 🃏

---

## System Updates

### Resources

* Resources have been completely reworked from the ground up.
* To play a card from your hand, you must deactivate the same amount of cards among active cards you control to play it.
* For example, you must deactivate 2 active cards to play a LVL 2 card.
* With this change, cards now range from LVL 0-3 with LVL 0 cards being the main form of generating resources.
* There are no limits to how many cards you can play in a turn.

### Card Draw

* At the start of each turn except your first turn of the game, draw 2 cards.

### Opening Hand/Mulligans

* Both players start with 5 cards.
* You turn order is decided after seeing your opening hand.
* You may mulligan your hand once to get a new hand by shuffling your hand into your deck and drawing 5 new cards.

*This system was introduced to ensure players can always play on their first turn, as well as removing some opening hand consistency.*

### REWORKED: Targeting

* Anything that targets a card or player now follows more conventional fizzling rules.
* If the target or declarer of an action is no longer valid when that action resolves, the action fizzles.
  * This change primarily affects attacking, as the previous retargeting rules have been removed.
* Castable cards are now strong defensive tools: if one is attacked, you can cast it in response, gain its effect, and cause the attack to fizzle.

### REWORKED: Attacking

* When you declare an attack, you declare whether you are attacking an opponent or the back-row card in the same column (if one exists).
* After declaring your attack, if the targetted player controls a front-row card in the same column, they choose whether or not the card blocks.
* This change was intended to make the game less board wipey, if you need key pieces alive you aren't always forced to lose them now.
  * This change was also intended to add an additional small layer of interaction to the game since interaction isn't as high as some other card games.

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

* Reintroducing the stack makes card effects less clunky to explain and allows interactions to resolve much more cleanly.
* In addition to this, you can now ONLY respond to a card being activated (attack, skill, cast).
  * This means you can not respond to a card being played or moved.
  * Playing cards does not pass priority. Priority is only passed when a card is activated or priority is specifically passed.
  * Triggers also cannot be responded to.
* If a card is destroyed before its effect resolves, the effect fizzles.

*In addition to this change, the categories of game actions are being removed.*

### REWORKED: Castable Cards -> Spellskills and Spell cards

* The term "cast" is being functionally removed from the game.
* Any effect that was previously a cast effect is know being retooled to be a "spellskill", and now goes in the activation box like skills.
  * This means that a card can no longer be cast and have a skill.
* Cards can now only be activated, and the bottom box always refers to a card's 1 potential activation.
* Cards with a spell skill are now referred to as "spell cards".
* Any effect that referred to "when a card is cast" is now reworded to "when a spell card is activated".
* Any reference to a "castable card" has now been replaced with "spell card".
* Spellskills do not have skill names like normal or reusable skills, they are all referred to as "spell" in a bluebox.

*Spellskills and spell cards are functionally identical to previous patch this is mostly just a formatting change.*

### REMOVED: Face-down cards

* Any instances of face-down cards have been removed from the game.

---

## Balance Updates

### NEW: Flank keyword

* A card with **Flank** can attack from the back-row.

### REINTRODUCED: Response Keyword

* A card with Response can be played from your hand as a response.

### REWORKED: Muted -> Breaker

* A card with Breaker must target a the back-row if possible, and must always be blocked by the opposing front-row card.
* Cards with Breaker can deal combat damage to the player, but the opposing column must be empty.

### BUFF: Bleed and Leech

* Bleed and Leech now apply 2 wounds and HEAL 2 respectively.

### BUFF: Sick

* **Sick** damage is now rounded up and can therefore be lethal.
* Cards no longer gain **Sick** when a **Sick** card deals combat damage to another card.

### REMOVED: Warden Keyword

* Due to the back row targetting change being removed, Warden is also being removed as its redundant.

### REMOVED: Quick Keyword

* Quick has been a historically toxic design for the game and is typically given to strong VICTOR cards.
* It is being removed to promote more healthy design for these cards instead of an auto win tool.

### REWORKED: Delayed Keyword

* A Delayed card no longer enters inactive.
* Cards with Delayed cannot be activated the first turn they are set but can move and be used for resources.

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
