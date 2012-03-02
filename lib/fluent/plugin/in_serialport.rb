module Fluent
class SerialPortInput < Input
  Plugin.register_input('serial_input', self)
  config_param :data, :string, :default => ""
  config_param :delimiter, :string, :default => ','
  config_param :eol, :string, :default => $/
  config_param :com_port, :string
  config_param :baud_rate, :integer
  config_param :tag, :string, :default => "serial"

  def initialize
    require 'serialport'
    super
  end

  def configure(conf)
    super
  end

  def start
    @serial = SerialPort.new(@com_port, @baud_rate, 8, 1, SerialPort::NONE)

    @thread = Thread.new do
      ary = []
      loop do
        unless @serial.closed?
          begin
            d = @serial.readline(@eol)
            data = {}
            data = {:default => d}
            Engine.emit("#{@tag}.#{device}", Engine.now, data)
          rescue => e
            STDERR.puts caller(), e
            break
          end
        end
      end
    end
  end

  def shutdown
    @serial.close
    @thread.join
  end

  private
  def average(ary)
    ary.inject(:+).to_f/ary.size.to_f
  end

  def device
    File.basename(@com_port).gsub(/\./,"_")
  end
end
end
