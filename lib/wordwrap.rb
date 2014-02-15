class Wordwrap
  attr_reader :wrap_length

  def initialize(wrap_length)
    raise "Must provide a number" unless wrap_length.is_a?(Integer)
    @wrap_length = wrap_length
  end

  def wrap(text)
    raise "Not a text" unless text.is_a?(String)

    final = ''
    line = ''

    s = text.scan(%r{(\w{#{wrap_length}})|(\w+)(\s|$)}) do |match|
      match = match[0] || match[1]

      if line.length + match.length > wrap_length
        final << line << "\n"
        line = match
      else
        line << ' ' unless line.empty?
        line << match
      end
    end

    final << line
  end
end
