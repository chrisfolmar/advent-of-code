# Calculate similarity between two lists

def calculate_similarity(left_list, right_list)
  # Sort both lists
  sorted_left_list = left_list.sort
  sorted_right_list = right_list.sort

  # how often each element in the left appears in the right, 
  # multiplying the left element by that frequency
  similarity = 0
  sorted_left_list.each do |left|
    frequency = sorted_right_list.count(left)
    similarity += left * frequency
  end

  similarity
end

left_list = [] # List to store the left values
right_list = [] # List to store the right values

# Sample Input
File.readlines('input.txt').each do |line|
  left, right = line.split.map(&:to_i)
  left_list << left
  right_list << right
end

similarity = calculate_similarity(left_list, right_list)
puts similarity