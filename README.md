# ResetResolvconf handler
If the Chef run fails, it will reset your resolv.conf to its previous value.
Note that this handler does not actually copy /etc/resolv.conf from the
beginning of the Chef run; you will have to do that yourself.

## Usage
Either just pull the handler file into a files directory of one of your
cookbooks, or download as a Rubygem and source it that way.

```ruby
# Option 1
cookbook_file "#{node[:chef_handler][:handler_path]}/chef-handler-reset-resolvconf.rb" do
  source 'chef-handler-reset-resolvconf.rb'
  mode 00600
end

chef_handler 'ResetResolvconf' do
  source "#{node[:chef_handler][:handler_path]}/chef-handler-reset-resolvconf.rb"
  action :enable
end

# Option 2
chef_gem 'chef-handler-reset-resolvconf' do
  action :install
end

chef_handler 'ResetResolvconf' do
  source ::File.join(Gem::Specification
                      .find_by_name('chef-handler-reset-resolvconf')
                      .lib_dirs_glob,
                      'chef-handler-reset-resolvconf.rb')
  action :enable
end
```

## Questions?
Hop on ##simple on Freenode with any questions or concerns.

## Author/License
Simple Finance \<ops@simple.com\>
Apache License, Version 2.0
