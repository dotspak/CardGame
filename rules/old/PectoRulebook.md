# Pecto Rulebook V1.0

*A strategic card game of mind, influence, and control.*

---

## Table of Contents

1. [Overview](#overview)
2. [Objective](#objective)
3. [Deck Construction/Rules](#deck-constructionrules)
4. [Influence System](#influence-system)
5. [Card Types](#card-types)
6. [Starting a Game](#starting-a-game)
7. [Turn Structure](#turn-structure)
8. [Combat](#combat)
9. [Ending a Game](#ending-a-game)
10. [Triggers](#triggers)
11. [Skills](#skills)
12. [Stats & Keywords](#stats--keywords)
13. [Special Rules](#special-rules)
14. [Glossary](#glossary)
15. [Credits](#credits)

---

## Overview

**PectoTCG** is a tactical card game where players summon powerful units and control mysterious off-sites to dominate their opponent through strategy and timing.

- **Players:** 2  
- **Deck Size:** 20 cards (1 copy of each card)  
- **Game Length:** ~10–20 minutes  
- **Goal:** Reduce your opponent’s Life to 0 through strategic control of the field and Influence.

---

## Objective

Defeat your opponent by reducing their **Life** to 0 or reach 30 Influence.

---

## Deck Construction/Rules

Decks consist of any 20 legal Pecto cards, with any amount of units, offsites, or spells. You may only include 1 card of a given name in a deck. A deck must include at least 1 LVL 1 Unit or Offsite.

At the start of each turn, you draw a card from your deck. If you were to draw a card and your deck is empty, you shuffle your discard pile face down and make that your new deck. This is referred to as **recycling your deck**. Some cards allow you to manually recycle your deck: in this instance, shuffle your graveyard into your deck.

---

## Influence System

**Influence** is the game’s main resource system.

- You always have **at least 1 Influence**, unless an effect states otherwise.  
- You may only play cards with **LVL ≤ your current Influence**.  
- Your **current Influence** is equal to the **total LVL** of all cards you control.
- **Banished** cards provide **no Influence** and are marked with a red LVL icon.  
- A **LVL 0 card** means it does not increase Influence.

**Example:**

- You control a LVL 2 unit and a LVL 3 off-site → total Influence = 5.  
- You may now play cards with LVL 5 or lower.

---

## Card Types

Cards can be played from your hand so long as your meet their play requirements. Usually this is just your influence being less than or equal to their LVL (icon in the top right), but occaisonally cards have additional costs as well.

### Units

- Coloured with pink borders and icons.
- Played to your **front row** in 1 of 3 unit slots.  
- Used as your primary attackers and defenders.  
- Each has a **LVL**, **Force**, **Subtype**, and optional **Keywords** (yellow text) or **Skills** (pink or green blocks).

### Off-Sites

- Coloured with yellow borders and icons.
- Played to your **back row** in 1 of 3 offsite slots.  
- Provide ongoing or triggered effects that influence the game.
- Each has a **LVL**, **Force**, **Subtype**, and optional **Keywords** (yellow text) or **Skills** (pink or green blocks).

### Spells

- Coloured with blue borders and icons.
- Played from your hand with no restriction.
- Goes to the discard after resolving (except Effect spells).
- Spells without the **Instant** keyword can only be played on your turn.
- Spells with the **Instant** keyword can be played in response to other actions that occur.
- Spells with the **Effect** keyword are attached to a card in play and go to the discard pile when the card exits play.

### Tokens

- Coloured with gray borders and icons.
- Created by other cards or effects.
- They are assumed to be LVL 0 unless stated otherwise.
- Can be played in any open slot.
- Follow all normal rules unless otherwise stated.

---

## Starting a Game

1. Shuffle your 20-card deck.
2. Both players roll a dice. Whoever gets the higher roll chooses whether to go first or second.
3. Draw 5 cards as your starting hand.
4. If the starting hand does not include a LVL 1 unit or offsite, shuffle your hand into your deck and draw a new hand.
5. Each player starts with **10 Life** and **1 Influence** (minimum).
6. The player going first cannot attack on the first turn.

---

## Turn Structure

Each player takes turns consisting of the following phases:

### 1. Start Phase

- Resolve “at the start of your turn” effects.  
- **Sick** units deal damage to their controller.
- Units become active.
- Draw a card for the turn.

### 2. Main Phase

- Play cards as long as their **LVL ≤ your Influence**.  
- Declare attacks, activated skills, move units.
- You may freely declare attacks per unit. There is no limit to the amount of attacks declared each turn.
- You cannot declare attacks on the first turn of the game.
- Only active units can declare attacks.
- You may declare the end of your turn at any point during this phase.

### 3. Combat Phase

- Declare attacks (see [Combat](#combat)).
- Resolve damage between opposing units, off-sites, or directly to the player.
- Returns to the Main Phase after.

### 4. End Phase

- Resolve “End" triggers.  
- Effects like **Immortal** restore units’ Force.

---

## Combat

Combat is where units deal and receive damage.

### Declaring Attacks

- Units in the **front row** attack first.  
- Units attack the **lane directly in front** of them, unless a rule allows otherwise.
- If the lane is empty, they may attack the opponent’s **Life** or their **Off-Site** in the respective lane.

### Middle Unit Flexibility

- The **middle unit** can attack **any opposing unit or off-site** when able.

### Damage Resolution

- Cards deal damage equal to their **Force** to the target.  
- When a cards’s Force is reduced to 0, it is **dismissed** (sent to the discard pile).
- If a card enters with 0 Force, it does not perish until it takes damage, but also deals no damage.
- Cards deal damage to each other at the same time unless the attacker has the *Quick* keyword.
- Damage is **permanent** unless healed or prevented by an effect.

### Special Cases

- **Bleed:** Any damage from this unit destroys the opposing unit.  
- **Immortal:** Fully heals after combat during the end phase.  
- **Sick:** Damages its controller automatically at turn start.

---

## Ending a Game

The game ends when:

- A player’s **Life** reaches 0.  
- A player were to draw a card and their deck and discard is empty.
- A player reaches 30 influence.

If both players reach 0 Life simultaneously, the player who's currently taking their turn wins.

---

## Triggers

Some cards have yellow badges that signify when certain effects trigger. For example, a card with the "Begin" trigger, has an effect that applies at the start of the owner's turn.

| Name | Trigger Condition |
| ------- | ----------- |
| **Begin** | Triggers at the start of the owner's turn. The owner chooses the order these effects resolve. |
| **Enter** | Triggers when the card enters the field. |
| **Perish** | Triggers when the card leaves the field, unless specified otherwise. |
| **End** | Triggers at the end of the owner's turn. The owner chooses the order these effects resolve. |
| **Victor** | Triggers if a card enters combat and exits without perishing. |

---

## Skills

Units and Offsites sometimes have a second pink or green block of text with a pink or green badge at the start. These blocks represent skills and their effects. Skills are activated effects, and are by default at sorcery speed. All skills require the card to be active in order to be used.

- **Basic Skill**: Represented by a pink background and pink badge. These skills cause the card to become inactive.
- **Free Skill**: Rrepresented by a green background and green badge. These skills do not cause the card to become inactive.

Skills can also alternatively be used at instant speed if they are indicated as such.

---

## Stats & Keywords

### Core Stats

| Stat | Description |
|------|--------------|
| **LVL** | The card’s cost and weight. Determines if it can be played based on your current Influence. |
| **Force** | A unit’s total power and durability. Equal to both its attack and health. Damage is permanent. |
| **Influence** | Your available power. Equal to the sum of all LVLs of cards you control. |
| **Life** | The player’s health. You lose when it reaches 0. |

### Keywords

| Keyword | Description |
|----------|-------------|
| **Delayed** | Enters the field inactive (cannot attack or use skills until next turn). |
| **Sick** | Deals half its Force (rounded up) as damage to its controller at the start of their turn. |
| **Bleed** | Any damage dealt by this unit is enough to destroy the opposing unit or offsite. |
| **Immortal** | Fully heals damage at the end of your turn. |
| **Static** | Cannot be swapped or moved. |
| **Flying** | May only be blocked by other Flying units. |
| **Fragile** | Perishes at the end of combat.|
| **Quick** | When attacking, a unit with Quick deals damage first. If they deal enough damage to destroy the opposing unit, they take no damage. Does not apply when blocking. |
| **Instant** | Can be played during your opponent's turn in response to their actions. |

---

## Special Rules

### Movement

At any point during your main phase, you can move active units to other lanes. When a unit moves, it becomes inactive. You may also swap the position of two units. If you do, only the unit who declared the move becomes inactive (note: you cannot swap with *Static* units). Offsites cannot be moved once played, unless a card states otherwise.

When your opponent declares an attack, you may move your units as if it was your turn in response.

### Banished Cards

Banished cards do not contribute to your total influence. This is indicated with a red LVL icon.

### Floating LVL

Some cards grant you *floating LVL*. Floating LVL is a resource that passively applies until the start of your next turn. For example, if you control a LVL 1 and a LVL 2 card, your influence would be 3, but if in addition to this you have 2 floating LVL applied by a card effect, you will be at LVL 4.

### Graveyard Shuffling

Some cards, like *Grave Digger* ask you to shuffle your discard pile. When this happens, you flip your discard upside down and shuffle, then do whatever effect is requested next (typically drawing a certain amount of cards).

---

---

## Glossary

| Term | Definition |
|------|-------------|
| **Influence** | Total LVL of all cards you control. Determines which cards you can play. |
| **LVL** | A card’s cost weight and influence gain. |
| **Force** | Unit’s health and damage value. |
| **Banished** | Gives no Influence. |
| **Lane** | The space connecting your unit to the opponent’s field. |
| **Inactive** | A card that cannot currently act. Represented by tilting the card 90 degrees. |

---

## Credits

**Game Design:** Cole Smith-Evans  
**World & Mechanics:** Pecto Development Team  
**Art Direction:** [TBD]  
**Playtesting:** [TBD]  
**Version:** Draft v1.0 (October 2025)

---