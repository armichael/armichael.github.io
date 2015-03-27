var width = 1060,
	height = 860;
 
var svg = d3.select("body").append("svg")
	.attr("width", width)
	.attr("height", height);
 



d3.json("../json/nbh2.json", function(error, topology) {
  if (error) return console.error(error);

console.clear();

 
var featureCol = topojson.feature(topology,topology.objects.nbhoods2);
var bounds = d3.geo.bounds(featureCol);
var centerX = d3.sum(bounds, function(d) {return d[0];}) / 2,
    centerY = d3.sum(bounds, function(d) {return d[1];}) / 2;

var projection = d3.geo.mercator()
    .center([centerX,centerY])
    //.rotate([4.4, 0])
    //.parallels([50, 60])
    .scale(187000)
    .translate([width / 3, height / 2.5]);
var path = d3.geo.path()
	.projection(projection);

svg.selectAll("path")
  .data(featureCol.features)
  .enter().append("path")
.attr("class",function(d) {return "featureCol "+d.id})
  .attr("d", path);

});