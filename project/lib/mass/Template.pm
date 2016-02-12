package Mass::Template;

use Moose;
use Data::Dumper;

has 'filename' => (
    is      => 'ro',
    isa     => 'Str',
    lazy    => 1,
    builder => '_build_filename',
);

sub _build_filename {
    my ( $self ) = @_;

    return 'data/template/join_us.html';
}

sub load {
    my ( $self ) = @_;

    my $string;
    open FILE, $self->filename or die "Couldn't open file: $!";
    while (<FILE>){
     $string .= $_;
    }
    close FILE;

    return $string;
}

1;
