require 'set'

# Function to parse the grid file
def parse_grid_file(filename)
  grid = []
  start_x, start_y = nil, nil

  File.readlines(filename).each_with_index do |line, row|
    grid_row = line.strip.chars
    grid << grid_row
    if (col = grid_row.index('^'))
      start_x, start_y = row, col
    end
  end

  [grid, start_x, start_y]
end

# Function to turn right
def turn_right(direction)
  case direction
  when :up then :right
  when :right then :down
  when :down then :left
  when :left then :up
  end
end

# Function to move in the current direction
def move(x, y, direction)
  case direction
  when :up then [x - 1, y]
  when :right then [x, y + 1]
  when :down then [x + 1, y]
  when :left then [x, y - 1]
  end
end

# Function to traverse the grid
def traverse_grid(grid, start_x, start_y, direction)
  x, y = start_x, start_y
  visited = Set.new([[x, y]])
  spaces_visited = 1

  loop do
    # Move in the current direction
    new_x, new_y = move(x, y, direction)

    # Check for out of bounds
    if new_x < 0 || new_x >= grid.size || new_y < 0 || new_y >= grid[0].size
      puts "Out of bounds at (#{new_x}, #{new_y}). Stopping traversal."
      break
    end

    cell = grid[new_x][new_y]

    if cell == "#" # Obstacle
      direction = turn_right(direction) # Turn right
    elsif cell == "." || cell == "^" # Open space
      # Check if the new position has been visited before
      unless visited.include?([new_x, new_y])
        visited.add([new_x, new_y])
        spaces_visited += 1
      end
      x, y = new_x, new_y # Move to the new position
    else
      # Stop traversal on unknown or invalid cells
      puts "Unknown or invalid cell at (#{new_x}, #{new_y}). Stopping traversal."
      break
    end
  end

  spaces_visited
end

# Test with the provided input
filename = "input_6.txt" # Replace with your file path
begin
  grid, start_x, start_y = parse_grid_file(filename)
  puts "Starting location: (#{start_x}, #{start_y}), direction: Up"

  # Start traversal at the position of `^` facing :up
  result = traverse_grid(grid, start_x, start_y, :up)
  puts "Total spaces visited: #{result}"
rescue => e
  puts "Error: #{e.message}"
end
