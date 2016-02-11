use strict;
use warnings;

use Data::Dumper;

use Test::More tests => 2;
BEGIN { use_ok('Mass::Utils::Config') };

my $config = Mass::Utils::Config->new();
my $test_config = $config->config;
is($test_config->{'is_test'}, '__YES__', "Return test config" );
