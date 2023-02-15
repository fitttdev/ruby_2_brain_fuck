# frozen_string_literal: true

class Ruby2BrainFuck
  def initialize(code)
    @code = code
    @output = ""
    @indent = 0
  end

  def compile
    @output += "++++++++[>++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-]>>.>---.+++++++..+++.>>.<-.<.+++.------.--------.>>+.>++.\n"
    parse
    @output
  end

  private

  def parse
    @code.each_line do |line|
      line.strip!

      case line
      when /^puts\s+(.+)/
        value = $1
        if value.start_with?('"') && value.end_with?('"')
          # output a string
          value = value[1..-2]
          value.each_char do |c|
            @output += ("+" * c.ord) + "."
          end
        else
          # output a variable
          @output += "[-]" # clear the current cell
          @indent += 1
          @output += ">"
          @indent.times { @output += "+" }
          @output += "."
          @indent.times { @output += "<" }
          @indent -= 1
        end
      when /^(\w+)\s*=\s*(.+)/
        # assign a value to a variable
        variable = $1
        value = $2

        if value.start_with?('"') && value.end_with?('"')
          # set a string
          value = value[1..-2]
          @output += "[-]" # clear the current cell
          value.each_char do |c|
            @indent += 1
            @output += ">"
            @indent.times { @output += "+" }
            @output += c.ord.to_s + "."
            @indent.times { @output += "<" }
            @indent -= 1
          end
          @output += "[-]" # clear the current cell
          @indent += 1
          @output += ">"
          @indent.times { @output += "+" }
          @output += "[-]"
          @indent.times { @output += "<" }
          @indent -= 1
        else
          # set a variable
          @output += "[-]" # clear the current cell
          @indent += 1
          @output += ">"
          @indent.times { @output += "+" }
          @output += value + "."
          @indent.times { @output += "<" }
          @indent -= 1
          @output += "[-]" # clear the current cell
          @indent += 1
          @output += ">"
          @indent.times { @output += "+" }
          @output += "[<]"
          @indent.times { @output += "<" }
          @indent -= 1
        end
      when /^#/
        # ignore comments
      else
        raise "Invalid Ruby code: #{line}"
      end
    end
  end
end
