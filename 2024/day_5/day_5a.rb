def parse_file(filename)
  order = {}
  pages = []

  File.readlines(filename).each do |line|
    line.strip!

    if line.include?('|')
      # Parse dictionary part (X|Y format)
      x, y = line.split('|').map(&:strip)
      order[x.to_i] ||= []
      order[x.to_i] += y.split(',').map(&:to_i) if y && !y.empty?
    elsif !line.empty?
      # Parse lists of integers
      pages << line.split(',').map(&:to_i)
    end
  end

  [order, pages]
end

def valid_sequence?(order, pages)
  pages.each_with_index do |current, index|
    # Get all pages that `current` must be before
    must_be_before = order[current] || []

    # Validate that all pages in `must_be_before` appear after `current` in the page list
    must_be_before.each do |x|
      next unless pages.include?(x) # Skip if `x` isn't in the list
      return false if pages.index(x) <= index # Invalid if `x` is before or at `current`
    end
  end
  true
end

def process_file(filename)
  order, pages = parse_file(filename)

  middle_values = []

  pages.each_with_index do |page, idx|
    if valid_sequence?(order, page)
      # Debug: print valid page list
      puts "Page list #{idx + 1} is valid: #{page}"

      # Extract middle digit
      middle_index = (page.length - 1) / 2
      middle_values << page[middle_index]
    else
      # Debug: print invalid lists
      puts "Page list #{idx + 1} is invalid: #{page}"
    end
  end

  # Debug: print all middle values
  puts "Middle values from valid page lists: #{middle_values}"

  middle_values.sum
end

filename = "input_5.txt"
result = process_file(filename)

puts "Summation of middle digits from correct lines: #{result}"
