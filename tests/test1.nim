import unittest

import aaseupkg/engine

test "Check if Decoded Encoded Text matches Decoded Encoded Decoded Encoded Text":
  var engine = engine.newEngine()
  let res1 = engine.decode(engine.encode("Hello 😉"))
  engine.reset()
  check res1 == engine.decode(engine.encode(engine.decode(engine.encode("Hello 😉"))))
  let res2 = engine.decode(engine.encode("This is not 🚀"))
  engine.reset()
  check res2  == engine.decode(engine.encode(engine.decode(engine.encode("This is not 🚀"))))