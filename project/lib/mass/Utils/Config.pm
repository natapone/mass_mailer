package Mass::Utils::Config;

use Moose;
use Config::JFDI;
use Cwd;

has 'name'      => (is => 'ro', isa => 'Str', lazy =>1, default => 'mass_mailer');
has 'config'    => (is => 'ro', isa => 'HashRef', lazy =>1, builder => '_build_config' );
has 'config_path' => (is => 'ro', isa => 'Str', lazy =>1, builder => '_build_config_path' );

sub _build_config_path {
    my ($self) = @_;

    my $dir = getcwd;
    return "$dir/etc";
}

sub _build_config {
    my ($self) = @_;
    my $config = Config::JFDI->new(
        name                => $self->name,
        path                => $self->config_path,
        config_local_suffix => $ENV{HARNESS_ACTIVE} ? 'test' : 'local',
    );
   return $config->get;
}

1;
