require "serverspec"
require "pathname"

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

RSpec.configure do |c|
	c.os = backend.check_os
end