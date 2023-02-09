import time
import sys

from feedparser import parse

URL = 'https://rcs.mako.co.il/rss/MainSliderRss.xml'

for e in parse(URL).entries:
    sys.stdout.write(e.title[::-1] + "\n")
    time.sleep(3)
