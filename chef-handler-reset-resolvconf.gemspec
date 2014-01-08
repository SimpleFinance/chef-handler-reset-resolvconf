Gem::Specification.new do |s|
  s.name = 'chef-handler-reset-resolvconf'
  s.version = '0.1.1'
  s.author = 'Simple Finance'
  s.email = 'ops@simple.com'
  s.homepage = 'http://github.com/SimpleFinance/chef-handler-reset-resolvconf'
  s.summary = 'Ensures resolv.conf is reset if the Chef run fails'
  s.description = 'Resets resolv.conf'
  s.files = ::Dir.glob('**/*')
  s.require_paths = ['lib']
end

