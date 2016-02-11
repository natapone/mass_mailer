use inc::Module::Install;

name 'Sticky';
perl_version '5.16';

all_from 'lib/mass/mailer.pm';

test_requires 'Data::Dumper';
test_requires 'DBD::SQLite';

requires 'Moose';
requires 'Config::JFDI';
requires 'Cwd';
requires 'Test::More';
requires 'Test::Output';
requires 'Test::MockDateTime';
requires 'Log::Log4perl';
requires 'MIME::Base64';
requires 'Authen::SASL';
requires 'Email::Simple';
requires 'Email::Sender::Transport::SMTP';
requires 'Email::Sender::Simple';

auto_install;

WriteAll;
