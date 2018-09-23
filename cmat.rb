require 'colorize'
require 'pry'

class Range
  def sample; to_a.sample; end
end

chars = ('A'..'Z').to_a + ('a'..'z').to_a + (0..9).to_a
chunk_count = 0
chunk_size = (1..25).sample
cols = `tput cols`.chomp.to_i
rows = `tput lines`.chomp.to_i - 1
void = false
void_col = (0..cols).sample

ans = []

loop do
  print "\e[H\e[2J"
  ans << []

  void = true if !void && (0..5).sample == 0

  cols.times do |i|
    ans.last << (void && chunk_count < chunk_size && i == void_col ? ' ' : chars.sample)
  end

  chunk_count += 1 if void

  if void && chunk_size == chunk_count
    chunk_count = 0
    chunk_size = (1..25).sample
    void = false
    void_col = (0..cols).sample
  end

  ans.reverse.each { |line| puts line.join('').colorize(:blue) }

  ans.shift if ans.length > rows
  sleep 0.05
end

