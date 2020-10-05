require 'pp'

# Read and represent a typical macrocell file

def do_next_p2(n)
  i = 0
  p = 1
  while p < n
    i += 1
    p <<= 1
  end
  [p, i]
end

next_p2 =
128.times.map do |i|
  do_next_p2(i)
end

macrocells = [nil]

# fname = 'pattern.mc'
fname = ARGV.shift || 'glider.mc'

File.readlines(fname, chomp: true).select.with_index do |line, decindex|
  index = decindex + 1

  case line
  when /^[.*$]*$/
    parts = line.split('$')
    longest = [parts.length, parts.map(&:length).max].max
    side, level = next_p2[longest]

    cells = Array.new(side) { Array.new(side) { 0 } }
    parts.each_with_index do |part, y|
      part.chars.each_with_index do |char, x|
        if char == '*'
          cells[y][x] = 1
        end
      end
    end

    mc = { type: :vals, level: level, subcells: cells, side: side }
    macrocells << mc
  when /^[0-9 ]*$/
    parts = line.split(/\s+/).map(&:to_i)
    if parts.length < 5
      raise 'Malformed refs line'
    end

    level, *cells = parts

    mc = { type: :refs, level: level, subcells: cells, side: 2 ** level }
    macrocells << mc
  end
end

macrocells = macrocells.sort_by { |mc| mc.nil? ? 0 : mc[:level] }

def get_subcell(macrocells, mci, x, y)
  mc = macrocells[mci]
  if mc[:type] == :vals
    return mc[:subcells][x][y]
  elsif mc[:type] == :refs
    half = mc[:side] / 2
    sc_index = 0
    if x >= half
      sc_index += 1
      x -= half
    end
    if y >= half
      sc_index += 2
      y -= half
    end
    subcell = mc[:subcells][sc_index]
    return 0 if subcell == 0
    # puts "subcell = #{subcell}, side = #{mc[:side]}"
    return get_subcell(macrocells, subcell, x, y)
  else
    raise 'Bad :type'
  end
end

def get_cell(macrocells, x, y)
  get_subcell(macrocells, macrocells.length - 1, x, y)
end

side = [macrocells.last[:side], 128].min
side.times do |x|
  side.times do |y|
    print get_cell(macrocells, x, y)
  end
  puts
end
