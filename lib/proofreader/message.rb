class Proofreader
  class Message
    def initialize(raw_message)
      @message = format_message(raw_message)
    end

    private

    def format_message(raw_message)
      raw_message.text.gsub(/\s+/, ' ').gsub(/\"/, '')
    end
  end
end

# TODO: It seems like message just concatenates suggestions. Verify that this is true.
# TODO: For the future, how many other substitutions will we need to make within @message to format it properly?