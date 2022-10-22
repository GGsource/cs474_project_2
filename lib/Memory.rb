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
    # FIXME: Make sourcecode check stop at 127
    # FIXME: Make memory check stop at 255
  end

  def to_s
    isMemoryEmpty = true
    returnString = "┌--------------<Instructions>--------------\n"
    @internalArray.each_with_index do |contents, i|
      if i == 128
        returnString += "┌--------------<Memory>--------------\n"
      end
      if i > 127 && contents != nil
        isMemoryEmpty = false
      end
      if i != pc
        returnString += "├   #{i}. #{contents}\n" unless contents.nil?
      else
        returnString += ">>  #{i}. #{contents}          <- pc is currently here\n"
      end
    end
    if isMemoryEmpty
      returnString += "└   Memory is currently empty.\n"
    end
    returnString += "" "┌--------------<Regs&Bits>--------------
├   registerA =     #{@registerA} ├   zeroResultBit = #{@zeroResultBit}
└   registerB =     #{@registerB} ├   overflowBit =   #{@overflowBit}
    " ""
    returnString += "\n"
  end
end
