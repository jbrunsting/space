clear # Clear once at the start
old_output=""

while true; do
  # 1. Capture the new command output into a variable
  new_output=$(luacheck .)

  # 2. Compare the new output to the old output
  if [[ "$new_output" != "$old_output" ]]; then
    printf "\033[H\033[J"  # Move cursor to top and clear screen
    printf "%s\n" "$new_output" # Print the new text
    old_output="$new_output"    # Update the tracking variable
  fi

  sleep 1
done
