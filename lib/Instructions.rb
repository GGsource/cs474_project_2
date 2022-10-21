class SalInstruction
  attr_accessor :opCode, :argType, :arg, :memoryArray

  def execute
  end

  def to_s
    "#{opCode} with #{argType} argument #{"of #@arg" unless @arg.nil?}"
  end
end

# DONE: DEC
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
    @memoryArray[@memoryArray.mc] = { @symbol => 42 }
    @memoryArray.symbolAddresses[@symbol] = @memoryArray.mc
  end
end

# DONE: LDX - LDA and LDB are identical so we can use most of the same class for them
class LDX < SalInstruction
  attr_accessor :symbol, :register

  def initialize(reg, givenSymbol, mem)
    @opCode = "LD#{reg}"
    @argType = "STRING"
    @symbol = givenSymbol
    @arg = givenSymbol
    @memoryArray = mem
  end

  def execute
    case @opCode
    when "LDA"
      @memoryArray.registerA = @memoryArray[@memoryArray.symbolAddresses[@arg]][@arg]
    when "LDB"
      @memoryArray.registerB = @memoryArray[@memoryArray.symbolAddresses[@arg]][@arg]
    end
  end
end

# TODO: LDB
# TODO: LDI
# TODO: STR
# TODO: XCH
# TODO: JMP
# TODO: JZS
# TODO: JVS
# TODO: ADD
# TODO: HLT

def parseInstruction(line, memory)
  input = line.split(" ", 2)
  instruction, arg = input[0], input[1]
  unless arg.nil?
    arg = arg.rstrip
  end

  case instruction
  when "DEC"
    return DEC.new(arg, memory)
  when "LDA"
    return LDX.new("A", arg, memory)
  when "LDB"
    return LDX.new("B", arg, memory)
  else
    return "Unknown instruction..."
  end
end
