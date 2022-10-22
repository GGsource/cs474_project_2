class Memory
  attr_accessor :internalArray, :registerA, :registerB, :pc, :mc, :zeroResultBit, :overflowBit, :symbolAddresses, :prevhc, :curhc, :loopWarn

  def initialize
    @internalArray = Array.new(256, 0)
    @registerA = @registerB = @pc = @zeroResultBit = @overflowBit = @prevhc = @curhc = 0
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
    @curhc += 1
    if (@prevhc + 10000 == @curhc)
      @loopWarn = true
    end
  end

  def reachedEnd?
    if pc >= 128 || pc < 0
      true
    else
      false
    end
  end

  def to_s
    returnString = _title("instructions")
    @internalArray.each_with_index do |contents, i|
      if i == 128
        returnString += _title("Memory")
      end
      if i != pc
        returnString += "#{"├   #{i}. #{contents}".ljust(52)}\n" unless (i >= @mc) || (i < 128 && contents == 0)
      else
        returnString += "#{"├>  #{i}. #{contents}".ljust(52)}<- pc is currently here\n"
      end
    end
    if @mc <= 128
      returnString += "└#{"Memory is currently empty.".center(50)}\n"
    end
    returnString += _title("Bits & Regs")
    returnString += "├#{"zeroResultBit =".ljust(16)}#{@zeroResultBit.to_s.rjust(7)}#{"".rjust(3)}├#{"registerA =".ljust(16)}#{@registerA.to_s.rjust(7)}\n"
    returnString += "└#{"overflowBit =".ljust(16)}#{@overflowBit.to_s.rjust(7)}#{"".rjust(3)}└#{"registerB =".ljust(16)}#{@registerB.to_s.rjust(7)}\n"
    returnString += "#{_title("Symbol Table")} #{@symbolAddresses}" #DEBUGGING: prints symbol table as its filled
  end
end

def _title(title)
  "┌#{title.center(50, "-")}┐\n"
end
