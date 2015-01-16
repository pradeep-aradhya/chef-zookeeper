#
# Cookbook Name:: zookeeper
# Recipe:: zookeeperInstall
#
# Copyright 2015, Pradeep Aradhya.
#
# All rights reserved - Do Not Redistribute
#

zklnxclient = node[:zookeeper]

directory "#{zklnxclient[:loc]}" do
    mode "0644"
    owner zklnxclient[:user]
    group zklnxclient[:user]
    action :create
    recursive true
end

remote_file "#{Chef::Config[:file_cache_path]}/#{zklnxclient[:artifact]}.tar.gz" do
    source zklnxclient[:installer_url]
    owner zklnxclient[:user]  
    group zklnxclient[:user]
    mode "0655"
end

# extract ZooKeeper tar
execute "Extract ZooKeeper tar file" do
	user zklnxclient[:user] 
	group zklnxclient[:user] 
	command "tar xfz #{Chef::Config[:file_cache_path]}/#{zklnxclient[:artifact]}.tar.gz -C #{zklnxclient[:loc]}"
not_if %{ ls -A #{zklnxclient[:loc]}/#{zklnxclient[:artifact]} }
end

[zklnxclient[:dataDir], zklnxclient[:dataLogDir]].each do |dir|
    directory dir do
        mode "0644"
        owner zklnxclient[:user]
        group zklnxclient[:user]
        action :create
        recursive true
    end
end

#Create Config file for ZooKeeper
template "#{zklnxclient[:configLoc]}/#{zklnxclient[:cfg_file]}" do
	source "#{zklnxclient[:cfg_file]}.erb"
	owner zklnxclient[:user]  
	group zklnxclient[:user]
	variables(
	        :dataDir => zklnxclient[:dataDir],
	        :clientport => zklnxclient[:clientPort]
	        )
	mode 0644
end

#Create Myid file for ZooKeeper
template "#{zklnxclient[:dataDir]}/#{zklnxclient[:myid_file]}" do
	source "#{zklnxclient[:myid_file]}.erb"
	owner zklnxclient[:user]  
	group zklnxclient[:user]
	variables(
	        :myid => zklnxclient[:myid_val]
	        )
	mode 0644
end

#Start ZooKeeper server
execute  "Start ZooKeeper Server for ID #{zklnxclient[:myid]}" do
	user zklnxclient[:user] 
	group zklnxclient[:user] 
	cwd "#{zklnxclient[:home_dir]}/bin"
	command "#{zklnxclient[:home_dir]}/bin/zkServer.sh start"
not_if %{ps -ef | grep java | grep -v grep | grep #{zklnxclient[:version]}}
end

