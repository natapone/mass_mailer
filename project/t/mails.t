use strict;
use warnings;

use Data::Dumper;

use Test::More tests => 4;
BEGIN { use_ok('Mass::Mails') };

my $mails = Mass::Mails->new(filename => 't/data/mail/pro_guide.xlsx');
my $mail_list = $mails->list;
# print "......", Dumper($mail_list), "\n";

isa_ok ($mail_list, "HASH");

my $mail = 'pier-aga@hotmail.com';
is($mail_list->{$mail}->{'TRADER_NAME'}, 'นายพิชญพงศ์ เอกัคคตาจิต');
is( $mail_list->{$mail}->{'TELEPHONE'}, '02-2824460');

1;
