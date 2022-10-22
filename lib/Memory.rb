class Memory
  attr_accessor :internalArray, :registerA, :registerB, :pc, :mc, :zeroResultBit, :overflowBit, :symbolAddresses, :prevhc, :curhc, :loopWarn

  def initialize
    @internalArray = Array.new(256, 0) #initialize memory with zeroes
    @registerA = @registerB = @pc = @zeroResultBit = @overflowBit = @prevhc = @curhc = 0 #set bits to 0
    @mc = 128 #where non-sourcecode memory begins
    @symbolAddresses = {} #hash of symbols to their addresses
  end

  def [](ndx) #Brackets operator - Allows memory to be treated like normal array for [i]
    internalArray[ndx]
  end

  def []=(ndx, contents) #Brackets equals operator - Allows memory to be treated like normal array for [i]=x
    internalArray[ndx] = contents
  end

  def executeSingle #executes just the line pc is at
    @internalArray[@pc].execute
    @curhc += 1
    if (@prevhc + 10000 == @curhc) #warn user if 10k lines have passed without ending
      @loopWarn = true
    end
  end

  def reachedEnd? #check if pc is beyond its bounds, if so it has reached its end
    if pc >= 128 || pc < 0
      true
    else
      false
    end
  end

  def to_s #Allow memory to be printed in a custom manner
    returnString = _title("instructions") #instructions header
    @internalArray.each_with_index do |contents, i|
      if i == 128
        returnString += _title("Memory") #memory header
      end
      if i != pc
        returnString += "#{"├   #{i}. #{contents}".ljust(52)}\n" unless (i >= @mc) || (i < 128 && contents == 0)
      else
        returnString += "#{"├>  #{i}. #{contents}".ljust(52)}<- pc is currently here\n" #print arrows where pc is to make it clear
      end
    end
    if @mc <= 128 #if memory has not moved from 128 then nothing has been added
      returnString += "└#{"Memory is currently empty.".center(50)}\n"
    end
    returnString += _title("Bits & Regs") # Bits & Regs header
    returnString += "├#{"zeroResultBit =".ljust(16)}#{@zeroResultBit.to_s.rjust(7)}#{"".rjust(3)}├#{"registerA =".ljust(16)}#{@registerA.to_s.rjust(7)}\n"
    returnString += "└#{"overflowBit =".ljust(16)}#{@overflowBit.to_s.rjust(7)}#{"".rjust(3)}└#{"registerB =".ljust(16)}#{@registerB.to_s.rjust(7)}\n"
    returnString += "#{_title("Symbol Table")} #{@symbolAddresses}" #DEBUGGING: prints symbol table as its filled
  end
end

def _title(title) #Takes a header and makes it stand out with dashes
  "┌#{title.center(50, "-")}┐\n"
end
