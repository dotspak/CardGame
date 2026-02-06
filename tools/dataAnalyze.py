import pandas as pd
import io
import requests

SHEET_CSV_URL = (
    "https://docs.google.com/spreadsheets/d/e/2PACX-1vRXr8Y7Cm_kUgUkpogX0h3OeTEX4gwGGGhdjoT9FMyvQX5sgsCBvQD1lBOTLkJkrVwZNKNZase3O6hd/pub?output=csv")

def get_stats_with_pct(series):
    """Helper function to calculate counts and percentages."""
    counts = series.value_counts(dropna=False)
    total = counts.sum()
    pcts = (counts / total * 100).round(2)
    
    # Combine into a readable table
    stats_df = pd.DataFrame({'Count': counts, '% of Total': pcts})
    # Ensure it stays sorted by count
    return stats_df.sort_values(by='Count', ascending=False)

def analyze_card_data(url):
    response = requests.get(url)
    df = pd.read_csv(io.StringIO(response.text))

    print("--- Card Game Analysis ---\n")

    # --- 1. Force Value Analysis ---
    print("Force Value Analysis")
    force_stats = get_stats_with_pct(df['force'])
    print(force_stats.to_string())
    print("\n" + "-" * 30 + "\n")

    # --- 2. LVL Value Analysis ---
    print("LVL Value Analysis")
    lvl_stats = get_stats_with_pct(df['lvl'])
    print(lvl_stats.to_string())
    print("\n" + "-" * 30 + "\n")

    # --- 3. Card Type Analysis ---
    all_types = []
    for entry in df['subtype'].fillna('typeless'):
        split_types = [t.strip().lower() for t in str(entry).split('/')]
        all_types.extend(split_types)
    
    type_series = pd.Series(all_types)
    
    print("Card Type Analysis")
    type_stats = get_stats_with_pct(type_series)
    print(type_stats.to_string())

if __name__ == "__main__":
    try:
        analyze_card_data(SHEET_CSV_URL)
    except Exception as e:
        print(f"Error: Could not process the CSV. {e}")