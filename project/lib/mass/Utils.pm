package Mass::Utils;

use Moose::Role;

use Mass::Utils::Config;
use Mass::Utils::Log;

has 'config' => (is => 'ro', isa => 'HashRef', lazy => 1, builder => '_build_config');
has 'logger' => (is => 'ro', isa => 'Log::Log4perl::Logger', lazy => 1,
                            default => sub { Mass::Utils::Log->new()->init });

sub _build_config {
    my $self = shift;

    my $config = Mass::Utils::Config->new();
    return $config->config;
}

1;
