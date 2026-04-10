# 🃏Pecto V5.3 Patch Notes - The End of Cards Update🃏

---

## Overview

This update does some very large changes to the game: so much so that it was almost called 6.0, but I decided to keep it as 5.3 because it is more so a large scale formatting change rather than mechanical. The goal of this update is to further streamline and simplfy the game almost as much as possible without removing any core aspects of Pecto, while also bringing some new fun ideas and increasing interaction overall.

---

## Card Types

The major change of this update is that card types are getting removed entirely, as in Unit, Icon, Spell. Every card is effectively now a Unit in previous patches. Due to this there are a few further changes that are happening to the rulesets related to the board, which will be explained further down.

The previous patch, 5.2, was intended to push the game to its limits without fully removing card types as it was an idea I've been toying with for awhile, but I have ultimately decided to go through with it.

The term of a "spell card" remains in the game, and now refers to any card with the refined "cast" mechanic. Any card that is castable (which is now signified by a blue text box) is considered a spell card, regadless of any other details unless specified otherwise.

In addition to this, the subtypes (ghost, golem, etc) are being referred to as just types and are being reformated to act more as pure types rather than descriptions. Multitype cards now appear in the format Ghost/Golem, instead of Ghost Golem. This is to allow some cards to not have a type and not be confusing with other cards. Typeless cards are a balancing tool to allow certain cards to be harder to tutor or interact with on the board.

This patch also contains a massive balance patch, so individual card changes will not be listed. Most card changes are farily minor intended as rebalances for no card types.

## Board Updates

The board is being largely streamlined. For one, there is no more backrow fighting in any way as I found it removed a core aspect of the game, that being managing your front row and protecting your back row. I will likely return to this idea as a keyword in future sets, but for now it will not be present in the base set.

When a front row card has no target opposing themn and an attack is declared, you can chose to attack the player or the opposing back row card. This means that you can't attack any back row card from any position. If you are in the left front zone, you can attack the left back zone, and if you are in the right front zone, you can attack right back zone. If your card is in the center zone it can attack both.

## Skill Updates

Due to the prevelance of cast triggers, I've decided to make skills more in line with them. All skills are now instant speed by default (now know as resonses). If a skill (or a cast effect) cannot be used as a response, the description will end with "cannot be used as a response".

## Responses

Instead of the term instant speed (as this has legal ramifications), Pecto now uses the term "responses". A card can have the "response" keyword, which simply means it can be set from your hand as a response to an action a player did (you cannot respond to your own action). In addition, effects (primarly casts/skills) that say "cannot be used as a response" at the end cannot be used at instant speed.

Here is how responses work in a more clear format from a 1v1 perspective:

- When an opponent declares an action, it immediately resolves. There is no stopping an action once it is declared (the only exception to this being attacking, the declaration of an attack and the actual attack are seperate actions)
- After an action resolves, the opponent is given a response window.
- During the response window, they can perform exactly 1 action that is able to be used at response speed.
- Reponse speed actions by default are: casting a card, activating a skill, setting a response card from your hand to the board.

To be clear, there is no stack unlike MTG. This is intended to make you think ahead about what could happen and how you should respond to it. It also puts your cards at risk to do so, instead of just holding onto cards in your hand waiting for the perfect moment to use them. This brings in a nice risk/reward factor that I think is a core aspect of Pecto.

## Card Template Updates

With the removal of card types, and some further refinements the template is being updated. Force have now been moved to the top left of the card, and LVL has been given a new unique icon.

There are now four text boxes that can appear on a card, each with a different purpose:

- Black
  - passive box, standard text applies here
- Red
  - ritual box, conditions that must be met to set the card from your hand
- Blue
  - cast box, any card with this is considered a "spell" and can be cast from the field to use the effect (send the card to the discard, but this doesn't count as them perishing).
- Pink/Green
  - represents an activated skill. Pink means the card becomes inactive upon use, green does not cause them to become inactive and can be used any amount of times.

The force box is also getting updated with a minor change. Cards can now not have force. This is not the same as a card having 0 force, although they are very similar. While on the board, a card with no force interacts the same as a card with 0 force, except its force stat can never increase. This means that no force cards always perish when they receive an instance of damage, and do not deal combat damage ever.

## Instant Keyword

Renamed to Response.

## Bleed Keyword

The old rendition of the bleed keyword (equvialent to deathtouch in mtg) was not a good mechanic for Pecto. Pecto is intended to be played by having one or more primary cards that get buffed up through the course of the game and winning through those cards. The old Bleed keyword made this unfeasible because you could simply slam your bleed card into the big guy and immediately kill it. Due to this, bleed is being reworked to be similar to its 1.0 version where it is intended to be used as a win-con more than anything else.

Bleed now reads as such: "When a Bleed card connects an attack with a target, that target gains a bleed counter. At 3 bleed counters, the target immediately perishes (including players)". Notably, this means that a card with bleed and 0 damage still applies a bleed counter.

This intention of this change was to make bleed a more frightening keyword for ending games rather than ending plays. Also, you can still theoretically use bleed cards to take down any large card, but its not nearly as braindead as before. You will likely need to use 3 bleed cards to take down a large target.

## Sick Keyword

Sick is gaining the same change as Bleed where a Sick card can infect another card even if it deals 0 damage, so long as its attack connected.
