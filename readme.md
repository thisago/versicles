# Versicles

Lib and CLI tool to manipulate biblical verses!

## `parseList`

Converts a commented verse list into a JSON

**Help**

```
Usage:
  parseList [REQUIRED,optional-params]
Converts a commented verse list into a JSON
Options:
  -h, --help                         print this cligen-erated help
  --help-syntax                      advanced: prepend,plurals,..
  -l=, --list=     string  REQUIRED  Input list file path
  -o=, --outJson=  string  REQUIRED  Output JSON file path
```

### Example

`in.txt`

```plain
(Bereshit (Ex) 4:21) Yuval, brother of Yaval was the father of all who play the harp and flute
```

Run:

```bash
versicles parseList -l in.txt -o out.json
```

`out.json` (formatted)

```json
[
  {
    "text": "(Ex 4:5 en_cjb) Kayin rages against Hevel and his face shows hatred.",
    "textNoVerses": "Kayin rages against Hevel and his face shows hatred.",
    "verses": ["Ex 4:5 en_cjb"]
  }
]
```

## `toMd`

Generates a markdown with JSON data (parsed with `parseList`)

**Help**

```text
Usage:
  genMd [REQUIRED,optional-params]
Generates a markdown with JSON data (parsed with `parseList`)
Options:
  -h, --help                                    print this cligen-erated help
  --help-syntax                                 advanced: prepend,plurals,..
  -j=, --jsonFile=            string  REQUIRED  Input JSON file path
  -o=, --outMd=               string  ""        Output Markdown file path
  -d=, --defaultTranslation=  string  "pt_yah"  Default bible translation to use in Ozzuu Bible URLs
```

### Example

`in.json` (formatted)

```json
[
  {
    "text": "(Ex 4:5 en_cjb) Kayin rages against Hevel and his face shows hatred.",
    "textNoVerses": "Kayin rages against Hevel and his face shows hatred.",
    "verses": ["Ex 4:5 en_cjb"]
  }
]
```

Run:

```bash
versicles genMd -j in.json -d en_wyc2014
```

`stdout`

```markdown
#### [Ex 4:5](https://bible.ozzuu.com/en_cjb/Ex/4#5)

Kayin rages against Hevel and his face shows hatred.
```

## Todo

- [x] Optional hebrew names for books
- [ ] Create a website to use this tool in browser

## License

MIT
