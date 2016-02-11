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

sub _build_filename {
    my ( $self ) = @_;

    return 'data/mail/pro_guide.xlsx';
}

sub BUILD {
    ( my $self ) = @_;

    my $mail_header;

    # read data from csv file
    my $excel = Spreadsheet::XLSX->new($self->filename);
    my $sheet = $excel->{Worksheet}->[0]; # read only first sheet

    printf(".............Sheet name : %s\n", $sheet->{Name});

    # loop read row
    my $row_max =  $sheet->{MaxRow};
    my $row_min =  $sheet->{MinRow};
    print "Reading $row_max rows \n";
    foreach my $row ($row_min .. $row_max) {
        # $sheet -> {MaxCol} ||= $sheet -> {MinCol};

        foreach my $col ($sheet->{MinCol} ..  $sheet->{MaxCol}) {
            my $cell = $sheet->{Cells} [$row] [$col];
            if ($cell) {
                printf("( %s , %s ) => %s\n", $row, $col, $cell -> {Val});
                # first row is column name
                if ($row == 0) {
                    $mail_header->{$col} = $cell->{Val};
                }
            }


        }
print "header ....", Dumper($mail_header), "\n";
        exit;
        # first row is column name
        # if (%mail_hash) {
        #     $sheet->{MaxCol} ||= $sheet -> {MinCol};
        # }

    }



    return $excel;
}

sub list {

}


1;
