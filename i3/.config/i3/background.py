import os
import sys
from random import randint


def get_specific_background(wallpapers_dir=os.path.join(os.path.expanduser("~"), "wallpapers")):
	file_list = os.listdir(wallpapers_dir)
	return os.path.join(wallpapers_dir, file_list[randint(0, len(file_list)-1)])



if __name__ == "__main__":
	os.popen(f"feh --bg-fill {get_specific_background()}")	
