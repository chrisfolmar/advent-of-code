
# Function to read the grid from a .txt file
def read_grid_from_file(filename)
  grid = {}
  File.readlines(filename).each_with_index do |line, row_index|
    line.strip.chars.each_with_index do |char, col_index|
      grid[[row_index, col_index]] = char
    end
  end
  grid
end

# Function to check if a given "A" forms an "X" with "MAS" or "SAM"
def is_valid_x(grid, coord)
  row, col = coord

  # Check the four diagonal neighbors
  top_left = [row - 1, col - 1]
  top_right = [row - 1, col + 1]
  bottom_left = [row + 1, col - 1]
  bottom_right = [row + 1, col + 1]

  # Ensure coordinates are within bounds
  return false unless grid.key?(top_left) && grid.key?(top_right) && grid.key?(bottom_left) && grid.key?(bottom_right)

  # Check if "MAS" or "SAM" is formed in both diagonal directions
  if (grid[top_left] == 'M' && grid[bottom_right] == 'S' && grid[top_right] == 'S' && grid[bottom_left] == 'M') ||
     (grid[top_left] == 'S' && grid[bottom_right] == 'M' && grid[top_right] == 'M' && grid[bottom_left] == 'S') ||
     (grid[top_left] == 'M' && grid[bottom_right] == 'S' && grid[top_right] == 'M' && grid[bottom_left] == 'S') ||
     (grid[top_left] == 'S' && grid[bottom_right] == 'M' && grid[top_right] == 'S' && grid[bottom_left] == 'M')
    return true
  end

  false
end

# Function to count unique "MAS" in the grid
def count_x_mas(grid)
  count = 0

  # Iterate over all coordinates
  grid.each do |coord, char|
    if char == 'A'
      count += 1 if is_valid_x(grid, coord)
    end
  end

  count
end

# Read the grid from the file
filename = "input_4.txt" # Replace with your .txt file path
grid = read_grid_from_file(filename)

# Count "MAS" substrings in the shape of an X
puts "Total 'MAS' occurrences in X shape: #{count_x_mas(grid)}"
