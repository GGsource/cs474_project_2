#############################################################################################
# Author: Geo Gonzalez
# Name: main.rb
# Date: October 17th 2022
# Description: This is the main file for Project 2 - Building an Assembly Language Interpreter
#############################################################################################
require_relative "instructions.rb"
require_relative "Memory.rb"

# Prompt user and get input
print "Please provide the file name for the file you'd like to work with: "
inputFile = gets.rstrip
inputFile = if File.file?("tests/#{inputFile}") then "tests/#{inputFile}" end #checks if 'tests' dir exists to look for file, otherwise checks root directory
memory = Memory.new #Create new memory
# Read lines from file and populate memory
File.readlines("#{inputFile}").each_with_index { |line, i| memory[i] = parseInstruction(line, memory); i += 1 until (i >= 127) }

until memory.reachedEnd? #Main Loop
  puts memory #print out our memory structure for user to see, then tell them the options & get command
  puts "s - Execute a single line of code, starting from the instruction at memory address 0; update the PC, the
    registers and memory according to the instruction; and print the value of the registers, the zero bit, the
    overflow bit, and only the memory locations that store source code or program data after the line is
    executed."
  puts "a - Execute all the instructions until a halt instruction is encountered or there are no more instructions to
    be executed. The program's source code and data used by the program are printed."
  puts "q - Quit the command loop."
  print "\nPlease input your command: "
  cmd = gets.rstrip

  case cmd #Execute user's command
  when "s" #Executes only 1 line
    memory.executeSingle
  when "a" #Executes all lines or checks if user wishes to continue every 10k instructions
    until memory.reachedEnd?
      memory.executeSingle
      if memory.loopWarn
        print "#{memory.curhc} lines have been run so far, there might be an endless loop. Continue? y/n: "
        response = gets.rstrip
        if response.downcase == "n" then break else memory.prevhc = memory.curhc; memory.loopWarn = false end
      end
    end
    puts memory #print the memory at the end of running whole SAL file
    break
  when "q" #quits program
    break
  else #unrecognized command
    puts "Invalid command! Please try again."
  end
end
#Program is ending, say goodbye to user
if (memory.pc > 127) then print "Reached end of source file, " elsif memory.pc < 0 then print "Halt command was encountered, " end
puts "Exiting Project 2, goodbye!"
