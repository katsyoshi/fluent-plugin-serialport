module Fluent
class SerialPortInput < Input
  Plugin.register_input('serial_input', self)
  config_param :data, :string, :default => ""
  config_param :delimiter, :string, :default => ','
  config_param :eol, :string, :default => $/
  config_param :com_port, :string
  config_param :baud_rate, :integer

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
            if @data.empty?
              data = {:default => d}
            else
              d = d.split(@delimiter)
              @data.split(",").each do |x|
                dd = d.shift
                if dd =~ /^(0x)|(\d+)/
                  if dd =~ /\./
                    dd = dd.strip.to_f
                  else
                    dd = dd.strip.to_i
                  end
                end
                data[x.strip.to_sym] = dd
              end
            end
            Engine.emit("serial.#{device}", Engine.now, data)
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
