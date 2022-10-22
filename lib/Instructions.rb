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
    @memoryArray.mc += 1; @memoryArray.pc += 1
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
    @memoryArray.pc += 1
  end
end

# DONE: LDI - Loads the integer value into the accumulator register. The value could be negative
class LDI < SalInstruction
  def initialize(val, mem)
    @opCode = "LDI"
    @argType = "NUMBER"
    @memoryArray = mem
    @arg = val.to_i
  end

  def execute
    @memoryArray.registerA = @arg
    @memoryArray.pc += 1
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
    @memoryArray.pc += 1
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
    @memoryArray.pc += 1
  end
end

# DONE: JMP - Transfers control to instruction at address number in program memory.
class JMP < SalInstruction
  def initialize(address, mem)
    @opCode = "JMP"
    @argType = "NUMBER"
    @memoryArray = mem
    @arg = address.to_i
  end

  def execute
    @memoryArray.pc = @arg #Sets program counter to the given address
  end
end

# DONE: JZS - Transfers control to instruction at address number if the zero-result bit is set.
class JZS < SalInstruction
  def initialize(address, mem)
    @opCode = "JZS"
    @argType = "NUMBER"
    @memoryArray = mem
    @arg = address.to_i
  end

  def execute
    if @memoryArray.zeroResultBit == 1
      @memoryArray.pc = @arg
    else
      @memoryArray.pc += 1
    end
  end
end

#IDEA: Combine these two classes into 1 ^v^v^v

# DONE: JVS - Transfers control to instruction at address number if the overflow bit is set.
class JVS < SalInstruction
  def initialize(address, mem)
    @opCode = "JVS"
    @argType = "NUMBER"
    @memoryArray = mem
    @arg = address.to_i
  end

  def execute
    if @memoryArray.overflowBit == 1
      @memoryArray.pc = @arg
    else
      @memoryArray.pc += 1
    end
  end
end

# DONE: ADD - Adds registers A and B. Sum is stored in A. The overflow and zero-result bits are set or cleared
class ADD < SalInstruction
  def initialize(mem)
    @opCode = "ADD"
    @argType = "NONE"
    @memoryArray = mem
  end

  def execute
    @memoryArray.registerA += @memoryArray.registerB #sum the values together into A
    # Set Zero Result bit
    if @memoryArray.registerA == 0 #Check if the resulting sum was 0
      @memoryArray.zeroResultBit = 1 #If it was, then set zeroResultBit to 1
    else #Otherwise, set it to 0
      @memoryArray.zeroResultBit = 0
    end
    # Set overflow bit
    if @memoryArray.registerA > (2 ** 31) - 1 || @memoryArray.registerA < -(2 ** 31)
      @memoryArray.overflowBit = 1
    else
      @memoryArray.overflowBit = 0
    end
    @memoryArray.pc += 1 #Progress the counter forward
  end
end

# DONE: HLT - Terminates program execution.
class HLT < SalInstruction
  def initialize(mem)
    @opCode = "HLT"
    @argType = "NONE"
    @memoryArray = mem
  end

  def execute
    @memoryArray.pc = -1 #Set to negative 1 to distinguish it from running out of source code space
  end
end

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
  when "JZS"
    return JZS.new(arg, memory)
  when "JVS"
    return JVS.new(arg, memory)
  when "ADD"
    return ADD.new(memory)
  when "HLT"
    return HLT.new(memory)
  else
    return "Unknown instruction..."
  end
end
