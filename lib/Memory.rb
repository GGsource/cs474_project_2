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
    @mc += 1; @pc += 1
  end

  def to_s
    isMemoryEmpty = true
    returnString = "┌---------<####Instructions####>----------\n"
    @internalArray.each_with_index do |contents, i|
      if i == 128
        returnString += "┌---------<####Memory####>----------\n"
      end
      if i > 128 && contents != nil
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
    returnString += "" "
    registerA =     #{@registerA}
    registerB =     #{@registerB}
    zeroResultBit = #{@zeroResultBit} 
    overflowBit =   #{@overflowBit}
    " ""
    returnString += "\n"
  end
end
