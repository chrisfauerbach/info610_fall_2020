import sqlite3
import logging

def dict_factory(cursor, row):
    d = {}
    for idx, col in enumerate(cursor.description):
        d[col[0]] = row[idx]
    return d


def get_database(filename):
    conn = sqlite3.connect(filename)
    # Changed for a real dictionary!
    conn.row_factory = dict_factory
    return conn

def search_title(descr):
    results = []
    conn = get_database('database.sqlite3.db')
    c = conn.cursor()
    parm = "%{}%".format(descr)
    SELECT_QUERY = " SELECT * FROM movies WHERE title like ? LIMIT 5 "
    result = c.execute(SELECT_QUERY, (parm,))
    for movie in result:
        results.append(movie)
    conn.commit()
    conn.close()
    return results

def search_id(id):
    conn = get_database('database.sqlite3.db')
    c = conn.cursor()
    SELECT_QUERY = " SELECT * FROM movies WHERE id = ?;"
    result = c.execute(SELECT_QUERY, (id, ))
    movie = result.fetchone()
    conn.commit()
    conn.close()
    return movie

if __name__ == "__main__":
    my_movie = search_id(15602)
    print("15602")
    print(my_movie)
    my_movie = search_id(11862)
    print("11862")
    print(my_movie)

    my_movies = search_title('grumpier')
    print("grumpier")
    for movie in my_movies:
        print(f"{movie['id']}: {movie['title']} ")

    my_movies = search_title('star')
    print("star")
    for movie in my_movies:
        print(f"{movie['id']}: {movie['title']} ")
