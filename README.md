# Docker Data Viewer
Load the json `schema` file, parses the `data` json file, inserts in postgres and starts pgAdmin.

```
docker run -it -v $(pwd):/jsondb -p 5432:5432 -p 5050:5050 dnascimento/jsondb <schema> <data> <object key containing a list>
```

Kudos to Andrew Cowie for the idea
Credits: [jsonschema2db](https://github.com/better/jsonschema2db)
