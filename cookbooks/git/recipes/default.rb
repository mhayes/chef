#
# Cookbook Name:: git
# Recipe:: default
#
# Copyright 2008-2009, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

case node[:platform]
when "debian", "ubuntu", "mac_os_x"
  package "git-core"
when "redhat", "centos"
  remote_file "/tmp/git-1.7.6.tar.gz" do
    source "http://kernel.org/pub/software/scm/git/git-1.7.6.tar.gz"
  end
  
  execute "tar -xzf git-1.7.6.tar.gz" do
    cwd "/tmp"
    creates "/tmp/git-1.7.6"
  end
  
  execute "./configure --prefix=/usr/local" do
    cwd "/tmp/git-1.7.6"
    creates "/usr/local/bin/git"
  end
  
  execute "make install" do
    cwd "/tmp/git-1.7.6"
    creates "/usr/local/bin/git"
  end
  
else
  package "git"
end
