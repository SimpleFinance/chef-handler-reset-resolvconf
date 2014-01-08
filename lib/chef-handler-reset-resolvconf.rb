# lib/chef-handler-reset-resolvconf.rb
#
# Author: Simple Finance <ops@simple.com>
# Copyright 2013 Simple Finance Technology Corporation.
# Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
# implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Copies old resolv.conf to /etc/resolv.conf in the event a Chef run fails

require 'rubygems'
require 'chef'
require 'chef/handler'

class ResetResolvconf < Chef::Handler
    attr_accessor :old, :dest

    def initialize(options = defaults)
      @old = options[:old]
      @dest = options[:dest]
    end

    # Explanation of parameters:
    #   * old: where to find the old resolv.conf
    #   * dest: where to copy the resolv.conf at the time of Chef failure
    def defaults
      return {
        old: '/var/cache/chef/resolv.conf.old',
        dest: '/var/cache/chef/resolv.conf.fail'
      }
    end

    def report
      if run_status.failed?
        if !File.exists?(@old)
          Chef::Log.error("Couldn't find a file at #{@old}, bailing!")
        else
          Chef::Log.info('Chef run failed! Reverting /etc/resolv.conf!')
          Chef::Log.debug("Copying current /etc/resolv.conf to #{@dest}")
          FileUtils.cp('/etc/resolv.conf', @dest)
          File.open('/etc/resolv.conf'){|f| f.puts(File.read(@old))}
        end
      end
    end

end

