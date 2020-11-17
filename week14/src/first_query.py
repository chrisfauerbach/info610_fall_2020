import sqlite3
import logging


def get_database(filename):
    conn = sqlite3.connect(filename)
    return conn

def query_rows():
    conn = get_database('database.sqlite3.db')
    c = conn.cursor()
    SELECT_QUERY = " SELECT * FROM movies LIMIT 5; "
    result = c.execute(SELECT_QUERY)
    print(result)
    print(type(result))
    for movie in result:
        print(type(movie), movie)
    conn.commit()
    conn.close()

if __name__ == "__main__":
    query_rows()

