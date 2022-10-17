#############################################################################################
# Author: Geo Gonzalez
# Name: main.rb
# Date: October 17th 2022
# Description: This is the main file for Project 2: Building an Assembly Language Interpreter
#############################################################################################

print "Please provide the file name for the file you'd like to work with: "
input = gets[0...-1]
salText = File.open("#{input}").read #contains all the lines in the given file

until false
  puts "s - Execute a single line of code, starting from the instruction at memory address 0; update the PC, the
    registers and memory according to the instruction; and print the value of the registers, the zero bit, the
    overflow bit, and only the memory locations that store source code or program data after the line is
    executed."
  puts "a - Execute all the instructions until a halt instruction is encountered or there are no more instructions to
    be executed. The program's source code and data used by the program are printed."
  puts "q - Quit the command loop."
  print "Please input your command: "
  cmd = gets[0...-1]

  # DEBUGGING: prints given command
  puts "Your command was #{cmd}"

  case cmd
  when "s"
    # TODO: Implement command s
    puts "command s not yet implemented..."
  when "a"
    # TODO: Implement command a
    puts "command a not yet implemented..."
  when "q"
    break
  end
end

puts "Exiting Project 2, goodbye!"
