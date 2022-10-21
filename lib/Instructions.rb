class SalInstruction
  attr_accessor :opCode, :argType, :arg, :memoryArray

  def execute
  end

  def to_s
    "#{opCode} with #{argType} argument #{"of #@arg" unless @arg.nil?}"
  end
end

class DEC < SalInstruction
  attr_accessor :symbol

  def initialize(givenSymbol, mem)
    @opCode = "DEC"
    @argType = "STRING"
    @symbol = givenSymbol
    @arg = givenSymbol
    @memoryArray = mem
  end

  def execute
    @memoryArray[@memoryArray.mc] = { @symbol => nil }
    @memoryArray.symbolAddresses[@symbol] = @memoryArray.mc
  end
end

class LDA < SalInstruction
  attr_accessor :symbol

  def initialize(givenSymbol, mem)
    @opCode = "LDA"
    @argType = "STRING"
    @symbol = givenSymbol
    @arg = givenSymbol
    @memoryArray = mem
  end

  def execute
    @memoryArray.registerA = @memoryArray[@memoryArray.symbolAddresses[@arg]][@arg]
  end
end

def parseInstruction(line, memory)
  input = line.split(" ", 2)
  instruction, arg = input[0], input[1]
  unless arg.nil?
    arg = arg[0...-1]
  end

  case instruction
  when "DEC"
    return DEC.new(arg, memory)
  when "LDA"
    return LDA.new(arg, memory)
  else
    return "Unknown instruction..."
  end
end
