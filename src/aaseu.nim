# This is just an example to get you started. A typical hybrid package
# uses this file as the main entry point of the application.

import aaseupkg/engine as aaseu
import strformat
import cligen

proc aaseu_main(version: bool = false,encode:bool = false, dead_text = false, filename: string="", outfile: string = "") =
  if version:
    echo "Aaseu v0.1.0 - Useless Ucalyptus"
    return
  if filename == "":
    echo "Missing these REQUIRED parameters:\n  filename\nRun command with --help for more details."
    return
  if dead_text and not encode:
    echo "ERROR: Cannot add dead text when decoding."
    return
  elif dead_text:
    echo "WARNING: Dead text is still a work in progress."
  
  if encode:
    let text = readFile(filename)
    var engine = aaseu.newEngine()
    let encoded = engine.encode(text, dead_text = dead_text)

    if outfile == "":
      echo encoded
    else:
      try:
        writeFile(outfile, encoded)
      except IOError as e:
        echo fmt"Error writing file: {e.msg}"

  else:
    try:
      let code = readFile(filename)
      var engine = aaseu.newEngine();
      var decoded: string;
      try:
        decoded = engine.decode(code);
      except Exception as e:
        echo fmt"Decode Error: {e.msg}"
        return

      if outfile == "":
        echo decoded
      else:
        try:
          writeFile(outfile, decoded)
        except IOError as e:
          echo fmt"Error writing file: {e.msg}"

    except IOError as e:
      echo fmt"Error reading file: {e.msg}"

dispatch aaseu_main