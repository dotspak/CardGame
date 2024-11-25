@icon("res://assets/icons/offsiteIcon.svg")
extends UnitCard
class_name OffSiteCard

func calculate_damage() -> int:
    if keywords.has(Keyword.Organic):
        return force + bonus
    else:
        return bonus

func type_toString() -> String: return "O"