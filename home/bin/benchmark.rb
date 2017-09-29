require 'benchmark'
 
n = 100000
Benchmark.bm do |x|
   #x.report('copy') { n.times do ; h = {}; h = h.merge({1 => 2}); end }
   #x.report('no copy') { n.times do ; h = {}; h.merge!({1 => 2}); end }
end
 
#          user        system      total        real
# copy     0.460000   0.180000   0.640000 (  0.640692)
# no copy  0.340000   0.120000   0.460000 (  0.463339)
 
