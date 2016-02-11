use strict;
use warnings;

use Data::Dumper;

use Test::More tests => 1;
BEGIN { use_ok('Mass::Mails') };

my $excel = Mass::Mails->new(filename => 't/data/mail/pro_guide.xlsx');
print "......", $excel, "\n";

# isa_ok ($excel, "Hash");

# print "------\n";

1;
