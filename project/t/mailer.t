use strict;
use warnings;

use Data::Dumper;

use Test::More tests => 4;
BEGIN { use_ok('Mass::Mailer') };

my $mailer = Mass::Mailer->new();
my $transport = $mailer->transport;
isa_ok ($transport, "Email::Sender::Transport::SMTP");

$mailer = Mass::Mailer->new(
    subject         => 'This is Spata!',
    campaign_id     => '1111',
    template_name   => 't/data/template/join_us.html',
    list_name       => 't/data/mail/noob_guide.xlsx',
);

# $mailer->send_all;
