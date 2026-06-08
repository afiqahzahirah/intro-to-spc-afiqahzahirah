#!/bin/bash

# Configuration
SOURCE="slides.md"
TEMP="slides_with_bib.md"
OUTPUT="index.html"
BIB="references.bib"
THEME="serif"

echo "🚀 Building Slides..."

# 1. Create temporary file with bibliography and audio logic appended
cat "$SOURCE" > "$TEMP"

# Replace placeholder with actual audio block
sed -i '/<!-- __AUDIO_INTRO_DO_NOT_TOUCH__ -->/r intro-music.html' "$TEMP" 
sed -i '/<!-- __AUDIO_INTRO_DO_NOT_TOUCH__ -->/d' "$TEMP" 

# Append bibliography slide (no leading blank line!)
cat >> "$TEMP" << 'EOF'
---
# Bibliography
<div id="refs"></div>
EOF



# 2. Run Pandoc on the temporary file
pandoc -t revealjs -s "$TEMP" -o "$OUTPUT" \
  --citeproc --bibliography="$BIB" \
  --katex \
  -V revealjs-url=https://unpkg.com/reveal.js@4 \
  -V theme="$THEME" \
  -V transition=none \
  -V width=\"90%\" \
  -V margin=0.1 \
  --include-in-header=custom-styles.html

# 3. Clean up
rm "$TEMP"

echo "✅ Success: $OUTPUT generated."
