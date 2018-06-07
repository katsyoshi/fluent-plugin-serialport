require 'test_helper'

class SerialPortInputTest < Test::Unit::TestCase
  def setup
    Fluent::Test.setup
    @now = event_time("2018-06-04 11:57:00 +0900")
    Timecop.freeze(Time.parse("2018-06-04 11:57:00 +0900"))
  end

  def teardown
    Timecop.return
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

  sub_test_case("serial port") do
    test "one line" do
      mock(SerialPort).new("serialport", 9600, 8, 1, SerialPort::NONE) do
        s = mock(Object.new)
        n = 0
        s.closed?.times(2) do
          n += 1
          n > 1
        end
        s.readline($/) { "This is a test\n" }
        s.close
        s
      end
      d = create_driver
      d.run(expect_emits: 1)
      events = d.events
      assert_equal(1, events.size)
      assert_equal(["serialport", @now, { "serialport" => "This is a test\n" }], events.first)
    end

    test "3 lines" do
      mock(SerialPort).new("serialport", 9600, 8, 1, SerialPort::NONE) do
        s = mock(Object.new)
        n = 0
        s.closed?.times(4) do
          n += 1
          n > 3
        end
        line = 0
        s.readline($/).times(3) do
          line += 1
          "This is a test #{line}\n"
        end
        s.close
        s
      end
      d = create_driver
      d.run(expect_emits: 3)
      events = d.events
      assert_equal(3, events.size)
      expected = [
        ["serialport", @now, { "serialport" => "This is a test 1\n" }],
        ["serialport", @now, { "serialport" => "This is a test 2\n" }],
        ["serialport", @now, { "serialport" => "This is a test 3\n" }],
      ]
      assert_equal(expected, events)
    end

    test "raise and break" do
      mock(SerialPort).new("serialport", 9600, 8, 1, SerialPort::NONE) do
        s = mock(Object.new)
        s.closed?.at_least(2) { false }
        n = 0
        s.readline($/).times(2) do
          if n == 0
            n += 1
            "This is a test\n"
          else
            raise
          end
        end
        s.close
        s
      end
      d = create_driver
      d.run(expect_emits: 1)
      events = d.events
      assert_equal(1, events.size)
      assert_equal(["serialport", @now, { "serialport" => "This is a test\n" }], events.first)
    end
  end
end
