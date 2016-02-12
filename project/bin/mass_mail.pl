use strict;
use warnings;

use Data::Dumper;
use Mass::Mailer;

my $mailer = Mass::Mailer->new(
    subject         => 'อวดเมืองไทยให้นักท่องเที่ยวเห็นกับ LokalHero',
    campaign_id     => '1202',
    template_name   => 'data/template/LokalHero.html',
    # template_name => 't/data/template/join_us.html',
    list_name       => 'data/mail/pro_guide_lot_4.xlsx',
    # list_name       => 'data/mail/test_guide.xlsx',
);

$mailer->send_all;
