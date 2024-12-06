def parse_input(filename)
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
    # Get all integers that `current` must be before
    must_be_before = order[current] || []

    # Validate that all integers in `must_be_before` appear after `current` in the page list
    must_be_before.each do |x|
      next unless pages.include?(x) # Skip if `x` isn't in the page list
      return false if pages.index(x) <= index # Invalid if `x` is before or at `current`
    end
  end
  true
end

def sort_with_order(order, page)
  # Sort the list dynamically by applying order rules
  page.sort do |a, b|
    # Determine order between `a` and `b`
    if order[a]&.include?(b)
      -1 # `a` must come before `b`
    elsif order[b]&.include?(a)
      1 # `b` must come before `a`
    else
      0 # No specific order, maintain relative order
    end
  end
end

def process_file(filename)
  order, pages = parse_input(filename)

  middle_values = []

  pages.each_with_index do |page, idx|
    if valid_sequence?(order, page)
      puts "Page list #{idx + 1} is valid: #{page}"
    else
      puts "Page list #{idx + 1} is invalid: #{page}"

      # Sort invalid page list dynamically using order
      sorted_pages = sort_with_order(order, page)
      puts "Sorted order for Page list #{idx + 1}: #{sorted_pages}"

      # Extract middle digit
      middle_index = (sorted_pages.length - 1) / 2
      middle_values << sorted_pages[middle_index]
    end
  end

  # Print middle values for debugging
  puts "Middle values from invalid Page lists: #{middle_values}"

  middle_values.sum
end

filename = "input_5.txt"
result = process_file(filename)

puts "Summation of middle digits from invalid Page lists: #{result}"
