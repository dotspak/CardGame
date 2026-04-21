# 🃏 Pecto Beta 1.2 Patch Notes 🃏

---

## Overview

This update introduces several core system changes aimed at improving gameplay flow, increasing interaction, and reducing degenerate strategies. Many of these adjustments are foundational and will continue to be monitored closely.

---

## Balance Updates

### Recursion

- Recursion has been further reduced across the board.
- Most effects that return cards from the discard now return 1 fewer card.

### Tutoring

- Most instances of unrestricted tutoring have been replaced with:
  - “Look at the top 5 cards of your deck” effects.
- Additional effects that interact with the top of the deck have been introduced to support this direction.

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

This change removes several edge-case interactions. As a result, setting cast cards in the front row is slightly stronger.

### Reviving

- “Set a card from the discard” has been standardized to the keyword Revive.
- Cards that enter the void after perishing can no longer be revived.

### 0 Force

- Cards can now exist on the board at 0 FORCE.
- If a card loses FORCE outside of taking damage, it may be reduced to 0 FORCE (but not below).
- NULL Force cards remain unchanged.

After testing, 0 FORCE states were found to add meaningful gameplay decisions with minimal added complexity.

### Game Board

- Back row zones reduced from 3 → 2
- Front-row cards can now attack any back-row card instead of attacking the player

These changes reduce back-row safety and encourage more interaction. Previously, back-row positions were too difficult to contest and often led to low-tempo gameplay when attacked.

### Card Draw

- Opening hand size increased from 3 → 4
  - Players still draw on their first turn (effective starting hand: 5 cards)
- Card draw on destruction reduced:
  - Now triggers once per turn (down from twice)

With fewer zones in play, this keeps card flow consistent while reducing tracking complexity.

### LVL System

The LVL system has been updated to a simplified additive model:

- You may always play LVL 1 cards.
- You may also play cards with LVL less than or equal to the total LVL of cards you control.
- Face-down cards and tokens are LVL 1 by default.

This change removes the need for a minimum LVL cap and shifts progression to board investment. This system is more flexible but will be monitored closely due to its volatility.
