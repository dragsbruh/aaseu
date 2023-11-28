import strformat
import strutils
import random

type
  Engine = object
    CELL_LIMIT: int
    mem: seq[int]
    cursor: int

const INCREMENT_OPERATOR: char = '+'
const DECREMENT_OPERATOR: char = '-'

const CURSOR_INCREMENT_OPERATOR: char = '>'
const CURSOR_DECREMENT_OPERATOR: char = '<'

const PRINT_OPERATOR: char = '.'

const CLEAR_CELL_OPERATOR: char = '#'
const RESET_CURSOR_OPERATOR: char = '%'

const DEAD_CODE_MULTIPLIER = 69

proc newEngine(cellLimit: int = 99999): Engine =
  var eng: Engine
  eng.CELL_LIMIT = cellLimit
  eng.mem = newSeq[int](cellLimit)
  eng.cursor = 0
  return eng

proc decode*(e: var Engine, code: string): string =
  var pos: int = 0
  var output: string = ""
  for character in code:
    pos += 1
    case character:
      of CURSOR_INCREMENT_OPERATOR:
        if e.cursor >= e.CELL_LIMIT - 1:
            var e: ref Exception
            e.msg = fmt("Cursor too high. (position: {pos})\n");
            raise e
        else:
          e.cursor += 1
      of CURSOR_DECREMENT_OPERATOR:
        if e.cursor <= 0:
            var e: ref Exception
            e.msg = fmt("Cursor too low. (position: {pos})\n");
            raise e
        else:
          echo e.cursor
          e.cursor -= 1
      of INCREMENT_OPERATOR:
        e.mem[e.cursor] += 1
      of DECREMENT_OPERATOR:
        e.mem[e.cursor] -= 1
      of CLEAR_CELL_OPERATOR:
        e.mem[e.cursor] = 0
      of RESET_CURSOR_OPERATOR:
        pos = 0
      of PRINT_OPERATOR:
        output &= chr(e.mem[e.cursor])
      else:
        continue
  return output

proc encode*(e: var Engine, text: string, dead_text: bool = false): string =
  var encoded: string = ""
  for character in text:
    let ordinal = ord(character)
    var encoded_char = INCREMENT_OPERATOR.repeat(ordinal)
    if dead_text:
      let char_offset = random.rand(DEAD_CODE_MULTIPLIER)
      encoded_char &= INCREMENT_OPERATOR.repeat(char_offset)
      encoded &= DECREMENT_OPERATOR.repeat(char_offset)
      encoded &= CURSOR_INCREMENT_OPERATOR.repeat(char_offset)
      encoded &= CURSOR_DECREMENT_OPERATOR.repeat(char_offset)
    encoded &= encoded_char & ".>"
  return encoded

proc reset*(e: var Engine, cellLimit: int = 99999) =
  e.CELL_LIMIT = cellLimit
  e.mem = newSeq[int](cellLimit)
  e.cursor = 0

export newEngine, Engine, decode, encode, reset
