#!/usr/bin/python3
import os
import sys
import re

uuid_regex_string = r"(?P<uuid>[a-f0-9]{8}\-[a-f0-9]{4}\-[a-f0-9]{4}\-[a-f0-9]{4}\-[a-f0-9]{12})"
network_type_regex = re.compile(f".*?\s*?{uuid_regex_string}\s*(?P<type>\w*)\s+?.*?")
network_name_regex = re.compile(f"(?P<name>.*){uuid_regex_string}\s*.*")

def get_network_data():
    return os.popen("nmcli c show --active").read().strip().split("\n")

def get_network_type(network_data):
    return network_type_regex.match(network_data[1]).group("type")

def get_network_name(network_data):
    return network_name_regex.match(network_data[1]).group("name")

def main():
    net_data = get_network_data()
    if len(net_data) < 2:
        sys.stdout.write("disconnected ")
        sys.exit(0)
    net_type = get_network_type(net_data)
    net_name = get_network_name(net_data).strip()
    if net_type == "wifi":
        sys.stdout.write(f"  {net_name}")
    elif net_type == "ethernet":
        sys.stdout.write("")

if __name__ == "__main__":
    main()

