# 🃏 Pecto Beta 1.2 Patch Notes 🃏

---

## Overview

This update introduces several core system changes aimed at improving gameplay flow, increasing interaction, and reducing degenerate strategies. Many of these adjustments are foundational and will continue to be monitored closely.

---

## Balance Updates

### Recursion

- Recursion has been further reduced across the board.
- Most effects that return cards from the discard now return 1 fewer card.

*Recursion strategies have consistently pushed past intended limits, especially when combined with discard engines. These changes aim to slow down recursive loops without removing the archetype entirely.*

### Tutoring

- Most instances of unrestricted tutoring have been replaced with:
  - “Look at the top 5 cards of your deck” effects.
- Additional effects that interact with the top of the deck have been introduced to support this direction.

*Full-deck tutoring proved too consistent in a 20-card singleton format. Moving to top-of-deck filtering preserves decision-making while restoring variance.*

### Force

- Baseline FORCE values have been standardized:
  - LVL 1: 2 FORCE
  - LVL 2: 3 FORCE
  - LVL 3: 4 FORCE
  - LVL 3 cards retain greater variance, as they represent the primary source of high-impact effects.

---

## System Updates

### Attacking

- If a targeted card leaves play before an attack resolves, the attack now fizzles.

*This removes unintuitive edge cases and simplifies combat resolution. It also slightly increases the viability of reactive positioning and front-row setup.*

### Reviving

- “Set a card from the discard” has been standardized to the keyword Revive.
- Cards that enter the void after perishing can no longer be revived.

### 0 Force

- Cards can now exist on the board at 0 FORCE.
- If a card loses FORCE outside of taking damage, it may be reduced to 0 FORCE (but not below).
- NULL Force cards remain unchanged.

*0 FORCE states introduce meaningful edge cases and interactions that were lost when previously removed. The added depth outweighs the minimal rules overhead.*

### Game Board

- Back row zones reduced from 3 → 2
- Front-row cards can now attack any back-row card instead of attacking the player

*Back-row strategies had become too safe and difficult to interact with. These changes make back-row positioning more deliberate and allow players to contest key pieces without sacrificing excessive tempo.*

### Card Draw

- Opening hand size increased from 3 → 4
  - Players still draw on their first turn (effective starting hand: 5 cards)
- Card draw on destruction reduced:
  - Now triggers once per turn (down from twice)

*Increasing starting hand size improves early-game consistency and reduces non-games. The draw reduction keeps overall card flow in check, especially with fewer zones in play.*

### LVL System

The LVL system has been updated to a simplified additive model:

- You may always play LVL 1 cards.
- You may also play cards with LVL less than or equal to the total LVL of cards you control.
- Face-down cards are LVL 1 by default.
- Tokens have no LVL and are effectively LVL 0.

*With LVL capped at 3, the minimum LVL system wasn’t doing much anymore. Removing it cuts down on tracking and shifts progression to board investment instead of turn count. This system is more flexible, but also more volatile, so we’ll be keeping a close eye on it.*
