# 🃏 Pecto Beta 1.2 Patch Notes 🃏

---

## Overview

While initially scoped as much smaller, this update made many potential improvments to the core of the game come to light. The patch is larger than intended due to this. This update introduces several core system changes aimed at improving gameplay flow, increasing interaction, and reducing degenerate strategies.

---

## System Updates

### Attacking

When you declare an attack, you choose a zone to attack.

- You may target the front-row or back-row zone in the same column.
- If the front-row zone is open, you may instead target the player.
- If both the front and back row are open, you can only target the player.

At resolution:

- If a card is in the targeted zone, they fight.
- If the targeted zone is empty, the attack instead deals damage to the player.

Additional rules:

- Attacks always resolve unless the attacking card is removed or gains MUTED before resolution.
- If a card moves into the targeted zone before resolution, it becomes the new defender.
- If a card leaves the targeted zone before resolution, it is no longer involved in the attack.

*Attacks now resolve based on zones rather than specific cards. This ensures combat always results in damage, while still allowing movement and positioning to influence outcomes.*

### LVL System

- The minimum LVL cap is being removed.
- Your LVL cap is now always equal to the highest LVL card you control + 1.
  - This means if you control no cards: highest LVL = 0 + 1 = 1
  - LVL 1 cards are therefore always playable.
- Tokens and face downs count as LVL 1 cards.

Formal rules:

- You may play cards with LVL up to 1 higher than the highest LVL among cards you control.
- LVL Cap: highest LVL you control +1.

*With LVL capped at 3, the minimum LVL system wasn’t doing much for the game anymore. Removing it cuts down on tracking and shifts progression to board investment instead of turn count.*

### Card Draw

- Opening hand size increased from 3 → 4
- Players still draw on their first turn (effective starting hand: 5 cards)
- Break Bonus:
  - The first time you destroy an opponent’s card during your turn, draw a card.

### Game Actions & Responses

Game actions are now divided into three categories:

- Committed (Set, Cast):
  - Resolve immediately. Players may respond after the effect resolves.
  - After the action resolves, the opponent may respond.
  - These actions cannot be interrupted before resolving.

- Contestable (Attacks, Skills):
  - When a contestable action is declared:
    - Targets are chosen immediately.
    - Costs and conditions are paid when the action is activated.
  - The opponent may respond before the action resolves.
  - When the action resolves:
    - If both the source and the target are still valid, the action resolves.
    - Otherwise, the action fizzles.
  
*In the case of attacks, since a zone is always valid, an attack can never fizzle (despite being in this category).*

- Uninteractable (Triggers):
  - Triggers are not game actions and cannot be responded to.
  - Triggers resolve automatically after the effect that caused them.

*This change standardizes how interaction works across the game while giving each action type a clear identity. Committed actions provide reliable value, contestable actions introduce counterplay and timing decisions, and triggers remain fast and seamless. This system increases depth without adding stack complexity and makes it easier to understand when and how players can respond.*

### Discard + Void

- Discarded and Voided now refer only to cards that are sent to those zones from outside play.
- If a card says “when/if a card is discarded”, it means a card is put into the discard without perishing.
  - The same applies to “when/if a card is voided.”
- A card only perishes if it is put into the discard from play.
- If a card would be put into the discard from play but goes to the void instead, it does not perish.

### Going Second

- The player going second now has no restrictions.

*Removing all restrictions prevents the degenerate strat of playing no cards on your first turn pretty much entirely and doesn't cause games to be overly explosive.*

### Reviving

- “Set a card from the discard” has been standardized to the keyword Revive.
- Cards that enter the void after perishing can no longer be revived.

---

## New Keywords

### Warden

- Back row cards you control in the same column as this card cannot be targetted for attacks.

*This keyword keeps some of the old defensive play possible while not making it a hard rule for every card.*

### Harmless

- Cannot declare attacks.

*This keyword is basically replacing static, because its a much more fun mechanic.*

---

## Balance Updates

### Force

- Baseline FORCE values have been standardized:
  - LVL 1: 2 FORCE
  - LVL 2: 3 FORCE
  - LVL 3: 4 FORCE
  - LVL 3 cards retain greater variance, as they represent the primary source of high-impact effects.

*These numbers are more for what is considerd an "on-par" card. Cards can still have stats above and below these values. Additionally, 4 FORCE is now the highest a card can be without being muted, delayed, or static.*

### Recursion

- Recursion has been further reduced across the board.
- Most effects that return cards from the discard now return 1 fewer card.

*Recursion strategies have consistently pushed past intended limits, especially when combined with discard engines. These changes aim to slow down recursive loops without removing the archetype entirely.*

### Tutoring

- Most instances of unrestricted tutoring have been replaced with:
  - “Look at the top X cards of your deck” effects.
  - You are always guaranteed to draw 1 card with these effects if the search fails.
- Additional effects that interact with the top of the deck have been introduced to support this direction.

*Full-deck tutoring proved too consistent in a 20-card singleton format. Moving to top-of-deck filtering preserves decision-making while restoring variance.*

### Specific Value Searching

- Effects that look at a specific number of cards from a pile now resolve using as many cards as possible.
- If an effect would look at more cards than are available, it instead looks at all remaining cards.

*This change improves consistency and removes unnecessary failure cases. Effects now behave intuitively in low-resource situations, ensuring they still provide value instead of fizzling due to insufficient cards.*
