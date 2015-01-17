margin = [20, 50, 20, 50]
width = 1800
height = 1850

svg = d3.select 'body'
  .append 'svg:svg'
  .attr 'width', width
  .attr 'height', height
  .append 'svg:g'
  .attr 'transform', 'translate(' + margin[3] + ',' + margin[0] + ')'

tree = d3.layout.tree()
  .size [width - margin[1] - margin[3] , height - margin[0] - margin[2]]

d3.json 'scripts/data.json', (data) ->
  nodes = tree.nodes data
  links = tree.links nodes

  nodes.forEach (d) -> d.y = d.depth * 250

  diagonal = d3.svg.diagonal()
    .projection (d) -> return [d.y, d.x]

  svg.selectAll '.link'
    .data links
    .enter()
    .append 'path'
    .attr 'class', 'link'
    .attr 'd', diagonal

  node = svg.selectAll '.node'
    .data nodes
    .enter()
    .append 'g'
    .attr 'class', 'node'
    .attr 'transform', (d) -> return 'translate(' + d.y + ',' + d.x + ')'

  node.append 'circle'
    .attr 'r', 5

  node.append 'text'
    .text (d) -> return d.name
    .attr 'x', -4
    .attr 'y', -8

