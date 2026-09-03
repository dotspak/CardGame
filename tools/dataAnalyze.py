import pandas as pd
import io
import requests
import csvLink

CSV_URL = csvLink.get_csv_url()

def get_stats_with_pct(series):
    counts = series.value_counts(dropna=False)
    total = counts.sum()
    pcts = (counts / total * 100).round(2)
    stats_df = pd.DataFrame({'Count': counts, '% of Total': pcts})
    return stats_df.sort_values(by='Count', ascending=False)


def analyze_card_data(url):
    response = requests.get(url)
    df = pd.read_csv(io.StringIO(response.text))

    print("--- Pecto Stat Analysis ---\n")

    # Force Value Analysis ---
    print("Force Value Analysis")
    print(get_stats_with_pct(df['force']).to_string())
    print("\n" + "-" * 30 + "\n")

    # LVL Value Analysis ---
    print("LVL Value Analysis")
    print(get_stats_with_pct(df['lvl']).to_string())
    print("\n" + "-" * 30 + "\n")

    # Card Type Analysis ---
    all_types = []
    for entry in df['subtype'].fillna('typeless'):
        split_types = [t.strip().lower() for t in str(entry).split('/')]
        all_types.extend(split_types)

    print("Card Type Analysis")
    print(get_stats_with_pct(pd.Series(all_types)).to_string())
    print("\n" + "-" * 30 + "\n")

    # Keyword Analysis ---
    all_keywords = []
    for entry in df['keywords'].dropna():
        split_types = [t.strip().lower() for t in str(entry).split(',')]
        all_keywords.extend(split_types)
    
    print("Keyword Prominence Analysis")
    print(get_stats_with_pct(pd.Series(all_keywords)).to_string())

     # Attacker Analysis ---
    non_attacker_counter = 0
    for entry in df['attacker']:
        if entry == 'n': non_attacker_counter += 1

    print("\n----------------------------------\n")
    print("Passive % of cards: ", round((non_attacker_counter / df['attacker'].size) * 100, 2), "\n")


if __name__ == "__main__":
    try: analyze_card_data(CSV_URL)
    except Exception as e: print(f"Error: Could not process the CSV. {e}")