require './lib/bitmap_operation_executor'

class BitmapEditor
  def run
    @running = true
    puts 'type ? for help'
    while @running
      print '> '

      input = gets.chomp.split(' ')

      case input.first
      when '?'
        show_help
      when 'X'
        exit_console
      else
        unless bitmap_operation_executor.call(input)
          puts 'unrecognised command :('
        end
      end
    end
  end

  private

  def bitmap_operation_executor
    @bitmap_operation_executor ||= BitmapOperationExecutor.new
  end

  def exit_console
    puts 'goodbye!'
    @running = false
  end

  def show_help
    help_text = <<~HELP_TEXT
        ? - Help
        I M N - Create a new M x N image with all pixels coloured white (O).
        C - Clears the table, setting all pixels to white (O).
        L X Y C - Colours the pixel (X,Y) with colour C.
        V X Y1 Y2 C - Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).
        H X1 X2 Y C - Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).
        S - Show the contents of the current image
        X - Terminate the session
        HELP_TEXT

    puts help_text
  end
end
