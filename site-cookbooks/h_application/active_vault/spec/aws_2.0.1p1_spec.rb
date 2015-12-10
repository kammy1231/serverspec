if property[:environment][:set] == "aws" && property[:vault][:version] == "2.0.1p1"
vault = property[:vault]
puts "Run Recipe active_vault"
###
describe 'vault should be install' do
  describe file('/usr/local/active/vault') do
    it { should exist }
    it { should be_directory }
  end
end

describe 'vault version test' do
  describe file('/usr/local/active/vault/package.info') do
    it { should contain "version:#{vault[:version]}$" }
  end
end

describe file('/etc/ar_pack.conf') do
  it { should be_symlink }
  it { should be_linked_to '/usr/local/active/vault/etc/ar_pack.conf' }
  it { should be_mode 777 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file('/etc/ar.conf') do
  it { should be_symlink }
  it { should be_linked_to '/usr/local/active/vault/etc/ar.conf' }
  it { should be_mode 777 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe 'vault process/service test' do
  describe port(25) do
    it { should be_listening.with('tcp') }
  end
  describe port(10345) do
    it { should be_listening.with('tcp') }
  end
  describe port(10346) do
    it { should be_listening.with('tcp') }
  end
  describe port(10347) do
    it { should be_listening.with('tcp') }
  end
  describe service('xinetd') do
    it { should be_enabled }
    it { should be_running }
  end
  describe command('chkconfig | grep areceiver | grep on') do
    its(:exit_status) { should eq 0 }
  end
  describe command('chkconfig | grep armanager | grep on') do
    its(:exit_status) { should eq 0 }
  end
  describe command('chkconfig | grep arstatus | grep on') do
    its(:exit_status) { should eq 0 }
  end
  describe service('ar_dbproc') do
    it { should be_enabled }
  end
  describe service('ar_qmaster') do
    it { should be_enabled }
  end
  describe service('ar_pack') do
    it { should be_enabled }
  end
  describe service('master') do
    it { should be_running }
  end

  describe process("master") do
    it { should be_running }
  end
  describe process('arqmaster archive')do
    it { should be_running }
  end
  describe process("arqmaster diskmon") do
    it { should be_running }
  end
  describe process("arqmaster") do
    it { should be_running }
  end
  describe process("ardbproc -d") do
    it { should be_running }
  end
  describe process("ardbproc -s") do
    it { should be_running }
  end
  describe process("arpack -D") do
    it { should be_running }
  end
end

describe 'vault file/directory test' do
  describe file('/usr/local/active/vault/ar') do
    it { should be_directory }
  end
  describe file('/usr/local/active/vault/db') do
    it { should be_directory }
  end
  describe file('/usr/local/active/vault/setup') do
    it { should be_directory }
  end
  describe file('/usr/local/active/vault/web') do
    it { should be_directory }
  end
  describe file('/usr/local/active/vault/common') do
    it { should be_directory }
  end
  describe file('/usr/local/active/vault/data') do
    it { should be_directory }
  end
  describe file('/usr/local/active/vault/etc') do
    it { should be_directory }
  end
  describe file('/usr/local/active/vault/misc') do
    it { should be_directory }
  end
  describe file('/usr/local/active/vault/var') do
    it { should be_directory }
  end
  describe file('/usr/local/active/vault/ar/lib/libarchive.so.1.0') do
    it { should be_executable }
  end
  describe file('/usr/local/active/vault/db/pgsql') do
    it { should be_symlink }
    it { should be_linked_to '/usr/local/active/vault/db/pgsql_90' }
  end
  describe file('/usr/local/active/vault/etc/ar.conf') do
    it { should be_file }
  end
  describe file('/usr/local/active/vault/etc/ar_pack.conf') do
    it { should be_file }
  end
  describe file('/usr/local/active/vault/etc/init.d/ar_dbproc') do
    it { should be_executable }
  end
  describe file('/usr/local/active/vault/etc/init.d/ar_pack') do
    it { should be_executable }
  end
  describe file('/usr/local/active/vault/etc/init.d/ar_qmaster') do
    it { should be_executable }
  end
  describe file('/usr/local/active/vault/etc/xinetd.d/areceiver') do
    it { should be_file }
  end
  describe file('/usr/local/active/vault/etc/xinetd.d/armanager') do
    it { should be_file }
  end
  describe file('/usr/local/active/vault/etc/xinetd.d/arstatus') do
    it { should be_file }
  end
  describe command('ls /usr/local/active/vault/web/webapps/htdocs') do
    its(:stdout) { should contain('admin.igm') }
    its(:stdout) { should contain('admin.image.igm') }
    its(:stdout) { should contain('admin.igm') }
    its(:stdout) { should contain('api.igm') }
    its(:stdout) { should contain('archive') }
    its(:stdout) { should contain('common.css') }
    its(:stdout) { should contain('search.igm') }
  end
  describe file('/usr/local/active/vault/data/cache') do
    it { should be_directory }
  end
  describe file('/usr/local/active/vault/data/db/archive_sp1') do
    it { should be_directory }
  end
  describe file('/usr/local/active/vault/data/db/common') do
    it { should be_directory }
  end
  describe file('/usr/local/active/vault/data/index') do
    it { should be_directory }
  end
  describe file('/usr/local/active/vault/data/mail/pack') do
    it { should be_directory }
  end
  describe file('/usr/local/active/vault/data/mail/pack/lock_plan_util') do
    it { should be_file }
  end
  describe file('/usr/local/active/vault/data/mail/pack/plan.db') do
    it { should be_file }
  end
  describe file('/usr/local/active/vault/data/mail/pack/queue.db') do
    it { should be_file }
  end
  describe file('/usr/local/active/vault/data/s3') do
    it { should be_directory }
  end
  describe file('/usr/local/active/vault/var/arqueue') do
    it { should be_directory }
  end
  describe file('/usr/local/active/vault/var/cache/db') do
    it { should be_directory }
  end
  describe file('/usr/local/active/vault/var/logs') do
    it { should be_linked_to '/var/log/vault' }
  end
  describe file('/usr/local/active/vault/var/tmp/mailview') do
    it { should be_directory }
  end
  describe file('/usr/local/active/common/web/conf/httpd/httpd_av_prefix.conf') do
    it { should be_file }
  end
  describe file('/usr/local/active/common/web/conf/httpd/httpd_av_virtual.conf') do
    it { should be_file }
  end
end

describe 'vault ar.conf test' do
  ret = Specinfra::Runner.run_command("grep s3_cache_dir /etc/ar.conf | grep %ROOTDIR%")
  describe file('/etc/ar.conf') do
     its(:content) { should match /save_search_results_by_server = "yes"/ }
     its(:content) { should match /limit_max_day = "#{vault[:limit_max_day]}"/ }
     its(:content) { should match /limit_max_day_max = "#{vault[:limit_max_day_max]}"/ }
     its(:content) { should match /pack_mode_use = "yes"/ }
     its(:content) { should match /use_cache = "yes"/ }
     its(:content) { should match %!cache_limit_max = "#{vault[:cache_limit_max]}"! }
     its(:content) { should match %!pack_conf = "/etc/ar_pack.conf"! }
     its(:content) { should match %!arpack_opt = "-M -t -r"! }
     its(:content) { should match %!client_id = "#{property[:server][:ctid]}"! }
     its(:content) { should match %!data_encrypt_passwd = "#{property[:server][:ctid]}"! }
     its(:content) { should match %!session_expire = "30"! }
     its(:content) { should match %!proxy = "10.128.33.4"! }
     its(:content) { should match %!report_server = "10.0.3.1"! }
     its(:content) { should match %!relay_host = "10.0.3.1"! }
     its(:content) { should match %!ss_maintenance = "yes"! }
     its(:content) { should match %!master_host = "#{vault[:master_host]}"! }
     its(:content) { should match %!host = "#{property[:server][:local_ipv4]}"! }
     if ret.exit_status == 0
        its(:content) { should match %!mail_dir = "%ROOTDIR%/data/mail"! }
        its(:content) { should match %!pack_index_dir = "%ROOTDIR%/data/index"! }
        its(:content) { should match %!cache_dir = "%ROOTDIR%/data/cache"! }
        its(:content) { should match %!s3_cache_dir = "%ROOTDIR%/data/s3"! }
     end
     if ret.exit_status == 1
        its(:content) { should match %!mail_dir = "/usr/local/active/vault/data/mail"! }
        its(:content) { should match %!pack_index_dir = "/usr/local/active/vault/data/index"! }
        its(:content) { should match %!cache_dir = "/usr/local/active/vault/data/cache"! }
        its(:content) { should match %!s3_cache_dir = "/usr/local/active/vault/data/s3"! }
     end
  end
end

describe 'vault ar_pack.conf' do
  describe file('/etc/ar_pack.conf') do
    its(:content) { should match %![00000000]! }
    its(:content) { should match %!pack_type = "s3"! }
    its(:content) { should match %!mail_dir = "/usr/local/active/vault/data/mail"! }
    its(:content) { should match %!remote_info = "s3://av-01-#{property[:environment][:region]}"! }
  end
end

describe  'vault cron' do
  describe cron do
    it { should have_entry '4 * * * * /ss/bin/queue_check_av4.sh > /dev/null 2> /dev/null' }
    it { should have_entry '15 9 * * * /ss/bin/av/zero_mail_check.sh > /dev/null 2> /dev/null' }
  end
  describe command('crontab -l | grep vault') do
    its(:stdout) { should match %!/usr/local/active/vault/ar/bin/arcron log_delete! }
    its(:stdout) { should match %!/usr/local/active/vault/ar/bin/archiver-cron-pack.sh! }
    its(:stdout) { should match %!/usr/local/active/vault/ar/bin/pack_upload! }
    its(:stdout) { should match %!/usr/local/active/vault/ar/bin/flush_queue.sh! }
    its(:stdout) { should match %!/usr/local/active/vault/ar/bin/arcron mail_count! }
    its(:stdout) { should match %!/usr/local/active/vault/ar/bin/php /usr/local/active/vault/ar/bin/get_status.php! }
    its(:stdout) { should match %!/usr/local/active/vault/ar/bin/archiver-cron-db.sh! }
    its(:stdout) { should match %!/usr/local/active/vault/ar/bin/arcron search_result_delete! }
  end
end
###
end
