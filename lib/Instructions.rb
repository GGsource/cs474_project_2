class SalInstruction
  attr_accessor :opCode, :argType

  def execute
  end

  def to_s
    "#{opCode} with a #{argType} argument"
  end
end

class DEC < SalInstruction
  attr_accessor :symbol, :memoryArray, :ndx

  def initialize(givenSymbol, memoryArray, ndx)
    @opCode = "DEC"
    @argType = "STRING"
    @symbol = givenSymbol
  end

  def execute
    memoryArray[ndx] = { ndx => { givenSymbol => nil } }
  end
end

def parseInstruction(line, memoryArray, counter)
  input = line.split(" ", 2)
  instruction, argument = input[0], input[1]

  case instruction
  when "DEC"
    return DEC.new(argument, memoryArray, counter)
  else
    return "Unknown instruction..."
  end
end
