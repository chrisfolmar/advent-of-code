# Calculate multiplication of regex matches in a line

total = 0
toggle = true
# Read sample input
File.readlines('input_3.txt').each do |line|

  matches =  line.scan(/mul\(\d{1,3},\d{1,3}\)|do\(\)|don't\(\)/)

  puts "Line: #{matches}"
  # Process each match
  matches.each do |match|

    if match == "do()"
      puts "Found: do()"
        toggle = true

    elsif match == "don't()"
        puts "Found: don't()"
        toggle = false

    else
      if toggle
          match.scan(/mul\((\d+),(\d+)\)/).map do |match|
          # Convert strings to integers
          first_integer, second_integer = match.map(&:to_i) 

          # multiply the integers and add to the total
          total += first_integer * second_integer

          puts "Found: mul(#{match[0]}, #{match[1]})"
        end
      end
    end
    
  end

  # Output the total
  puts "Sums of memory: #{total}"
end



