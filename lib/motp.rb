require 'digest/md5'

module Motp
  def self.otp(secret, pin, options = {})
    options = {:time => Time::now}.merge(options)
    Digest::MD5::hexdigest("#{options[:time].utc.tv_sec.to_s[0...-1]}#{secret}#{pin}")[0,6]
  end

  def self.check(secret, pin, otp, options = {})
    options = {:time => Time::now, :max_period => (3 * 60)}.merge(options)
    lower_limit = options[:time] - options[:max_period]
    upper_limit = options[:time] + options[:max_period]

    while lower_limit < upper_limit do
      return true if otp == self.otp(secret, pin, :time => lower_limit)
      lower_limit += 1
    end

    false
  end
end
