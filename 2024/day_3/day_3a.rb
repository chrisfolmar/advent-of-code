# Calculate multiplication of regex matches in a line

total = 0
# Read sample input
File.readlines('input_3.txt').each do |line|
  # Use scan and map to process the integers
  line.scan(/mul\((\d+),(\d+)\)/).map do |match|
    first_integer, second_integer = match.map(&:to_i) # Convert strings to integers
    puts "first integer: #{first_integer}"
    puts "second integer: #{second_integer}"
    # multiply the integers and add to the total
    total += first_integer * second_integer
    puts "Total: #{total}"
  end
end

# Output the total
puts "Sums of memory: #{total}"