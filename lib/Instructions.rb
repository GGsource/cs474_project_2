class SalInstruction
  attr_accessor :opCode, :argType, :arg, :memoryArray

  def execute
  end

  def to_s
    "#{opCode} with #{argType} argument #{"of #@arg" unless @arg.nil?}"
  end
end

# DONE: DEC - Declares a symbolic variable & stores in memory
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
    @memoryArray[@memoryArray.mc] = nil
    @memoryArray.symbolAddresses[@symbol] = @memoryArray.mc
  end
end

# DONE: LDX - LDA and LDB take given symbol value and store it in the register
class LDX < SalInstruction
  def initialize(reg, givenSymbol, mem)
    @opCode = "LD#{reg}"
    @argType = "STRING"
    @arg = givenSymbol
    @memoryArray = mem
  end

  def execute
    if @opCode == "LDA"
      @memoryArray.registerA = @memoryArray[@memoryArray.symbolAddresses[@arg]]
    else
      @memoryArray.registerB = @memoryArray[@memoryArray.symbolAddresses[@arg]]
    end
  end
end

# DONE: LDI - Loads the integer value into the accumulator register. The value could be negative
class LDI < SalInstruction
  def initialize(val, mem)
    @opCode = "LDI"
    @argType = "NUMBER"
    @memoryArray = mem
    @arg = val
  end

  def execute
    @memoryArray.registerA = @arg
  end
end

# TODO: STR - Stores content of accumulator into data memory at address of symbol.
class STR < SalInstruction
  def initialize(givenSymbol, mem)
    @opCode = "STR"
    @argType = "STRING"
    @arg = givenSymbol
    @memoryArray = mem
  end

  def execute
    @memoryArray[@memoryArray.symbolAddresses[@arg]] = @memoryArray.registerA
  end
end

# TODO: XCH
# TODO: JMP
# TODO: JZS
# TODO: JVS
# TODO: ADD
# TODO: HLT

# parseInstruction -
# Function that reads in a line and parses it as an instruction
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
  when "LDI"
    return LDI.new(arg, memory)
  when "STR"
    return STR.new(arg, memory)
  else
    return "Unknown instruction..."
  end
end
