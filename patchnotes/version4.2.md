# Pecto V4.2 Patch Notes

---

## Overview

The new LVL system introduced has proved to be somewhat problematic. While it often leads to really fun explosive plays, it also leads to an equal amount of bricks, and overall is really hard to come back from if you fall behind. To fix this, the LVL system is being reworked one more time (hopefully).

*Simulator development has been temporarily paused while I focus on other more problematic aspects of the game for now, as well as other projects.*

---

## Player LVL System Rework

The player LVL system now works as so:

- Both players start at player LVL 1.
- You LVL is now only equal to your LVL + floating LVL, meaning you can only by default play cards that are equal to your LVL.
- In addition to this, you may play cards 1 LVL higher than the highest LVL card you control.
- For example, if you control a LVL 1 card, you may play LVL 2 cards, even if your player LVL is 1.
- Note: his change means that LVL 0 cards will be removed from the game, and all will be made LVL 1+.
- This also means that the banished mechanic will be removed in favour of setting cards LVL to 1.

## Offsite Changes

A small simplification/nerf to offsites, as they are a bit strong.

- You now have 2 backrow slots for offsites.
- Units can now target any offsite when attacking.
- Note: The board is now positioned as such:
  - 3 unit slots in front
  - 2 offsites in back, centered around the middle unit lane.

## Middle Row

I have decided to remove the middle row buff where they can attack any unit, because its a mechanic that is either forgotten, or takes over the game. I personally do not like being able to win just by having 1 strong card in the middle lane and it often came down to that.

---

## Keyword Updates

Fragile

- Now triggers on any instance of damage as well as at the end of combat.
- This means that Quick now hard counters any Fragile cards.

## Major Card Updates

Hive Infiltrator

- Reworked to the following effect:
- Perish: If Hive Infiltrator does not have *fragile*, return it to play with *fragile* and *delayed*.
- Removed Bleed.

Mineral God

- Now LVL 5
- Reworked to the following effect:
  - Cannot be targetted by destruction effects.
- Sum of God: is now a free skill.
- Reworked to the following effect:
  - Sacrifice all units you control. Mineral God gains double the force of the units sacrificed.

Red Imp

- Now gains floating LVL instead of increasing its own LVL.

Secret Wizard

- Removed skill.
- Now has the following effect:
- When a spell enters your discard, you may summon it as a Particle token with force equal to the spell's LVL and remove all text.

Honey Larva

- Removed.

Radiant Larva

- Now summons any Bee card in your hand or deck. Cannot target the discard.
