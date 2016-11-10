#!/usr/bin/env python
# -*- coding: gbk -*-
"""
Usage: dump task and files
Author: xululu
"""

import sys
import xml.etree.ElementTree as ET
import subprocess
import copy

def CDATA(text=None):
    element = ET.Element('![CDATA[')
    element.text = text
    return element

ET._original_serialize_xml = ET._serialize_xml
def _serialize_xml(write, elem, encoding, qnames, namespaces):
    if elem.tag == '![CDATA[':
        write("<%s%s]]>" % (elem.tag, elem.text))
        return
    return ET._original_serialize_xml(
         write, elem, encoding, qnames, namespaces)
ET._serialize_xml = ET._serialize['xml'] = _serialize_xml


if __name__ == '__main__':
    if len(sys.argv) != 2:
        print 'Usage: python %s data_path' % sys.argv[0]
        sys.exit(1)
    sys.stdin.readline() # ignore encoding line
    org_tree = ET.parse(sys.stdin)
    new_tree = copy.deepcopy(org_tree)
    org_root = org_tree.getroot()
    new_root = new_tree.getroot()
    del new_root[:]
    #org_tree.write(sys.stdout)
    #new_tree.write(sys.stdout)
    for task in org_root:
        src_file = task.text[task.text.find('filepath'):].split('\n')[0].split(":")[1].strip(" ").strip('"')
        if subprocess.call(['cp', src_file, sys.argv[1]]) != 0:
            sys.stderr.write("error happened!")
            sys.exit(1)
        new_task = copy.deepcopy(task)
        new_task.text = ""
        new_task.append(CDATA(task.text))
        new_root.append(new_task)
    sys.stderr.write(str(len(new_root)) + " tasks has been successfully added!\n") 
    new_tree.write(sys.stdout)
