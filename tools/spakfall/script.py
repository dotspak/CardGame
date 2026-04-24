import csv
import discord
import requests
import re
import os
import random
from io import StringIO
from discord import app_commands
from discord.ext import commands
from dotenv import load_dotenv

# constants
FORCE_EMOJI = "<:FORCE:1492236260243275989>"
NULL_EMOJI = "<:NULL:1492236289167200347>"
CSV_URL = "https://docs.google.com/spreadsheets/d/e/2PACX-1vQOXrQ7no2UmFB_beqtUqB_tmoMYNR6ndNPzUToxDwa00UukgbENansGoxMH0_zSg1YsJJ2iI1Whbrv/pub?output=csv"
TRIGGERS = ["ENTER", "BEGIN", "PERISH", "VICTOR", "END",]
GUILD_ID = 1285253404137881711

# grab the discord token
envPath = f"{os.path.dirname(os.path.abspath(__file__))}/.env"
load_dotenv(envPath)
TOKEN : str = str(os.getenv('TOKEN'))

# intent + bot setup
intents = discord.Intents.all()
intents.message_content = True
bot = commands.Bot(command_prefix="!", intents=intents)

# searches the csv for the card passed
def find_card(card_name: str) -> dict | None:
    global data
    target = normalize(card_name)

    # check all cards if there is a match
    for card in data:
        if normalize(card.get("name", "")) == target:
            print(f"found {target}")
            return card

    # if card was not found normally, see if the name wasn't filled out
    for card in data:
        if target in normalize(card.get("name", "")):
            print(f"found {target}")
            return card

    return None


# sets the correct tag display
def bold_special_tags(text: str, triggers: list[str]) -> str:
    if not text: return ""

    text = clean_text(text)
    text = escape_md(text)
    text = replace_symbols(text)
    text = re.sub(r"\b(CAST:)", r"**↯\1**", text)
    text = re.sub( r"\b(RITUAL:?)", r"**💀\1**", text)

    for trig in sorted(triggers, key=len, reverse=True):
        pattern = rf"\b({re.escape(trig)}:?)"
        text = re.sub(pattern, r"**⤷\1**", text)

    print(f"finalized text:\n{text}")
    return text


# formats the text block from the skill column in csv
def format_skill_text(raw: str, triggers: list[str]) -> str:
    if not raw: return ""

    raw = str(raw).strip()
    match = re.match(r'^\{(skill|fskill):([^}]+)\}\s*(.*)$', raw, flags=re.IGNORECASE | re.DOTALL)
    if not match: return bold_special_tags(raw, triggers)

    skillType = match.group(1).lower()
    skillName = match.group(2).strip().title()
    skillBody = match.group(3).strip()

    label = "🗘" if skillType == "fskill" else "★"
    safeName = discord.utils.escape_markdown(skillName)
    formattedBody = bold_special_tags(skillBody, triggers)

    if formattedBody: return f"**{label}{safeName}:**\n{formattedBody}"

    skillText = f"**{label} - {safeName}:**"
    print(f"finalized skill:\n {skillText}")
    return skillText


# generates the discord embed to display
def generate_embed(card):
    name = escape_md(card.get("name", ""))
    subtype = escape_md(card.get("subtype", ""))
    lvl = escape_md(card.get("lvl", ""))
    force = escape_md(card.get("force", ""))
    keywords = escape_md(clean_text(card.get("keywords", "")))
    text = bold_special_tags(card.get("text", ""), TRIGGERS)
    skill = format_skill_text(card.get("skill", ""), TRIGGERS)

    # header line inside the embed body
    headerParts = [f"**{name}**"]

    # create the card header
    statParts = []
    
    if force: statParts.append(f"{force}{FORCE_EMOJI if force!="?" else NULL_EMOJI}")
    if lvl: statParts.append(f"LVL {lvl}")
    if statParts: headerParts.append("/".join(statParts))
    if subtype: headerParts.append(f"*{subtype}*")

    header = " — ".join(headerParts)

    # main body
    sections = [header]
    if keywords: sections.append(f"*{keywords}*")
    if text: sections.append(text)
    if skill: sections.append(skill)

    description = "\n".join(sections)

    if len(description) > 4000: description = description[:3997] + "..."

    embed = discord.Embed(description=description, color=discord.Color.purple())

    # get art for card
    art = card.get("nickname") + ".png"
    baseDir = os.path.dirname(os.path.abspath(__file__))
    path = os.path.join(baseDir, "art", art)
    file = discord.File(path, filename=art)
    embed.set_image(url=f"attachment://{art}")
    return embed, file


def load_cards_from_url(url: str) -> list[dict]:
    response = requests.get(url, timeout=10)
    response.raise_for_status()
    return list(csv.DictReader(StringIO(response.text)))


async def run_discord_command(cardName, interaction) -> None:
    card = find_card(cardName)

    if not card:
        await interaction.response.send_message(f'No card found for "{cardName}".', ephemeral=True)
        return
    
    embed, file = generate_embed(card)
    await interaction.response.send_message(embed=embed, file=file)


def replace_symbols(text: str) -> str:
    if not text: return ""
    text = re.sub(r'FORCE', FORCE_EMOJI, text)
    text = re.sub(r'NULL', NULL_EMOJI, text)
    return text


async def card_name_autocomplete(interaction: discord.Interaction, current: str) -> list[app_commands.Choice[str]]:
    current = normalize(current)
    matches = []
    for card in data:
        name = card.get("name", "").strip()
        if not name: continue
        if current in normalize(name): matches.append(app_commands.Choice(name=name, value=name))
        if len(matches) >= 25: break
    return matches


def normalize(text: str) -> str: return str(text).strip().lower()
def escape_md(text: str) -> str: return "" if not text else discord.utils.escape_markdown(str(text))
def clean_text(text: str) -> str: return "" if not text else str(text).replace("}", "").strip()


@bot.tree.command(name="pectosearch", description="Look up a Pecto card")
@app_commands.describe(card_name="The name of the card")
@app_commands.autocomplete(card_name=card_name_autocomplete)
async def card_search(interaction: discord.Interaction, card_name: str):
    global data
    await run_discord_command(
        card_name, interaction=interaction)


@bot.tree.command(name="randomcard", description="Get a random Pecto card")
async def random_card(interaction: discord.Interaction):
    global data
    await run_discord_command(
        random.choice(data).get("name"), interaction=interaction)


@bot.event
async def on_ready():
    print(f"Logged in as {bot.user}")
    guild = discord.Object(id=GUILD_ID)
    bot.tree.clear_commands(guild=guild)
    print(f"Synced {len(await bot.tree.sync())} commands to guild.")


data = load_cards_from_url(CSV_URL)
bot.run(str(TOKEN))