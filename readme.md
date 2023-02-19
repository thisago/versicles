# Versicles

## Examples

## parseList

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

`in.txt`

```plain
(Bereshit (Ex) 4:21) Yuval, brother of Yaval was the father of all who play the harp and flute
```

Run:

```
versicles parseList -l in.txt -o out.json
```

`out.json` (formatted)

```json
{
  "verses": ["Bereshit (Ex) 4:21"],
  "text": "(Bereshit (Ex) 4:21) Yuval, brother of Yaval was the father of all who play the harp and flute",
  "textNoVerses": "Yuval, brother of Yaval was the father of all who play the harp and flute"
}
```

## License

MIT
