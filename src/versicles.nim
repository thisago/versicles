from std/json import `$`, `%*`, `%`, `add`, newJArray
from std/os import fileExists
from std/strformat import fmt
from std/strutils import split, strip, AllChars, Letters, Digits, replace
from std/re import findAll, re, replace

from pkg/util import removeAccent, getAllFirstLevelParenthesis

func removeVerses(s: string; verses: seq[string]): string =
  result = s
  for verse in verses:
    result = result.replace(verse, "")
  result = result.replace(re"\([^\w\d]*\)", "").strip

proc list2json(list, outJson: string): bool =
  ## Converts a verse list into a JSON
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
      "verses": %verses,
      "text": %line,
      "textNoVerses": %line.removeVerses verses,
    }
  outJson.writeFile $node

when isMainModule:
  import pkg/cligen
  dispatchMulti(
    [list2json],
  )
