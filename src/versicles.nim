from std/json import `$`, `%*`, `%`, `add`, newJArray, parseJson, items, `[]`,
                      `getStr`, JsonParsingError
from std/os import fileExists
from std/strformat import fmt
from std/sequtils import toSeq, mapIt
from std/strutils import split, strip, AllChars, Letters, Digits, replace, join,
                          parseInt, toLowerAscii, toUpperAscii
import std/nre

from pkg/util import removeAccent, getAllFirstLevelParenthesis


type
  Verse* = tuple
    book: string
    chapter, verse: int

func parseVerse*(verse: string): Verse =
  ## Parses the verse reference to a `Verse` tuple
  var parts = verse.find(re"([^:]+) ([0-9]{1,3}):([0-9]{1,3})").get.captures
  result.book = parts[0].toLowerAscii
  result.book[0] = result.book[0].toUpperAscii
  result.chapter = parts[1].parseInt
  result.verse = parts[2].parseInt

func `$`*(v: Verse): string =
  fmt"{v.book} {v.chapter}:{v.verse}"

func inOzzuuBible*(verse: string; translation = "pt_yah"): string =
  ## Returns a URL to see the verse in Ozzuu Bible
  let v = verse.parseVerse
  fmt"https://bible.ozzuu.com/{translation}/{v.book}"

proc genMd(jsonFile: string; outMd = ""): bool =
  ## Generates a markdown with JSON data (parsed with `parseList`)
  result = false # no error
  if not fileExists jsonFile:
    echo fmt"The JSON file '{jsonFile}' not exists"
    return true
  try:
    let node = jsonFile.readFile.parseJson
    var md = ""
    if outMd.len > 0:
      md = """# versicles
Generated by [versicles](https://git.ozzuu.com/thisago/versicles)

All glory to **יהוה**!

## Content
"""
    for item in node:
      var verses: seq[string]
      for v in item["verses"]:
        let verse = v.getStr
        verses.add fmt"[{verse}]({verse.inOzzuuBible})"
      md.add "#### " & verses.join ", " & "\l"
      md.add item["textNoVerses"].getStr & "\l"
    if outMd.len > 0:
      outMd.writeFile md
    else:
      echo md
  except JsonParsingError:
    echo getCurrentExceptionMsg()
    return true


func removeVerses(s: string; verses: seq[string]): string =
  result = s
  for verse in verses:
    result = result.replace(verse, "")
  result = result.replace(re"\([^\w\d]*\)", "").strip



proc parseList(list, outJson: string): bool =
  ## Converts a commented verse list into a JSON
  result = false # no error
  if not fileExists list:
    echo fmt"The list file '{list}' not exists"
    return true
  var node = newJArray()
  for l in list.readFile.split "\n":
    let line = l.strip 
    if line.len == 0: continue
    var verses: seq[string]
    for parenthesis in line.getAllFirstLevelParenthesis:
      for verse in parenthesis.strip.findAll(re"[^:]+ [0-9]{1,3}:[0-9]{1,3}"):
        verses.add verse.strip(chars = AllChars - Letters - Digits - {':', '(', ')'})
    node.add %*{
      "text": %line,
      "textNoVerses": %line.removeVerses verses,
      "verses": %verses,
    }
  outJson.writeFile $node

when isMainModule:
  import pkg/cligen
  dispatchMulti(
    [
      parseList,
      help = {
        "list": "Input list file path",
        "outJson": "Output JSON file path"
      }
    ],
    [
      genMd
    ]
  )
