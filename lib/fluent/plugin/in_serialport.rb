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
    @serial = SerialPort.new(@com_port, @baud_rate, 8, 1, SerialPort::NONE)
  end

  def configure(conf)
    super
  end

  def start
    @thread = Thread.new(&method(run))
  end

  def shutdown
    @serial.close
    @thread.join
  end

  def run
    loop do
      unless @serial.closed?
        begin
          data = {:default => @serial.readline(@eol)}
          Engine.emit("#{@tag}.#{device}", Engine.now, data)
        rescue => e
          STDERR.puts caller(), e
          break
        end
      end
    end
  end

  private
  def device
    File.basename(@com_port).gsub(/\./,"_")
  end

end
end
