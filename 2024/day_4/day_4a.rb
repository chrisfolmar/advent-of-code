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

# Directions for neighbors: up, down, left, right, and diagonals
DIRECTIONS = [
  [-1, 0], [1, 0], [0, -1], [0, 1],    # Up, Down, Left, Right
  [-1, -1], [-1, 1], [1, -1], [1, 1]   # Diagonals
]

# Recursive search for the target string in a single direction
def search_in_direction(grid, coord, direction, target, index)
  # Base case: if the full target string is matched
  return true if index == target.length

  row, col = coord
  dr, dc = direction
  new_coord = [row + dr, col + dc]

  # Check bounds and character match
  if grid[new_coord] == target[index]
    return search_in_direction(grid, new_coord, direction, target, index + 1)
  end

  false
end

# Find all occurrences of "XMAS" in the grid
def find_xmas(grid)
  xmas_count = 0
  target = "XMAS"

  # Iterate over all coordinates
  grid.each do |coord, char|
    # Start search only from 'X'
    if char.upcase == target[0]
      DIRECTIONS.each do |direction|
        xmas_count += 1 if search_in_direction(grid, coord, direction, target, 1)
      end
    end
  end

  xmas_count
end

# Read the grid from the file
filename = "input_4.txt" # Replace with your file path
grid = read_grid_from_file(filename)

# Count "XMAS" substrings in the grid
puts "Total 'XMAS' substrings found: #{find_xmas(grid)}"
