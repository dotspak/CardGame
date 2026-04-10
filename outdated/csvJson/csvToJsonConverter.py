import csv
import json
import re
import os
import pandas as pd

# ---------------------------------------------
# Converter Code
# ---------------------------------------------

def to_camel_case(name : str) -> str:
    name = name.strip()
    name = re.sub(r"[^A-Za-z0-9 _\-:]", "", name)
    parts = re.split(r"[ _\-:]+", name)
    if not parts: return ""
    return parts[0].lower() + "".join(p.capitalize() for p in parts[1:])


def parse_skill(raw : str, skills : dict):
    if not raw: return None
    raw = raw.strip()

    # remove any keywords if still there
    matchKey = re.match(r"^\{key:[^}]+\}\s*(.*)", raw)
    if matchKey: raw = matchKey.group(1).strip()

    # find out which skill it is and get the name from it
    match = re.match(
        r"\{(skill|fskill):([^}]+)\}\s*(.*)",
        raw.strip())

    if not match: return None

    keyword = match.group(1)
    name = match.group(2).strip()
    text = match.group(3).strip()
    skillType = 0 if keyword == "skill" else 1

    skillID = to_camel_case(name)

    if skillID not in skills:
        skills[skillID] = {
            "name" : name,
            "text" : text,
            "type" : skillType
        }

    return skillID


def parse_subtypes(raw : str):
    if not raw: return []
    parts = raw.strip().split()
    return [p for p in parts if p]


def extract_keywords(s : str):
    if not s: return [], s

    s = s.lstrip()

    match = re.match(r"^\{key:([^}]+)\}\s*(.*)", s, flags=re.DOTALL)
    if not match: return [], s

    raw = match.group(1)
    clean = match.group(2)
    keywords = [k.strip().lower() for k in raw.split(",") if k.strip()]

    return keywords, clean


def load_cards_from_csv(csv_path : str, cardType : int, skills : dict, setName : str):
    df = pd.read_csv(
        csv_path,
        delimiter=',',
        quotechar='"',
        doublequote=True,
        skipinitialspace=True,
        engine='python',
        keep_default_na=False
    ).fillna("")
    cards = {}

    for _, row in df.iterrows():
        name = str(row.get("name", "")).strip()
        if not name: continue
        
        ID = to_camel_case(name)
        rawText = str(row.get("text", "")).strip()
        rawSkill = str(row.get("skill", "")).strip()

        # extract keywords from text or skills
        keywords, cleanText = extract_keywords(rawText)
        if not keywords: keywords, cleanSkill = extract_keywords(rawSkill)
        else: cleanSkill = rawSkill
        
        if ID == "killerBee": print(cleanText)
        # get the skill id
        skillID = parse_skill(cleanSkill, skills)
        
        # subtypes parsing
        subtypes = parse_subtypes(str(row.get("subtype", "")).strip()) if cardType < 2 else []

        # lvl and force
        try: lvl = int(row.get("lvl", 0))
        except ValueError: lvl = 1

        if cardType < 2:
            try: force = int(row.get("force", 0))
            except ValueError: force = 0
        else:
            force = 0

        # art
        art = str(row.get("art", "")).strip() or "monolith.png"

        # finalized JSON for the card
        card = {
            "name" : name,
            "set" : setName,
            "type" : cardType,
            "subtype" : subtypes,
            "lvl" : lvl,
            "force" : force,
            "keywords" : keywords,
            "text" : cleanText,
            "skill" : skillID,
            "art" : art,
            "scenepath" : ""
        }

        cards[ID] = card
    return cards


def load_all_cards(units, icons, spells, output, set):
    # check if any data is already loaded in the file
    if os.path.isfile(output) and os.path.getsize(output) > 0:
        with open(output, "r", encoding="utf-8") as f:
            try:
                current = json.load(f)
                cards = current.get("cards", {})
                skills = current.get("skills", {})
            except json.JSONDecodeError:
                print("Warning: JSON is invalid, resetting the file.")
                cards = {}
                skills = {}
    else:
        cards = {}
        skills = {}
    
    # overwrite the json file
    shouldCheckDupeID = input("Check for duplicate IDs? (y/n) ") == "y"
    for cardType, csvPath in [(0, units), (1, icons), (2, spells)]:
        if not csvPath: continue
        newCards = load_cards_from_csv(csvPath, cardType, skills, set)
        
        for cardID, cardData in newCards.items():
            if cardID in cards and shouldCheckDupeID:
                if input(f"Card '{cardID}' already exists. Overwrite? (y/n) ") == "y":
                    cards[cardID] = cardData
                else:
                    print(f"Skipped '{cardID}'")
            else:
                cards[cardID] = cardData

    final = {
        "cards" : cards,
        "skills" : skills
    }

    with open(output, "w", encoding="utf-8") as f:
        json.dump(final, f, indent=4, ensure_ascii=False)

    print(f"Exported -> {output}")

# ---------------------------------------------
# Executable Code
# ---------------------------------------------

def get_file_path(prompt):
    while True:
        path = input(f"{prompt}: ").strip()
        if os.path.isdir(path): return path
        else: print("Folder not found. Please enter a valid file path.")


def get_output_path(prompt):
    while True:
        path = input(f"{prompt} (will be created/overwritten): ").strip() + ".json"
        if os.path.isfile(path): return path
        else: print("Please enter a valid file path.")


def find_csv_files(folder):
    csvFiles = {}
    files = ["units.csv", "icons.csv", "spells.csv"]
    for name in files:
        path = os.path.join(folder, name)
        if os.path.isfile(path):
            csvFiles[name.split(".")[0]] = path
        else:
            csvFiles[name.split(".")[0]] = None
    return csvFiles


if __name__ == "__main__":
    print("=== Pecto CSV -> JSON Converter V1.0 ===\n")
    csvFolder = get_file_path("Enter set folder name.")
    csvs = find_csv_files(csvFolder)

    missing = [k for k,v in csvs.items() if v is None]
    if missing: print(f"Warning: could not find {', '.join(missing)}")

    outputJSON = get_output_path("Enter filename for output JSON")
    
    load_all_cards(
        units=csvs.get("units"), 
        icons=csvs.get("icons"),
        spells=csvs.get("spells"),
        output=outputJSON,
        set=csvFolder
    )

    print("\nConversion Complete! Press Enter to exit...")