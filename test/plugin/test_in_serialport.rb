require 'fluent/test'

class SerialPortInputTest < Test::Unit::TestCase
  def setup
    Fluent.Test.setup
  end

  CONFIG = %[]

  def create_driver(conf=CONFIG, tag='test')
    Fluent::Test::InputTestDriver.new(Fluent::SerialPortInput, tag).configure(conf)
  end

  def test_configure
    # d = %[
    #   type serial_input
    #   com_port serialport
    #   baud_rate 9600
    # ]
    # assert_equal 'serial_input', d.instance.type
    # assert_equal 'serialport', d.instance.com_port
    # assert_equal 9600, d.instance.baud_rate
  end
end
