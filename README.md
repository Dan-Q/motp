motp
====

This RubyGem implements the [Mobile-OTP standard](http://motp.sourceforge.net/) in Ruby,
allowing you to write Ruby (and Rails) powered servers and client implementations. This
enables you, for example, to implement strong two-factor authentication into your web
application, where your users use their mobile phones as a remote token.

Installation
------------

    gem install motp

Server Implementation
---------------------

For each user, come up with a secret and allow them to specify their PIN. Store both.
When they use your system, ask them for the One-Time Pad. They can get this by using
their mobile phone (which they've already configured with the secret) and entering their
PIN.

    require 'motp'
    
    Motp::check(secret, pin, otp)

Returns true if the otp is valid for the specified secret and PIN, false otherwise.

OTPs are based on the UTC clock and are valid (by default) for three minutes before and
three minutes after they were requested, in order to accomodate the time taken to type
in the OTP, and possible variations in the accuracy of the system clocks on the server
and the client (mobile phone) devices.

Optional parameters (appended to the end):

* :time => specifies the time for which the OTP must be valid; defaults to "now"
* :max_period => specifies the number of seconds of leeway, ahead and behind, during which an OTP is considered valid - defaults to 3 * 60 (3 minutes)

Client Implementation
---------------------

If you want to write a mobile-OTP client in Ruby, go ahead! The motp RubyGem supports
this too.

    require 'motp'
    
    Motp::otp(secret, pin)

Returns the OTP for the current time. As with the server implementation, you can pass an
optional :time parameter to specify the time for wich you want to generate, but you
shouldn't ever need to do this unless you *know* the device clock to be incorrect.

License
-------

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see http://www.gnu.org/licenses/.