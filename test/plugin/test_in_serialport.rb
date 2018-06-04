require 'test_helper'

class SerialPortInputTest < Test::Unit::TestCase
  def setup
    Fluent::Test.setup
  end

  CONFIG = %[
    @type serial_input
    com_port serialport
    baud_rate 9600
    tag serialport
    format /\d+,\d+,\d+(.\d+)/
  ]

  def create_driver(conf=CONFIG)
    Fluent::Test::Driver::Input.new(Fluent::Plugin::SerialPortInput).configure(conf)
  end

  def test_configure_test_driver
    d = create_driver
    assert_equal 'serialport', d.instance.com_port
    assert_equal 9600, d.instance.baud_rate
    assert_equal 'serialport', d.instance.tag
  end
end
