import pandas as pd
import numpy as np
from tqdm import tqdm
from webscraper_utils import get_data
import warnings
warnings.filterwarnings("ignore")

# Scrape data for rushing, passing, and receiving statistics
stat_names = [["rushing","rushingattempts","Att",150],["passing","passingattempts","Att",200],["receiving","receivingreceptions","Rec",70]]
stat_dfs = []

for names in stat_names:
    
    print("Scraping " + names[0] + " data...")

    # URL for the first page of the data
    beginning_url = "https://www.nfl.com/stats/player-stats/category/" + names[0] + "/"
    end_url = "/post/all/" + names[1] + "/desc"

    df = pd.DataFrame()
    for year in tqdm(range(1994, 2021)):
        
        # URL for the data for a specific year
        url = beginning_url + str(year) + end_url
        
        # Get the data for the year
        data = get_data(url)
        
        # Drop rows with less than a certain number of attempts or receptions
        data = data.drop(data[data[names[2]] < names[3]].index)
        if names[0] == "receiving":
            data = data.drop(['Rec YAC/R', 'Tgts'], axis=1)
        
        # Add the year to the data
        data["Year"] = year
        
        # Concatenate the data
        df = pd.concat([df, data], ignore_index=True)
    
    # Add a column for Pro Bowl appearances
    df["pro_bowl"] = 0
    stat_dfs.append(df)

# Scrape data for Pro Bowl appearances
print("Scraping Pro Bowl data...")
pbdf = pd.DataFrame()

for year in tqdm(range(1994, 2021)):
    
    # Get the data for the year
    pbdata = pd.read_html("https://www.pro-football-reference.com/years/" + str(year) + "/probowl.htm")
    pbdata = pd.DataFrame(np.squeeze(pbdata))
    
    # Clean the data
    names = [player.rstrip("%") for player in pbdata[1].to_list()]
    pbdata[1] = names
    
    # Drop rows with positions other than QB, RB, or WR
    pbdata = pbdata.drop(pbdata[((pbdata[0] != 'QB') & (pbdata[0] != 'RB') & (pbdata[0] != 'WR')) | (pbdata[1].str.find('+') != -1)].index)
    pbdata = pbdata.drop(pbdata.iloc[:,2:23], axis=1)
    
    # Add the year to the data
    pbdata["Year"] = year
    
    # Concatenate the data
    pbdf = pd.concat([pbdf,pbdata], ignore_index=True)