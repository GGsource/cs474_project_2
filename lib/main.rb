#############################################################################################
# Author: Geo Gonzalez
# Name: main.rb
# Date: October 17th 2022
# Description: This is the main file for Project 2: Building an Assembly Language Interpreter
#############################################################################################

require_relative "instructions.rb"

print "Please provide the file name for the file you'd like to work with: "
input = gets[0...-1]
memoryArray = Array.new(256)
registerA = registerB = pc = zeroResultBit = overflowBit, mc = 0
File.readlines("#{input}").each_with_index { |line, i| memoryArray[i] = parseInstruction(line, memoryArray, mc); i += 1 until (i >= 127) }

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

  case cmd
  when "s"
    # TODO: Implement command s
    puts "running command at line "
  when "a"
    # TODO: Implement command a
    puts "command a not yet implemented..."
  when "q"
    break
  when "p"
    # DEBUGGING: confirms the array is filled with instructions
    memoryArray.each_with_index { |val, i| puts "#{i}. #{val}" }
  else
    puts "Invalid command! Please try again."
  end
end

puts "Exiting Project 2, goodbye!"
