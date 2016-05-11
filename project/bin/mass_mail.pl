use strict;
use warnings;

use Data::Dumper;
use Mass::Mailer;

# profile registration email
# my $mailer = Mass::Mailer->new(
#     subject         => 'อวดเมืองไทยให้นักท่องเที่ยวเห็นกับ LokalHero',
#     campaign_id     => 'P0103',
#     campaign_from   => 'ณฐพล ชาสมบัติ <dong@lokahero.com>',
#     template_name   => 'data/template/LokalHero.html',
#     # template_name => 't/data/template/join_us.html',
#     list_name       => 'data/mail/pro_guide_lot_13.xlsx',
#     # list_name       => 'data/mail/test_guide.xlsx',
# );

# trip registration email
my $mailer = Mass::Mailer->new(
    subject         => 'คุณเป็นไกด์พาเที่ยวที่เหล่านี้ได้หรือเปล่า?',
    campaign_id     => 'T2004',
    campaign_from   => 'ณฐพล ชาสมบัติ <dong@lokahero.com>',
    # template_name   => 'data/template/LokalHero_trip_invite.html',
    template_name   => 'data/template/LokalHero_trip_invite_track.html',
    # list_name       => 'data/mail/test_guide.xlsx',
    list_name       => 'data/mail/pro_guide_lot_13.xlsx',
);

$mailer->send_all;
