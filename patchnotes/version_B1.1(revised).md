# 🃏 Pecto Beta 1.1 Patch Notes 🃏

---

## Overview

Following the Pecto Pounding, several core issues have become clear—primarily centered around card design and overall game balance.

This update represents a shift in balance philosophy rather than a complete gameplay overhaul (although most cards will receive adjustments).

- Key Areas of Change
- Card playability
- Destruction systems
- Recursion access
- LVL scaling
- Repeatable abilities
- First vs. second player balance

## Balance Philosophy Updates

### Destruction → Direct Damage

Destruction has proven difficult to balance and frequently leads to unhealthy gameplay patterns. As a result:

- Destruction is being removed and replaced with direct damage systems.

This aligns better with Pecto’s intended design, where:

- Stat manipulation and combat matter more than binary removal.
- Board presence is more meaningful.

Additional Rule Clarifications:

- Damage is now capped at a card’s current FORCE.
- Excess damage is ignored.
- 0 damage is no longer considered “dealing damage”

Example:
If a 3 FORCE unit takes 5 damage, it only takes 3 damage.

### Recursion

Recursion remains a core and enjoyable mechanic, but is being significantly toned down.

- Deck recycling effects remain unchanged.
- Returning cards from discard now requires additional costs (e.g., discard, life loss).
- Many effects are now randomized:
  - Example: “Add 2 random cards from your discard to your hand”
- Effects usually need sufficient valid targets to resolve.

### Life as a Resource

Life costs are being increased across the board to better support the 10-life system and improve game pacing.

### Keyword Usage (Muted, Static, Delayed)

These keywords will now be used more selectively, particularly Static, which has been adjusted (see below).

### Tutoring

Tutoring is being slightly reduced. While not inherently problematic, it is currently too efficient.

Priority has been placed on addressing recursion first, so tutoring adjustments are more moderate.

### LVL System

Maximum card LVL is now 3

Higher LVL cards (4–5) were difficult to balance and often required game-ending power to justify their cost.

With LVL now capped at 3:

- LVL 1 → Engine/setup cards
- LVL 2 → Core interaction (damage/disruption)
- LVL 3 → Build-around payoff cards

This creates a more stable and predictable balance framework.

---

## System Updates

### Game Board

- Back row zones increased from 2 → 3.

This ensures:

- Each front row card has a clear opposing target.
- Increased board space and play flexibility.

### Attacking

When a card attacks, it targets the opposing front row zone.

- If a card is in that zone when the attack resolves, it is attacked.
- If the zone is empty, choose to attack the player or the back row in that column.

### Healing

- You can now gain life up to 20.
- You cannot gain excess life.
- 0 Healing no longer counts as healing.
- Example: if you were at 19 and you healed 3, you would only heal 1.

### Card Draw (Reworked)

The draw system has been redesigned to be more engaging and to encourage interaction.

- At the start of your turn:
  - Draw 1 card.
  - Draw an additional card if you control 2 or more back row cards.
- Additionally:
  - The first time during each of your turns you destroy an opponent's card, draw a card (does not include opponent sacrifices or casts).

This allows up to 3 cards per turn through system draw.

Design goal:

- Encourage active gameplay and board interaction.
- Reduce stalled board states.
- Ensure players have access to playable resources.

### Turn Order Adjustments

- The player going second may now attack on their first turn.
- They cannot attack the player on that turn.

### 0 FORCE Cards

- The "no FORCE" concept has returned as 0 FORCE

Cards with 0 base FORCE:

- Cannot gain FORCE.
- Display a greyed-out FORCE icon.
- Are not intended for combat (but can still attack).

All cards intended for combat now have at least 1 FORCE.

---

## Keywords

### NEW: Spell

Replaces the Response keyword.

- Spell cards can be set as a response.
- Opponent receives priority before the spell resolves.
- After their response (or pass), you may activate the spell (cast, skill).

### NEW: Leech

When this hits a player, HEAL 1.

- Does not require damage to trigger.
- Only requires successfully hitting the player.

### Bleed

- Bleed counters are now removed after dealing bleed damage.

### Effect

- Removed

The effect keyword was underutilized and created confusion.

- Attached cards still exist but function more simply.
- Some cards have been redesigned or replaced accordingly.
- This system may be revisisted in the future.

### Muted

- Cards with muted cannot target the player for attacks.
- May still attack back row cards.

### Static

- Static cards enter inactive and can never become active.

Used for powerful passive effects, typically in the back row. This keyword will be used sparingly due to its inherently low interaction.
