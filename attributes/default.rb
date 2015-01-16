#
# Cookbook Name:: zookeeper
# Attribute:: default
#
# Copyright 2015, Pradeep Aradhya.
#
# All rights reserved - Do Not Redistribute
#
default[:zookeeper][:user] = "root"
default[:zookeeper][:version] = "3.4.6"
default[:zookeeper][:artifact] ="zookeeper-#{node[:zookeeper][:version]}"
default[:zookeeper][:artifactName] ="#{node[:zookeeper][:artifact]}.tar.gz"
default[:zookeeper][:installer_url] = "http://www.apache.org/dist/zookeeper/#{node[:zookeeper][:artifact]}/#{node[:zookeeper][:artifactName]}"
default[:zookeeper][:loc] ="/opt"
default[:zookeeper][:home_dir] ="#{node[:zookeeper][:loc]}/#{node[:zookeeper][:artifact]}"
default[:zookeeper][:dataDir] ="#{node[:zookeeper][:home_dir]}/data"
default[:zookeeper][:bin] ="#{node[:zookeeper][:home_dir]}/bin"
default[:zookeeper][:configLoc] ="#{node[:zookeeper][:home_dir]}/conf"
default[:zookeeper][:dataLogDir] ="#{node[:zookeeper][:home_dir]}/logs"
default[:zookeeper][:clientPort] = "2181"
default[:zookeeper][:myid_file] = "myid"
default[:zookeeper][:myid_val] = "1"
default[:zookeeper][:cfg_file] ="zoo.cfg"