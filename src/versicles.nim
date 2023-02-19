from std/json import `$`, `%*`, `%`, `add`, newJArray
from std/os import fileExists
from std/strformat import fmt
from std/strutils import split, strip, AllChars, Letters, Digits
from std/re import findAll, re

from pkg/util import removeAccent, getAllFirstLevelParenthesis
  
proc list2json(list, outJson: string): bool =
  ## Converts a verse list into a JSON
  result = false # no error
  if not fileExists list:
    echo fmt"The list file '{list}' not exists"
    return true
  var node = newJArray()
  for line in list.readFile.split "\n":
    var verses: seq[string]
    for parenthesis in line.strip.getAllFirstLevelParenthesis:
      for verse in parenthesis.strip.findAll(re"[^:]+ [0-9]{1,3}:[0-9]{1,3}"):
        verses.add verse.strip(chars = AllChars - Letters - Digits - {':', '(', ')'})
    node.add %*{
      "verses": %verses,
      "text": %line.strip
    }
  outJson.writeFile $node

when isMainModule:
  import pkg/cligen
  dispatchMulti(
    [list2json],
  )
