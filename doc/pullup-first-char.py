"""
Pull up graph so first-lexical character appears

just to comply with Vimscript syntax highlighting
"""
import errno
import logging
import os
import pydot

logging.basicConfig(level=logging.DEBUG)

graphs = pydot.graph_from_dot_file("nftables.dot")
graph = graphs[0]

graph.write_png("output.png")
output_graphviz_svg = graph.create_svg()
my_networkx_graph = networkx.drawing.nx_pydot.from_pydot(graph)

print('End of program.')
