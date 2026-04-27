import pandas as pd
import csvLink

CSV_URL = csvLink.get_csv_url()
TAGS = [
    "ENTER:",
    "PERISH:",
    "BEGIN:",
    "VICTOR:",
    "END:",
    "MOVE:",

    "CAST:",
    "RITUAL:",
]

TEXT_COLUMN = "text"
NAME_COLUMN = "name"

def check_missing_closing_brace(text: str, tags: list[str]) -> bool:
    for tag in tags:
        start = 0
        while True:
            idx = text.find(tag, start)
            if idx == -1: break

            # Look for a closing brace after the found tag
            closing_idx = text.find("}", idx)
            if closing_idx == -1: return True

            start = idx + len(tag)

    return False


def main():
    df = pd.read_csv(CSV_URL)
    missing = []

    for _, row in df.iterrows():
        card_name = row.get(NAME_COLUMN, "")
        text = row.get(TEXT_COLUMN, "")
        if pd.isna(text): continue
        if check_missing_closing_brace(str(text), TAGS): missing.append(card_name)

    if missing:
        print("Cards missing a closing brace:")
        for card in missing: print(f"- {card}")
    else:
        print("No missing closing braces found.")


if __name__ == "__main__": main()