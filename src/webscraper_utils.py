import requests
from bs4 import BeautifulSoup
import pandas as pd

def parse_html(url: str):
    page = requests.get(url)
    soup = BeautifulSoup(page.content, "html.parser")
    return soup

def get_data(url: str):
    df = pd.DataFrame()
    page = parse_html(url)

    while page.find("a", class_="nfl-o-table-pagination__next") or page.find(
        "table", class_="d3-o-table d3-o-table--detailed d3-o-player-stats--detailed d3-o-table--sortable"
    ):  # this condition can be improved
        data = pd.read_html(url)[0]
        df = pd.concat([df, data])
        if not page.find("a", class_="nfl-o-table-pagination__next"):
            break
        url = url + page.find("a", class_="nfl-o-table-pagination__next")["href"]
        page = parse_html(url)

    df.index = df.reset_index().index
    return df