#--
# Yast rake
#
# Copyright (C) 2019 SUSE Linux LLC
#   This library is free software; you can redistribute it and/or modify
# it only under the terms of version 2.1 of the GNU Lesser General Public
# License as published by the Free Software Foundation.
#
#   This library is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
# details.
#
#   You should have received a copy of the GNU Lesser General Public
# License along with this library; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
#++

require "rake"
require "rake/tasklib"

module Yast
  #
  # Rake task for handling Git tags based on the package's version
  #
  class TagVersionTask < Rake::TaskLib

    attr_accessor :dry_run

    def initialize(dry_run = false)
      @dry_run = false
    end

    # Read the package version from the spec file
    def spec_version
      # use the first *.spec file found, assume all spec files
      # contain the same version
      File.readlines(Dir.glob("package/*.spec").first)
        .grep(/^\s*Version:\s*/).first.sub("Version:", "").strip
    end

    def git_branch
      branch = git("branch").grep(/^\* /).first.sub(/^\* /, "")
      return "detached" if branch =~ /HEAD detached/
      branch
    end

    def name
      branch = git_branch
      version = spec_version
      return version if branch == "master"
      branch + "-" + version
    end
    
    def create
      # FIXME: TO DO
    end

    private
      
    def git(subcmd)
      `/usr/bin/git #{subcmd}`.split("\n")
    end
  end
end
