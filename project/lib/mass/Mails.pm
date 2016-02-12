package Mass::Mails;

use Moose;
use Spreadsheet::XLSX;

use Data::Dumper;

has 'filename' => (
    is      => 'ro',
    isa     => 'Str',
    lazy    => 1,
    builder => '_build_filename',
);

has 'key_field' => (
    is      => 'ro',
    isa     => 'Str',
    lazy    => 1,
    builder => '_build_key_field',
);

sub _build_filename {
    my ( $self ) = @_;

    return 'data/mail/pro_guide.xlsx';
}

sub _build_key_field {
    my ( $self ) = @_;

    return 'EMAIL';
}

sub BUILD {
    ( my $self ) = @_;

    my $mail_header;
    my $mail_list;

    # read data from csv file
    my $excel = Spreadsheet::XLSX->new($self->filename);
    my $sheet = $excel->{Worksheet}->[0]; # read only first sheet

    # printf(".............Sheet name : %s\n", $sheet->{Name});

    # loop read row
    my $row_max =  $sheet->{MaxRow};
    my $row_min =  $sheet->{MinRow};

    print "Reading $row_max rows \n";
    foreach my $row ($row_min .. $row_max) {
        my $mail_detail;
        foreach my $col ($sheet->{MinCol} ..  $sheet->{MaxCol}) {
            my $cell = $sheet->{Cells} [$row] [$col];

            if ($cell) {
                # printf("( %s , %s ) => %s\n", $row, $col, $cell -> {Val});
                # first row is column name
                if ($row == 0) {
                    $mail_header->{$col} = $cell->{Val};
                } else {
                    $mail_detail->{ $mail_header->{$col} } = $cell->{Val};
                }
            }
        }

        # add data to mail list
        # check duplicate from main key
        if ( $mail_list->{$mail_detail->{$self->key_field}} ) {
            print "Duplicate mail: ", Dumper($mail_detail), "\n";
        } else {
            $mail_list->{$mail_detail->{$self->key_field}} = $mail_detail;
        }
    }
    # print "list ....", Dumper($mail_list), "\n";
    # print "header ....", Dumper($mail_header), "\n";

    return $mail_list;
}

1;
