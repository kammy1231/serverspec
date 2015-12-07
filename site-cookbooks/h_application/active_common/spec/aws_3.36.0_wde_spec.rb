if property[:environment][:set] == "aws" && property[:common][:version] == "3.36.0"
common = property[:common]
puts "Run Recipe active_common"
###
describe 'common should be install' do
  describe file('/usr/local/active/common') do
    it { should exist }
    it { should be_directory }
  end
end

describe 'vault version test' do
  describe file('/usr/local/active/common/package.info') do
    it { should contain 'version:3.36.0' }
  end
end

describe file('/usr/local/active/common/etc/ac.conf') do
  it { should exist }
  it { should be_file }
end

describe 'common process/service test' do
  describe process("ac_manager") do
    it { should be_enabled }
    it { should be_running }
  end
  describe process("ac_manager -D") do
    it { should be_running }
  end

  if common[:db] == "on"
    describe service('ac_dbpgsql') do
      it { should be_enabled }
      it { should be_running }
    end
    describe process("postgres -D") do
      it { should be_running }
    end
    describe port(5432) do
    it { should be_listening.with('tcp') }
    end
  end

  if common[:web] == "on"
    describe service('ac_httpd') do
      it { should be_enabled }
      it { should be_running }
    end
    describe process("httpd") do
      it { should be_running }
      its(:args) { should match %!-f /usr/local/active/common/web/conf/httpd/httpd.conf -k start! }
    end
    describe port(common[:port]) do
      it { should be_listening.with('tcp') }
    end
  end
end

describe 'common file/directory test' do
  describe file('/usr/local/active/common/bin') do
    it { should be_directory }
  end
  describe file('/usr/local/active/common/etc') do
    it { should be_directory }
  end
  describe file('/usr/local/active/common/data') do
    it { should be_directory }
  end
  describe file('/usr/local/active/common/lib') do
    it { should be_directory }
  end
  describe file('/usr/local/active/common/misc') do
    it { should be_directory }
  end
  describe file('/usr/local/active/common/setup') do
    it { should be_directory }
  end
  describe file('/usr/local/active/common/support') do
    it { should be_directory }
  end
  describe file('/usr/local/active/common/var') do
    it { should be_directory }
  end
  describe file('/usr/local/active/common/db') do
    it { should be_directory }
  end
  describe file('/usr/local/active/common/manager') do
    it { should be_directory }
  end
  describe file('/usr/local/active/common/share') do
    it { should be_directory }
  end
  describe file('/usr/local/active/common/web') do
    it { should be_directory }
  end
  describe file('/usr/local/active/common/config') do
    it { should be_file }
  end
  describe file('/usr/local/active/common/setup.status') do
    it { should be_file }
  end
  describe file('/usr/local/active/common/setup.sh') do
    it { should be_executable }
  end
  describe file('/usr/local/active/common/bin/python2.7') do
    it { should be_file }
    it { should be_executable }
  end
  describe file('/usr/local/active/common/data/session') do
    it { should be_directory }
    it { should be_mode 777 }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
  end
  describe file('/usr/local/active/common/etc/tw_remote.key') do
    it { should be_file }
    its(:content) { should match /KEY/ }
    it { should be_mode 600 }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
  end
  describe file('/usr/local/active/common/lib/python2.7') do
    it { should be_directory }
  end
  describe file('/usr/local/active/common/misc/ac_dbpgsql.init') do
    it { should be_file }
    it { should be_executable }
  end
  describe file('/usr/local/active/common/misc/ac_httpd.init') do
    it { should be_file }
    it { should be_executable }
  end
  describe file('/usr/local/active/common/misc/ac_manager.init') do
    it { should be_file }
    it { should be_executable }
  end
  describe file('/usr/local/active/common/var/logs') do
    it { should be_symlink }
    it { should be_linked_to '/var/log/common' }
  end
  describe file('/usr/local/active/common/db/conf/pg_hba.conf') do
    it { should be_file }
    its(:content) { should match /#{property[:server][:local_ipv4]}/ }
    it { should be_mode 600 }
    it { should be_owned_by 'postgres' }
    it { should be_grouped_into 'postgres' }
  end
  describe file('/usr/local/active/common/db/conf/postgresql.conf') do
    it { should be_file }
    it { should be_file }
    its(:content) { should match %!/usr/local/active/common/db/conf/pg_hba.conf! }
    it { should be_mode 600 }
    it { should be_owned_by 'postgres' }
    it { should be_grouped_into 'postgres' }
  end
  describe file('/usr/local/active/common/manager/bin/ac_manager') do
  it { should be_file }
  it { should be_executable }
  end
  describe file('/usr/local/active/common/share/snmp/mibs') do
    it { should be_directory }
  end
  describe file('/usr/local/active/common/web/apache/bin/apachectl') do
    it { should be_executable }
  end
  describe file('/usr/local/active/common/web/conf/php.ini') do
    it { should be_file }
    it { should be_mode 644 }
  end
  describe file('/usr/local/active/common/web/conf/httpd/httpd.conf') do
    it { should be_file }
  end
  describe file('/usr/local/active/common/web/conf/httpd/httpd_ssl.conf') do
    it { should be_file }
  end
  describe file('/usr/local/active/common/web/webapps/htdocs/favicon.ico') do
    it { should be_file }
    it { should be_mode 644 }
  end
  describe file('/usr/local/active/common/web/webapps/htdocs/index.html') do
    it { should be_file }
    it { should be_mode 644 }
  end
end

###
end
