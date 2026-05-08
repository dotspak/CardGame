# Pecto 2.0 Update

## Big Changes

- LVL has been removed entirely. All cards are free to play with rituals used much more often as card-specific costs.
- Cards are now either front-row cards or back-row cards, and can only be played in their respective row.

## Card Draw

Card draw has been changed to simply be draw 2 per turn, with an opening hand of 3. This means your effective starting hand is still 5.

With turtling being pretty unviable overall in this format, the destruction bonus is no longer needed.

## Mulligans

With every card being free, mulligans are much stronger now. You can only replace the cards from your opening hand and only see the new cards after confirming which to replace.

Use mulligans to ensure early game cards vs late game cards are in your opening hand.

## Attacking

Attacking no longer forces the defending card to fight. The defender may now choose to take damage or protect their card, making combat less punishing for board pieces while keeping attacks meaningful.

Full Breakdown:

- Only front-row cards can attack.
- When you declare an attack, choose whether the attacking card is attacking the opposing back-row card in its column or the opposing player.
- You may only attack the back row if a card is there.
- After an attack is declared, the opponent chooses whether their front-row card in that column, and then gets a response.
  - Front-row cards can block even if they are inactive.
  - Back-row cards cannot block.
- When the attack resolves, if the attacking card is still in play and able to attack, the card and its target fight.
- If the attack is blocked, the attacking card and blocking card deal combat damage to each other.
- If the attack is not blocked:
  - If the player was attacked, they take the damage.
  - If the back row was attacked, the back-row cards fight.

## Responses and the Stack

After much deliberation, the removal of the stack has overall just added rules complexity and frustration. Due to this, I've decided to revert back to a simplified stack for Pecto.

- When a player declares an attack, skill, or cast effect, that action is added to the stack.
- To declare an action, choose any required targets and pay all costs. Costs are paid immediately.
- After an action is added to the stack, players may respond with available response actions. Response actions are skills and cast effects that can be used as responses.
- Responses are added to the stack above the previous action. Players may continue responding until both players pass in a row.
- When both players pass, the stack resolves from top to bottom.
- Each action resolves if it is still valid when it would resolve. If all of an action’s required targets are invalid, that action fizzles.
- Removing the source of a skill or cast effect does not stop that skill or cast effect from resolving.
- Attacks only resolve if the attacking card is still in play and able to attack.
- Triggers cannot be responded to. After an action resolves, any triggers caused by that action resolve before the next action on the stack.
- Playing cards from the hand does not go onto the stack.
