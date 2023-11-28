# AASEU

> An Absolutely Stupid Encoding Utility v0.1.0

## About

This tool is a simple and ineffecient utility to encode and decode text.
It started out as a brainfk alternative and I did not know what I was doing so this emerged.

## Usage

The binaries for linux (compiled on wsl ubuntu) and windows (compiled on windows 11) are provided in the `bin` directory.
Assuming you have moved the binaries to the directory you need it in or added it to path:

**Encoding:**

```powershell
aaseu --filename <yourfilename> --outfile <outputfilename> --encode
```

**Decoding:**

```powershell
aaseu --filename <yourfilename> --outfile <outputfilename>
```

***NOTE:*** If you do not provide an output filename, it prints the result to the terminal.

### SPECIAL FEATURE

This tool includes a half backed partially functional `dead_text` feature that adds dead text to the output while encoding that just increases the encoded file size and does nothing. It is of course valid data that will be taken into account when decoding but will not affect decoded file size no matter what.

**USAGE:**

```powershell
aaseu --filename <yourfilename> --outfile <outputfilename> --encode --dead_text
```

The `--dead_text` option is passed as an option not parameter.

In the current version though, the `--dead_text` option adds a weird numbers to the encoded text. This is not intended and will be the first issue in this repository. I am too lazy to fix it before `0.1.0` to be honest...
