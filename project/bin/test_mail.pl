#!/usr/bin/perl
use strict;
use warnings;

use Email::Sender::Simple qw(sendmail);
use Email::Sender::Transport::SMTP ();

my $smtpserver = 'smtp.gmail.com';
my $smtpport = 465; # 587;
my $smtpuser   = 'dong@lokalhero.com';
my $smtppassword = 'XXXX';

my $transport = Email::Sender::Transport::SMTP->new({
    host => $smtpserver,
    port => $smtpport,
    ssl => 1,
    sasl_username => $smtpuser,
    sasl_password => $smtppassword,
    debug => 1,
});

my $email = Email::Simple->create(
    header => [
        From    => 'dong@lokalhero.com',
        To      => 'natapone@gmail.com, dong@abctech-thailand.com',
        Subject => 'มาสมัคร LokalHero กันเถอะ!',
    ],
    body => 'สวัสดีชาวโลก',
);

sendmail($email, { transport => $transport });
