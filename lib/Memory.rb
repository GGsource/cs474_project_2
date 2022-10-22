class Memory
  attr_accessor :internalArray, :registerA, :registerB, :pc, :mc, :zeroResultBit, :overflowBit, :symbolAddresses

  def initialize
    @internalArray = Array.new(256)
    @registerA = @registerB = @pc = @zeroResultBit = @overflowBit = 0
    @mc = 128
    @symbolAddresses = {}
  end

  def [](ndx)
    internalArray[ndx]
  end

  def []=(ndx, contents)
    internalArray[ndx] = contents
  end

  def executeSingle
    @internalArray[@pc].execute
  end

  def reachedEnd?
    if pc >= 128 || pc < 0
      true
    else
      false
    end
  end

  def to_s
    isMemoryEmpty = true
    returnString = _title("instructions")
    @internalArray.each_with_index do |contents, i|
      if i == 128
        returnString += _title("Memory")
      end
      if i > 127 && contents != nil
        isMemoryEmpty = false
      end
      if i != pc
        returnString += "#{"├   #{i}. #{contents}".ljust(52)}\n" unless contents.nil?
      else
        returnString += "#{">>  #{i}. #{contents}".ljust(52)}<- pc is currently here\n"
      end
    end
    if isMemoryEmpty
      returnString += "└   Memory is currently empty.\n"
    end
    returnString += "
#{_title("Regs & Bits")}
├   registerA =     #{@registerA} ├   zeroResultBit = #{@zeroResultBit}
└   registerB =     #{@registerB} ├   overflowBit =   #{@overflowBit}"
    returnString += "\n"
  end
end

def _title(title)
  "┌#{title.center(50, "-")}┐\n"
end
