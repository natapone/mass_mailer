package Mass::Utils::Log;

use strict;
use warnings;
use Moose;
use Log::Log4perl;

use Mass::Utils::Config;

has 'config'    => (is => 'ro', isa => 'HashRef', lazy => 1, builder => '_build_config');
has 'logparams' => (is => 'ro', isa => 'HashRef', lazy => 1, builder => '_build_logparams');
has 'init'      => (is => 'ro', lazy => 1, builder => '_build_init');

sub _build_config {
    my $self = shift;

    my $config = Mass::Utils::Config->new();
    return $config->config;
}

sub _build_logparams {
    my $self = shift;

    return $self->config->{'logger'};
}

sub _build_init {
    my $self = shift;

    Log::Log4perl->init( $self->logparams );
    return Log::Log4perl->get_logger();
}

1;
