require 'digest/md5'

module Motp
  def self.otp(secret, pin, options = {})
    options = {:time => Time::now}.merge(options)
    Digest::MD5::hexdigest("#{options[:time].utc.tv_sec.to_s[0...-1]}#{secret}#{pin}")[0,6]
  end

  def self.check(secret, pin, otp, options = {})
    options = {:time => Time::now, :max_period => (3 * 60)}.merge(options)
    range = ((options[:time] - options[:max_period])..(options[:time] + options[:max_period]))
    return range.any?{|time| otp == self.otp(secret, pin, :time => time)}
  end
end
