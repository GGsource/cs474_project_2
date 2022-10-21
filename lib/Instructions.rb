class SalInstruction
  attr_accessor :opCode, :argType, :arg, :memoryArray

  def execute
  end

  def to_s
    "#{opCode} #{"with #{argType} argument of #@arg" unless @arg.nil?}"
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
  def initialize(instruction, givenSymbol, mem)
    @opCode = instruction
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

# DONE: STR - Stores content of accumulator into data memory at address of symbol.
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

# DONE: XCH - Exchanges the content registers A and B.
class XCH < SalInstruction
  def initialize(mem)
    @opCode = "XCH"
    @argType = "NONE"
    @memoryArray = mem
  end

  def execute
    temp = @memoryArray.registerA
    @memoryArray.registerA = @memoryArray.registerB
    @memoryArray.registerB = temp
  end
end

# TODO: JMP - Transfers control to instruction at address number in program memory.
class JMP < SalInstruction
  def initialize(address, mem)
    @opCode = "JMP"
    @argType = "NUMBER"
    @memoryArray = mem
    @arg = address
  end

  def execute
    @memoryArray.pc = @arg #Sets program counter to the given address
  end
end

# TODO: JZS - Transfers control to instruction at address number if the zero-result bit is set.
# TODO: JVS - Transfers control to instruction at address number if the overflow bit is set.
# TODO: ADD - Adds registers A and B. Sum is stored in A. The overflow and zero-result bits are set or cleared
# TODO: HLT - Terminates program execution.

# parseInstruction -
# Function that reads in a line and parses it as an instruction
def parseInstruction(line, memory)
  input = line.split(" ", 2)
  instruction, arg = input[0], input[1]
  arg = arg.rstrip unless arg.nil?

  case instruction
  when "DEC"
    return DEC.new(arg, memory)
  when "LDA", "LDB"
    return LDX.new(instruction, arg, memory)
  when "LDI"
    return LDI.new(arg, memory)
  when "STR"
    return STR.new(arg, memory)
  when "XCH"
    return XCH.new(memory)
  when "JMP"
    return JMP.new(arg, memory)
  else
    return "Unknown instruction..."
  end
end
