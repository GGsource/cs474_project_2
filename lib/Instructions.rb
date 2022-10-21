class SalInstruction
  attr_accessor :opCode, :argType

  def execute
  end

  def to_s
    "#{opCode} with #{argType} argument"
  end
end

class DEC < SalInstruction
  attr_accessor :symbol, :memoryArray, :i

  def initialize(givenSymbol, array)
    @opCode = "DEC"
    @argType = "STRING"
    @symbol = givenSymbol
    @memoryArray = array
  end

  def execute
    @memoryArray[@memoryArray.mc] = { @memoryArray.mc => { @symbol => nil } }
  end

  def to_s
    "#{super.to_s} of #{@symbol}"
  end
end

def parseInstruction(line, memory)
  input = line.split(" ", 2)
  instruction, argument = input[0], input[1]

  case instruction
  when "DEC"
    return DEC.new(argument[0...-1], memory)
  else
    return "Unknown instruction..."
  end
end
