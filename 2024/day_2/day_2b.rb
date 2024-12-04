# Function to check if a report is safe
def is_safe?(levels)
  # Calculate differences between adjacent levels
  differences = levels.each_cons(2).map { |a, b| b - a }

  # Check if the differences are all positive (increasing) or all negative (decreasing)
  increasing = differences.all? { |diff| diff >= 1 && diff <= 3 }
  decreasing = differences.all? { |diff| diff <= -1 && diff >= -3 }

  # A report is safe if it is either strictly increasing or strictly decreasing
  increasing || decreasing
end


# Function to check if a report can be made safe by removing one level
def can_be_safe_with_dampener?(levels)
  # Try removing each level and check if the resulting sequence is safe
  levels.each_with_index do |_, index|
    # Create a new array without the current level
    modified_levels = levels[0...index] + levels[index + 1..]
    return true if is_safe?(modified_levels)
  end
  false
end

# Read the data from the input file
safe_count = 0
File.foreach('input_2.txt') do |line|
  # Convert the line into an array of integers
  levels = line.split.map(&:to_i)

  # Check if the report is safe directly or can be made safe
  if is_safe?(levels) || can_be_safe_with_dampener?(levels)
    safe_count += 1
  end
end

# Output the total number of safe reports
puts "Number of safe reports: #{safe_count}"