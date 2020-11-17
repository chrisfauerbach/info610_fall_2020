import sqlite3

def create_database(filename):
    conn = sqlite3.connect(filename)
    return conn


def create_structure(conn):
    c = conn.cursor()
    CREATE_SQL = """
         CREATE TABLE movies (id int primary key, title varchar, original_title varchar,
         budget real, homepage varchar, imdb_id varchar,
         release_date date, revenue real, runtime real, vote_average real,
         vote_count int);
    """  
    c.execute(CREATE_SQL)
     
if __name__ == '__main__':
    conn = create_database('database.sqlite3.db')
    create_structure(conn)
    if conn:
        conn.close()


