#!/usr/bin/env python3
"""Build a SQLite Bible database from the Wix-exported KorRV.csv."""

import csv
import os
import sqlite3
import sys

CSV_PATH = os.path.expanduser("~/Desktop/wix data backup/KorRV.csv")
DB_PATH = os.path.join(os.path.dirname(__file__), "..", "assets", "bible_ko.db")


def main():
    DB_PATH_ABS = os.path.abspath(DB_PATH)
    os.makedirs(os.path.dirname(DB_PATH_ABS), exist_ok=True)

    if os.path.exists(DB_PATH_ABS):
        os.remove(DB_PATH_ABS)

    conn = sqlite3.connect(DB_PATH_ABS)
    cur = conn.cursor()

    cur.execute("""
        CREATE TABLE bible_verses (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            book TEXT NOT NULL,
            chapter INTEGER NOT NULL,
            verse INTEGER NOT NULL,
            text_ko TEXT NOT NULL
        )
    """)
    cur.execute("CREATE INDEX idx_book_chapter_verse ON bible_verses(book, chapter, verse)")

    rows = []
    with open(CSV_PATH, newline="", encoding="utf-8") as f:
        reader = csv.DictReader(f)
        for row in reader:
            book = row["Book"].strip()
            try:
                chapter = int(row["Chapter"].strip())
                verse = int(row["Verse"].strip())
            except (ValueError, KeyError):
                continue
            text = row["Text"].strip()
            if book and text:
                rows.append((book, chapter, verse, text))

    cur.executemany(
        "INSERT INTO bible_verses (book, chapter, verse, text_ko) VALUES (?, ?, ?, ?)",
        rows,
    )
    conn.commit()

    cur.execute("""
        CREATE VIRTUAL TABLE bible_fts USING fts5(
            book, text_ko,
            content='bible_verses',
            content_rowid='id'
        )
    """)
    cur.execute("INSERT INTO bible_fts(rowid, book, text_ko) SELECT id, book, text_ko FROM bible_verses")
    conn.commit()

    cur.execute("SELECT COUNT(*) FROM bible_verses")
    total_verses = cur.fetchone()[0]
    cur.execute("SELECT COUNT(DISTINCT book) FROM bible_verses")
    total_books = cur.fetchone()[0]
    conn.close()

    db_size = os.path.getsize(DB_PATH_ABS)
    print(f"Database: {DB_PATH_ABS}")
    print(f"Total verses: {total_verses}")
    print(f"Total books:  {total_books}")
    print(f"DB size:      {db_size / 1024 / 1024:.2f} MB")


if __name__ == "__main__":
    main()
