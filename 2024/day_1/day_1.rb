# Function to calculate the total distance

def calculate_total_distance(left_list, right_list)
  # Sort both lists
  
  sorted_left_list = left_list.sort
  sorted_right_list = right_list.sort

  # Calculate total distance
  total_distance = 0
  sorted_left_list.each_with_index do |left, index|
    total_distance += (left - sorted_right_list[index]).abs
  end

  total_distance
end

left_list = [] # List to store the left values
right_list = [] # List to store the right values

# Sample Input
File.readlines('input.txt').each do |line|
  left, right = line.split.map(&:to_i)
  left_list << left
  right_list << right
end

total_distance = calculate_total_distance(left_list, right_list)
puts total_distance