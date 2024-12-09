#!/usr/bin/env python3

import subprocess
import pygraphviz

# input_file='/tmp/parser.gv'  # current filetype, not used here
input_file='./nftables.dot'  # alternative older filetype

image_file='./nftables.svg'

print('Reading %s as DOT graph.' % input_file)
graph = pygraphviz.AGraph(
                   name='myGraph', 
                   filename=input_file, 
                   directed=True, 
                   strict=False
                  )
graph.layout(prog='dot')  # read DOT-format
print('number of edges: ', graph.number_of_edges())
print('number of nodes: ', graph.number_of_nodes())
graph.draw(image_file)
print('File %s created.' % image_file)

bash_command = "eog " + a_image_file
process = subprocess.Popen(bash_command.split(), stdout=subprocess.PIPE)
print('Spawning eog as a SVG viewer.')
process.communicate()

