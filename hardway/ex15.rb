filename = ARGV.first
txt = open(filename)

lines = txt.read
lines.each_line {|x| puts x, x.length}