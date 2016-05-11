package Mass::Mailer;

use Moose;
use Data::Dumper;
use Try::Tiny;

use Email::Simple;
use Email::Sender::Simple qw(sendmail);
use Email::Sender::Transport::SMTP ();

use Mass::Utils::Config;
use Mass::Template;
use Mass::Mails;

has 'subject'       => (is => 'ro', isa => 'Str', lazy => 1, default => 'test mailer');
has 'campaign_from' => (is => 'ro', isa => 'Str', lazy => 1, default => 'test@abc.com');
has 'campaign_id'   => (is => 'ro', isa => 'Str', lazy => 1, default => '000');
has 'template_name' => (is => 'ro', isa => 'Str', lazy => 1, default => 'data/template/join_us.html');
has 'list_name'     => (is => 'ro', isa => 'Str', lazy => 1, default => 'data/mail/noob_guide.xlsx');

has 'template'      => (is => 'ro', isa => 'Str', lazy => 1, builder => '_build_template');
has 'mails'         => (is => 'ro', isa => 'HashRef', lazy => 1, builder => '_build_mails');

has 'config'        => (is => 'ro', isa => 'HashRef', lazy => 1, builder => '_build_config');
has 'email_config'  => (is => 'ro', isa => 'HashRef', lazy => 1, builder => '_build_email_config');
has 'transport'     => (
    is      => 'ro',
    isa     => 'Email::Sender::Transport::SMTP',
    lazy    => 1,
    builder => '_build_transport',
);

sub _build_config {
    my $self = shift;

    my $config = Mass::Utils::Config->new();
    return $config->config;
}

sub _build_email_config {
    my $self = shift;
    # print "------ config: ", Dumper($self->config), "\n";
    return $self->config->{email};
}

sub _build_transport {
    my $self = shift;

    my $transport = Email::Sender::Transport::SMTP->new({
        host            => $self->email_config->{host},
        port            => $self->email_config->{port},
        ssl             => $self->email_config->{ssl},
        sasl_username   => $self->email_config->{sasl_username},
        sasl_password   => $self->email_config->{sasl_password},
        debug           => $self->email_config->{debug},
    });
    # print "..... transport==", Dumper($transport), "\n";
    return $transport;
}

sub _build_template {
    my $self = shift;

    # print "Load template ... ", $self->template_name, "\n";
    my $template = Mass::Template->new(filename => $self->template_name);
    return $template->load;
}

sub _build_mails {
    my $self = shift;

    print "Load mailing list ... ", $self->list_name, "\n";
    my $mails = Mass::Mails->new(filename => $self->list_name);
    return $mails->list;
}

sub send_all {
    my $self = shift;

    # read list
    $self->mails;

    # foreach $mail @{$self->mails} {
    foreach my $key ( sort keys %{$self->mails} ) {
        print "Create mail: $key ";

        my $email = $self->create_email( $self->mails->{$key}, $key );
        # print "*** MAIL: ",Dumper($email)," \n";

        # Send!
        try {
            sendmail($email, { transport => $self->transport });
        } catch {
            warn "caught error: $_"; # not $@
        };


        my $now_string = localtime;
        print " ... Send! ",$now_string,"\n";
# exit;
        # sleep 1;
    }

    # read template

}

sub create_email {
    my ($self, $mail_detail, $email_address) = @_;

    # add subject
    $mail_detail->{'MC:SUBJECT'} = $self->subject;

    # add campaign_id
    $mail_detail->{'MC:CAMPAIGN_ID'} = $self->campaign_id;

    # add google analytic id
    $mail_detail->{'MC:GA_ID'} = $self->email_config->{ga_id};

    my $context = $self->template;
    # replace text in template
    foreach my $key ( keys %{$mail_detail} ) {
        # print "     ------- replace $key \n";
        my $find = '\*\|' . $key . '\|\*';
        my $replace = $mail_detail->{$key};
        $context =~ s/$find/$replace/g;
    }

    my $email = Email::Simple->create(
        header => [
            From    => $self->campaign_from,
            To      => $email_address,
            Subject => $self->subject,
            'Content-Type'    => 'text/html',
        ],
        body => $context,
    );

    return $email;
}

1;

# last success
# Create mail: ppol.chai@hotmail.com  ... Send! Fri Feb 12 11:23:56 2016
