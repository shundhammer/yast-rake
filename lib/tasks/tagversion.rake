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

#
# Rake task for creating a Git tag based on the package's version in the .spec file
#

require_relative "tagversion_task"

tag = Yast::TagVersionTask.new
tag.dry_run = true

namespace :tag do
  desc "Create a git tag based on the version in the .spec file"
  task :create do
    tag.create
  end

  desc "Show the tag that would be created"
  task :show do
    puts tag.name
  end
  
  desc "Show the version of the tag that would be created"
  task :showversion do
    puts tag.spec_version
  end

  desc "Show the git branch"
  task :showbranch do
    puts "branch: \"#{tag.git_branch}\""
  end
end
