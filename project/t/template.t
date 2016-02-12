use strict;
use warnings;

use Data::Dumper;

use Test::More tests => 2;
BEGIN { use_ok('Mass::Template') };

my $template = Mass::Template->new(filename => 't/data/template/join_us.html');
my $template_join_us = $template->load;

my $expected_template = '<title>*|MC:SUBJECT|*</title>
<h1><span style="font-size:13px; line-height:1.38">สวัสดีครับ คุณ *|FIRST NAME|*&nbsp;</span><span style="font-size:13px; line-height:17.94px">*|LAST NAME|*</span></h1>
';

is($template_join_us, $expected_template, "Template is correct");
