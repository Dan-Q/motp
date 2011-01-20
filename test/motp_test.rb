require 'test/unit'
require 'lib/motp'

class MOTP_Test < Test::Unit::TestCase
  def setup
    @secret = 'secret12345'
    @pin = '1234'
    @valid_otp_regex = /^[\da-f]{6}$/
  end

  # def teardown
  # end

  def test_otp_matches_regex
    otp_now = MOTP::otp(@secret, @pin)
    assert(otp_now =~ @valid_otp_regex)
  end

  def test_now
    otp_now = MOTP::otp(@secret, @pin)
    assert(MOTP::check(@secret, @pin, otp_now))
  end

  def test_2min_ago
    otp = MOTP::otp(@secret, @pin, :time => Time::now - (2*60))
    assert(MOTP::check(@secret, @pin, otp))
  end

  def test_4min_ago_fails
    otp = MOTP::otp(@secret, @pin, :time => Time::now - (4*60))
    assert(!MOTP::check(@secret, @pin, otp))
  end

  def test_2min_ahead
    otp = MOTP::otp(@secret, @pin, :time => Time::now + (2*60))
    assert(MOTP::check(@secret, @pin, otp))
  end

  def test_4min_ahead_fails
    otp = MOTP::otp(@secret, @pin, :time => Time::now + (4*60))
    assert(!MOTP::check(@secret, @pin, otp))
  end

  def test_various_random_otps_fail
    ['', '123456', 'abcdef', 'alpha' 'letmein!'].each do |otp|
      assert(!MOTP::check(@secret, @pin, otp))
    end
  end

  def test_specific_known_good_case
    time = Time::utc(2011, 1, 20, 14, 28, 23)
    secret, pin = 'abcd1234', '1234'
    valid_otp = '6f8af8'
    invalid_otp = '5d60af'
    assert(MOTP::check(secret, pin, valid_otp, :time => time))
    assert(!MOTP::check(secret, pin, invalid_otp, :time => time))
  end
end
