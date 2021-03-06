module TwitterStreaming
  class SocketClient

    def initialize io
      @io = io
      puts "SocketClient initialized with trend: #{$trend}"
      #@broker = ClientStreamBroker.new 
    end

    def write object, options = {}
      options.each do |k,v|
        @io.write "#{k}: #{v}\n"
      end
      @io.write "data: #{object}\n\n"
    end

    def close
      #@broker.client_streams.delete(@stream) if @broker.exists?
      @io.close
    end

  end
end
