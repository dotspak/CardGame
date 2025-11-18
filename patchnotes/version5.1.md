# :star:Pecto V5.1 Patch Notes - Icons and the Damage Phase:star:

---

## Overview

This update intends to fix a few issues with the game as well as introudcing a semi-new card type: icons. My biggest issues with the game have always been 2 things:

- Sacrifice OTK/FTK loops
- Lack of importance in positioning cards

This patch aims to fix both of these issues, as well as unifiying some systems to make the game overall understandable.

This patch actually ended up being a lot larget than initially envisioned, so there is quite a bit to read. Sorry!

---

## Going Second

Going second is pretty much always worse in Pecto, so I have decided to revert this change to an older version. This should help players not just be stuck if they happened to not draw any LVL 1 cards and are not going second. The odds of not drawing any LVL 1 or LVL 2 cards in your first 6 cards is very slim assuming you made/drafted your deck right.

- If you go second, you now start at LVL 2.

### Spell Cards

Once per turn, spell cards can now be played from the hand as if they were units. When played this way, they have no text and are 0 force, but remain the same LVL. This can be used to make bridges easier, or just make quick chump blockers. The instant keyword means you can play them at instant speed this way as well. I will be keeping my eye on this mechanic. I dont expect it to be oppressive just maybe a mechanic thats cool but often forgotten at worst, but it could promote too much defensive play (once per turn is intended to fix this).

## NEW Card Type: Icons

The yellow cards (most recently called Wardens) are now being renamed to icons, and passive spells are now becoming icons as well. Icons are a new type intended to be similar to artifacts from MTG. They typically apply a passive effect to the board, or have a strong skill that makes you want to protect them and use them to your advantage. Icons, work almost the same in every way as units except for 1 key thing: they cannot declare attacks. Icons have force like units, and can have all the same keywords as units.Icons contribute to your ability to chain LVLs together the same as units. Icons have a special mechanic that will be the discussed in the Damage Phase section.

## NEW Skill Type: Ritual skills

Ritual skills are a very simple skill type: when a card uses a ritual skill, they are automatically sacrificed after. Like other skills, they can only be used if the card is active. Effect cards with ritual skills only sacrifice the card they are attached to (both still go to the discard). Ritual skills are indicated by a dark red background and a dark red badge.

## Reworked Mechanic: Movement Phase

Previously, the movement phase worked as such: at the start of each turn, you may move any non-static card to any open zone. This worked ok, but players often forgot to use their movement, and it was overall more restrictive than intended.

The Movement Phase is now being reworked into a once per turn mechanic. At any point during your turn, at sorcery speed, you can move your *active non-static cards* to an adjacent zone. This does not cause them to become inactive. If you wish to swap 2 cards positions, only 1 of them needs to be active, but both must be non-static.

This change should do a few things:

1. Players are less likely to forget to move their cards
2. More likely for interesting movement strategies
3. Plays better with the newly introduced damage phase.

## NEW Mechanic: Damage Phase

The way cards deal damage is being reworked compeltely this patch, but may not feel overwhelmingly different at first. During each players turns, declaring attacks remains almost the same as before. When a unit declares an attack, they must attack the opposing card, and if no card is there they can attack a card in back row. The change this update is that when you declare an attack on an open zone, you can no longer target the player with attacks. Instead, a new phase is being added: the Damage Phase.

At the end of each players turn (except their first turn of the game) any active front row unit deals damage to the opponent if they oppose no other card. Also, any Icons in the back row deal damage equal to half of their force (rounded up) if they oppose no back row cards. This applies to both players at once. Damage dealt this way all happens at the same time. If both players were to perish simulataneously, the player with the lower life total loses. If both players life is equal at the end, the game continues.

During the damage phase, neither player can use instants. Both players can use instants before and after, but they cannot enter the damage phase and then destroy a card or buff their card.

This phase does not cause victor triggers, nor does it apply to any effect that says "when a card attacks" this is not considered an attack, it is simply direct damage. A new trigger that gets triggered when player damage is dealt in this phase is being added for this instead.

This mechanic was intended to fix the possibility of looping sacrificing a unit, then playing a new unit, dealing player damage, sacrificing the unit, etc, as well as making positioning more important. Most icons were already designed to be played in the back row, but not it is even more vital for icons to be in the back row and units in the front row while still giving you a valid reason to play each card type in the opposite row.

---

## Card Updates

### Keyword Updates

#### Flying

Flying has been a nightmare to balance for many reasons. A lot of cards do not have flying for balance purposes even if its make sense flavour wise and I don't like this. On top of this, any mechanic I could come up with for flying cards has usually just been too oppressive or confusing. Due to this, flying is being removed from Pecto. *The icon damage during the damage phase is the intended replacement to flying overall, and was actually a potential mechanic for flying originally.*

#### Instant

- In addition to being able to be played at instant speed, icons/units can use their spells at instant speed by default.
- With this change, the instant badge from skills is being removed in favour of this.

#### NEW Keyword: Warden

The previous card type Warden is now a keyword that can be applied to a unit or icon, although it does not work the same. Warden reads as such:

- Reduces any instance of damage on adjacent cards you control by 1. Does not stack with multiple Wardens. For example, 2 Wardens protecting 1 card only reduces its damage by 1.

#### NEW/Renamed Keyword: Muted

Muted is effectively Sealed from previous patches. Muted reads as such:

- Does not deal damage to players during the damage phase.

#### Reworked Keyword: Effect

- Effect spells are no different than before. The change is that some units/icons now have the effect keyword. If a unit/offsite has the effect keyword, they can cast them and attach them to a card you control instead of summoning them. When an effect unit/icon is attached, the effected card gains the text and skills of the effect card, but not the keywords.
- Any text that says "this card" applies to the card they are attached to as well as themselves when summoned. If the card refers to themselves specifically, it does not apply to the effected card. For example, Locust's text is now: "Locust has Quick when attacking. Every time a card gains Sick, this card gains 1 force." in this instance, the Quick effect would not apply, but the sick effect would apply when attached to another card.

#### NEW Trigger: Breach

- Breach triggers happen when a card deals damage to the opponent during the damage phase. All breach triggers happen at the end of the phase, and priority is given to the player who last ended their turn.

### Force Rewording

Any card that previously gave a constantly updating force amount has been reworded to the following: "target card has +force". This wording means that the value can change and isn't just a permanent buff. The term "gain force" still implies permanent force by default.

### Formatting Updates

- Text has been added under the respective card type's icon to indicate what type it is (unit, icon, spell)
- Text/Skill text has been condensed to allow more room for art.
- Card names have been scaled up a bit for higher emphasis.

---

## Alternate Format Updates

### Draft

The draft format is now being reworked slightly. Players now draft 24 cards. Each "draft phase" players take 5 cards from the top of the draft pile in whatever order is decided. Then, players look at their cards and choose 3 cards each. After everyone has chosen 3 cards, they pass the remaining 2 to the next player, again in whatever order is decided. Once players have 21 cards, they choose 1 to remove, and that is your final 20 card deck.

### 2v2

2v2 had a lot of issues in its initial playtest. To help fix this format, some changes are being made. Im hoping that these changes will still keep the format very chaotic, but not overwhelmingly so.

- Front Row Zones
  - Decreased from 5 to 4.

- Back Row Zones
  - Decreased from 5 to 3.

The turn order of 2v2 is also being adjusted. Previously both players on a team played at once: this is being changed. Now, each player takes their own individual turns and can only play cards from their hand (except instant speed cards). A turn then plays out the same way as 1v1. When a player passes their turn, it then goes to another player on the other team in the same order every time. Here is a graph to show this:

A1 -> B1 -> A2 -> B2

You are allowed to assign which player is which in this graph after seeing your opening hands. For example, if 1 of your teammates has a better starting hand, you can nominate them to go first in the turn order. The turns of teammates must alternate the whole game, 1 player cannot take 2 turns in a row unless a card effect allows it.

The damage phase occurs between each turn the same as it does in 1v1. The damage phase does not occur until 1 player on each team has had a turn.

Each player can only declare attacks and use skills of cards they control (unless a player attached an effect with a skill to a card a different player controls), but all cards contribute to your ability to LVL chain, not just the ones you control. During the movement phase, a player can only move the cards they control.

Life is still increased to 20.

### Free For All

Free for all will function mostly the same as 1v1. The damage phase does not occur until every player has had 1 turn. This update here is mostly to state that all cards have been updated/balanced to support free for all. Any wording that said "target opponent" have now been changed to "all opponents" or "an opponent".

During the damage phase, you choose a target player to deal damage to for each unit you control. For example, if one opponent has an open left zone and another has an open center zone, if you control units that oppose those lanes you can attack both players once. Note: you cannot attack 2 players who share an open lane with one unit.

Life is increased to 20.

## Proposed Alternate formats

Below are a couple of ideas I had for altnerate formats that could be tried.

### Caveman

10 card decks, only units are allowed.

### Old School

Inspired by Pecto 2.0: LVL chaining is removed. At the start of each turn you gain 3 LVLs. Every time you play a card you lose LVLs equal to the LVL of the card played. Can not go below 0 LVLs, but can go to 0.
