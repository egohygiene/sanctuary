# clean_html.py
import sys
from readability import Document
from bs4 import BeautifulSoup

html = sys.stdin.read()
doc = Document(html)
summary = doc.summary()

# Optional: strip tags to get raw text
soup = BeautifulSoup(summary, "html.parser")
print(soup.get_text())
