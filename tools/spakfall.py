import csv
import discord
import requests
import re
import os
import random
from io import StringIO
from discord import app_commands
from discord.ext import commands

FORCE_EMOJI = "<:FORCE:1492236260243275989>"
NULL_EMOJI = "<:NULL:1492236289167200347>"

TOKEN = "MTQ5MjIxNzUzOTQ2MjE3MjcwMg.Gj0DRL.zehz3k8-PF3KJLTVr1S8TNBkrEHnkV95rD0fNo"
CSV_URL = "https://docs.google.com/spreadsheets/d/e/2PACX-1vQOXrQ7no2UmFB_beqtUqB_tmoMYNR6ndNPzUToxDwa00UukgbENansGoxMH0_zSg1YsJJ2iI1Whbrv/pub?output=csv"

TRIGGERS = [
    "ENTER",
    "BEGIN",
    "PERISH",
    "VICTOR",
    "END",
]

GUILD_ID = 1285253404137881711

def load_cards_from_url(url: str) -> list[dict]:
    response = requests.get(url, timeout=10)
    response.raise_for_status()
    return list(csv.DictReader(StringIO(response.text)))

def normalize(text: str) -> str: return str(text).strip().lower()

def find_card(cards: list[dict], card_name: str) -> dict | None:
    target = normalize(card_name)

    for card in cards:
        if normalize(card.get("name", "")) == target:
            return card

    for card in cards:
        if target in normalize(card.get("name", "")):
            return card

    return None

def escape_md(text: str) -> str:
    if not text: return ""
    return discord.utils.escape_markdown(str(text))

def clean_text(text: str) -> str:
    if not text: return ""
    return str(text).replace("}", "").strip()

def bold_special_tags(text: str, triggers: list[str]) -> str:
    if not text: return ""

    text = clean_text(text)
    text = escape_md(text)
    text = replace_symbols(text)

    text = re.sub(
        r"\b(CAST:)",
        r"**↯\1**",
        text
    )

    text = re.sub(
        r"\b(RITUAL:?)",
        r"**💀\1**",
        text
    )

    for trig in sorted(triggers, key=len, reverse=True):
        pattern = rf"\b({re.escape(trig)}:?)"
        text = re.sub(pattern, r"**⤷\1**", text)

    return text

def format_skill_text(raw_skill: str, triggers: list[str]) -> str:
    if not raw_skill: return ""

    raw_skill = str(raw_skill).strip()

    match = re.match(
        r'^\{(skill|fskill):([^}]+)\}\s*(.*)$',
        raw_skill,
        flags=re.IGNORECASE | re.DOTALL
    )

    if not match: return bold_special_tags(raw_skill, triggers)

    skill_type = match.group(1).lower()
    skill_name = match.group(2).strip().title()
    skill_body = match.group(3).strip()

    label = "🗘" if skill_type == "fskill" else "★"

    safe_name = discord.utils.escape_markdown(skill_name)
    formatted_body = bold_special_tags(skill_body, triggers)

    if formatted_body: return f"**{label}{safe_name}:**\n{formatted_body}"
    return f"**{label} - {safe_name}:**"

def replace_symbols(text: str) -> str:
    if not text: return ""

    text = re.sub(r'FORCE', FORCE_EMOJI, text)
    text = re.sub(r'NULL', NULL_EMOJI, text)

    return text

def generate_card(card):
    name = escape_md(card.get("name", ""))
    subtype = escape_md(card.get("subtype", ""))
    lvl = escape_md(card.get("lvl", ""))
    force = escape_md(card.get("force", ""))
    keywords = escape_md(clean_text(card.get("keywords", "")))
    text = bold_special_tags(card.get("text", ""), TRIGGERS)
    skill = format_skill_text(card.get("skill", ""), TRIGGERS)

    # Header line inside the embed body
    header_parts = [f"**{name}**"]

    # create the card header
    stat_parts = []
    if force: stat_parts.append(f"{force}{FORCE_EMOJI if force!="?" else NULL_EMOJI}")
    if lvl: stat_parts.append(f"LVL {lvl}")
    if stat_parts: header_parts.append("/".join(stat_parts))
    if subtype: header_parts.append(f"*{subtype}*")

    header = " — ".join(header_parts)

    sections = [header]

    # main body
    if keywords: sections.append(f"*{keywords}*")
    if text: sections.append(text)
    if skill: sections.append(skill)

    description = "\n".join(sections)

    if len(description) > 4000:
        description = description[:3997] + "..."

    embed = discord.Embed(
        description=description,
        color=discord.Color.purple()
    )

    # get art for card
    art_filename = card.get("art", "").strip()
    path = os.path.join("../art/baseSet", art_filename)
    file = discord.File(path, filename=art_filename)
    embed.set_image(url=f"attachment://{art_filename}")
    return embed, file


# -------------------------------------
# Bot Commands
# -------------------------------------
cards_data = load_cards_from_url(CSV_URL)

intents = discord.Intents.default()
bot = commands.Bot(command_prefix="!", intents=intents)

@bot.tree.command(name="pectosearch", description="Look up a Pecto card")
@app_commands.describe(card_name="The name of the card")
async def card_search(interaction: discord.Interaction, card_name: str):
    global cards_data
    card = find_card(cards_data, card_name)

    if not card:
        await interaction.response.send_message(f'No card found for "{card_name}".', ephemeral=True)
        return
    
    embed, file = generate_card(card)
    await interaction.response.send_message(embed=embed, file=file)

@bot.tree.command(name="randomcard", description="Get a random Pecto card")
async def random_card(interaction: discord.Interaction):
    global cards_data
    card = random.choice(cards_data)

    if not card:
        await interaction.response.send_message(f'Failed to find anything.', ephemeral=True)
        return
    
    embed, file = generate_card(card)
    await interaction.response.send_message(embed=embed, file=file)

@bot.event
async def on_ready():
    print(f"Logged in as {bot.user}")
    guild = discord.Object(id=GUILD_ID)
    synced = await bot.tree.sync(guild=guild)
    print(f"Synced {len(synced)} commands to guild.")

bot.run(TOKEN)