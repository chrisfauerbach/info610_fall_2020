import sqlite3
import pandas as pd
import logging



def load_row(movie):
    conn = get_database('database.sqlite3.db')
    c = conn.cursor()
    LOAD_SQL = """
        INSERT INTO movies(id, title, original_title, budget, homepage, imdb_id, release_date, revenue, runtime, vote_average, vote_count) values
                          (?,  ?,     ?,              ?,      ?,        ?,       ?,            ?,       ?,       ?,            ?)
    """
    c.execute(LOAD_SQL, (movie['id'], movie['title'], movie['original_title'], movie['budget'],
                         movie['homepage'], movie['imdb_id'], movie['release_date'], movie['revenue'], 
                         movie['runtime'], movie['vote_average'], movie['vote_count'] ))
    conn.commit()
    conn.close()

def get_database(filename):
    conn = sqlite3.connect(filename)
    return conn



if __name__ == "__main__":
    movies = pd.read_csv("movies_metadata.csv")
    for k, row in movies.iterrows():
        try:
            load_row(row)
        except:
            logging.error("Duplicate primary key: %s", (row['id'], ))


