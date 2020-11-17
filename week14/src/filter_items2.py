import sqlite3
import logging
from functools import wraps


def dict_factory(cursor, row):
    d = {}
    for idx, col in enumerate(cursor.description):
        d[col[0]] = row[idx]
    return d


def db(func):
    @wraps(func)
    def wrapper_to_add(*args, **kwargs):
        cur = None
        conn = None
        try:
            conn = get_database('database.sqlite3.db')
            conn.row_factory = dict_factory           
            cur = conn.cursor() 
            a = func(*args, c=cur, **kwargs)
            logging.debug("Func returned a: ", a)
            conn.commit()

            return a
        except:
            logging.exception("Exception while processing. Will Attempt to Rollback")
            try:
                if conn:  conn.rollback()
            except:
                logging.exception("Had an issue rolling back.")
                traceback.print_exc(file=sys.stdout)
        finally:
            if cur:  cur.close()
            if conn:  conn.close()
    return wrapper_to_add



def get_database(filename):
    conn = sqlite3.connect(filename)
    # Changed for a real dictionary!
    conn.row_factory = dict_factory
    return conn

@db
def search_title(descr, c=None):
    results = []
    parm = "%{}%".format(descr)
    SELECT_QUERY = " SELECT * FROM movies WHERE title like ? LIMIT 5 "
    result = c.execute(SELECT_QUERY, (parm,))
    for movie in result:
        results.append(movie)
    return results
@db
def search_id(id, c=None):
    SELECT_QUERY = " SELECT * FROM movies WHERE id = ?;"
    result = c.execute(SELECT_QUERY, (id, ))
    movie = result.fetchone()
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
