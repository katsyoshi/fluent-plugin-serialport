require 'fluent/test'

class SerialPortInputTest < Test::Unit::TestCase
  def setup
    Fluent::Test.setup
    require 'fluent/plugin/in_serialport'
  end

  CONFIG = %[
    type serial_input
    com_port serialport
    baud_rate 9600
    tag serialport
    format /\d+,\d+,\d+(.\d+)/
  ]

  def create_driver(conf=CONFIG)
    Fluent::Test::InputTestDriver.new(Fluent::SerialPortInput).configure(conf)
  end

  def test_configure_test_driver
    d = create_driver
    assert_equal 'serialport', d.instance.com_port
    assert_equal 9600, d.instance.baud_rate
    assert_equal 'serialport', d.instance.tag
  end

  def test_configure_class
    test = Fluent::SerialPortInput.new
    test.configure(CONFIG)
  end

  def test_device
    test = Fluent::SerialPortInput.new
    test.configure(CONFIG)
    test.__send__(:device)
  end
end
