require 'set'

def parse_grid_file(filename)
  grid = []
  start_x, start_y = nil, nil

  File.readlines(filename).each_with_index do |line, row|
    # Parse the grid row by row
    grid_row = line.strip.chars
    grid << grid_row

    # Find the starting position marked with '^'
    if start_x.nil? && start_y.nil?
      start_y = grid_row.index("^")
      start_x = row if start_y
    end
  end

  if start_x.nil? || start_y.nil?
    raise "Starting position '^' not found in the grid."
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

# Function to move in a given direction
def move_in_direction(x, y, direction)
  dx, dy = case direction
           when :up then [-1, 0]
           when :down then [1, 0]
           when :left then [0, -1]
           when :right then [0, 1]
           end

  # Move to the new position
  [x + dx, y + dy]
end

# Function to simulate traversal with an obstruction
def simulate_traversal_with_obstruction(grid, start_x, start_y, start_direction, obstruction_x, obstruction_y)
  # Temporarily add an obstruction
  original = grid[obstruction_x][obstruction_y]
  # Mark the obstruction as a wall
  grid[obstruction_x][obstruction_y] = "#" if original == "."

  x, y = start_x, start_y
  direction = start_direction
  visited_states = Set.new

  while true
    # Store the current state as a tuple (x, y, direction)
    state = [x, y, direction]
    # If this state has been visited before, it's a loop
    if visited_states.include?(state)
      # Restore the original cell and return loop detected
      grid[obstruction_x][obstruction_y] = original if original == "."
      return true
    end

    # Mark the current state as visited
    visited_states.add(state)

    # Move in the current direction
    new_x, new_y = move_in_direction(x, y, direction)

    # Check if the next position is out of bounds
    if new_x < 0 || new_x >= grid.size || new_y < 0 || new_y >= grid[0].size
      break # Out of bounds, traversal ends
    end

    cell = grid[new_x][new_y]

    if cell == "#" # Obstacle
      direction = turn_right(direction)
    elsif cell == "." || cell == "^" # Open space
      x, y = new_x, new_y # Move to the new position
    else
      break # Invalid cell
    end
  end

  # Restore the original cell
  grid[obstruction_x][obstruction_y] = original if original == "."
  false # No loop detected
end

def count_loop_positions(grid, start_x, start_y)
  loop_count = 0

  grid.each_with_index do |row, x|
    row.each_with_index do |cell, y|
      next unless cell == "." || cell == "^" # Only consider open spaces

      if simulate_traversal_with_obstruction(grid, start_x, start_y, :up, x, y)
        loop_count += 1
      end
    end
  end

  loop_count
end

# Test with the provided input
filename = "input_6.txt" # Replace with your file path
begin
  grid, start_x, start_y = parse_grid_file(filename)
  puts "Starting location: (#{start_x}, #{start_y}), direction: Up"

  # Count loop positions
  result = count_loop_positions(grid, start_x, start_y)
  puts "Number of locations that force a loop: #{result}"
rescue => e
  puts "Error: #{e.message}"
end
