#! /usr/bin/env python3
import json
import psycopg2
import argparse
from jsonschema2db import JSONSchemaToPostgres


def query(con, q):
    cur = con.cursor()
    cur.execute(q)
    return cur.fetchall()


def main(schema_file, json_file, obj_key):
    schema = json.load(open(schema_file))
    translator = JSONSchemaToPostgres(
        schema,
        postgres_schema='schm',
        item_col_name='loan_file_id',
        item_col_type='string'
    )
    con = psycopg2.connect('host=localhost dbname=jsondb')
    translator.create_tables(con)
    con.commit()
    data = json.load(open(json_file))
    i = 0
    for item in data[obj_key]:
        translator.insert_items(con, {i: item})
        i += 1
    print("Create links")
    translator.create_links(con)
    print("Optimize")
    translator.analyze(con)
    print("Commit")
    con.commit()


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description='Read JSON Schema, create database and load JSON data.')
    parser.add_argument("schema")
    parser.add_argument("data")
    parser.add_argument("key")
    args = parser.parse_args()
    main(args.schema, args.data, args.key)
