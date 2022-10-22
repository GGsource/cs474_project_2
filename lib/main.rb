#############################################################################################
# Author: Geo Gonzalez
# Name: main.rb
# Date: October 17th 2022
# Description: This is the main file for Project 2 - Building an Assembly Language Interpreter
#############################################################################################
require_relative "instructions.rb"
require_relative "Memory.rb"

print "Please provide the file name for the file you'd like to work with: "
inputFile = gets[0...-1]
memory = Memory.new
inputFile = if File.file?("tests/#{inputFile}") then "tests/#{inputFile}" end #checks if 'tests' dir exists to look for file, otherwise checks root directory
File.readlines("#{inputFile}").each_with_index { |line, i| memory[i] = parseInstruction(line, memory); i += 1 until (i >= 127) }

until memory.reachedEnd?
  puts memory
  puts "s - Execute a single line of code, starting from the instruction at memory address 0; update the PC, the
    registers and memory according to the instruction; and print the value of the registers, the zero bit, the
    overflow bit, and only the memory locations that store source code or program data after the line is
    executed."
  puts "a - Execute all the instructions until a halt instruction is encountered or there are no more instructions to
    be executed. The program's source code and data used by the program are printed."
  puts "q - Quit the command loop."
  print "\nPlease input your command: "
  cmd = gets.rstrip

  case cmd
  when "s"
    # DONE: Implement command s
    memory.executeSingle
  when "a"
    # DONE: Implement command a
    memory.executeSingle until memory.reachedEnd?
    puts memory
  when "q"
    break
  else
    puts "Invalid command! Please try again."
  end
end
if (memory.pc > 127) then print "Reached end of source file, " elsif memory.pc < 0 then print "Halt command was encountered, " end
puts "Exiting Project 2, goodbye!"
