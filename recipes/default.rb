#
# Cookbook Name:: zookeeper
# Recipe:: default
#
# Copyright 2015, Pradeep Aradhya.
#
# All rights reserved - Do Not Redistribute
#


case node[:os]
  when "linux"
	  Chef::Log.info("Its Linux")
	case node[:platform]
  		when "redhat", "centos", "suse", "amazon"
    			include_recipe "zookeeper::zookeeperInstall"
	end
  when "windows"
    	Chef::Log.info("Its Windows...Nothing to do")
  else
    	Chef::Log.info("Oops...couldn't understand #{node.os} yet!!!")
end