use warnings;
use strict;
# use Spreadsheet::ParseExcel;
# use Spreadsheet::XLSX;
# use Date::Format;

my $filename = "bin/mail_list.xlsx";

use Spreadsheet::XLSX;

my $excel = Spreadsheet::XLSX -> new ($filename);

foreach my $sheet (@{$excel -> {Worksheet}}) {
    printf("Sheet: %s\n", $sheet->{Name});
    $sheet -> {MaxRow} ||= $sheet -> {MinRow};
    foreach my $row ($sheet -> {MinRow} .. $sheet -> {MaxRow}) {
        $sheet -> {MaxCol} ||= $sheet -> {MinCol};
        foreach my $col ($sheet -> {MinCol} ..  $sheet -> {MaxCol}) {
            my $cell = $sheet -> {Cells} [$row] [$col];
            if ($cell) {
                printf("( %s , %s ) => %s\n", $row, $col, $cell -> {Val});
            }
        }
    }
}

# #Parse excel file
# my $parser = Spreadsheet::XLSX->new();
# my $workbook = $parser->parse("$filename");
#
# #Get cell value from excel sheet1 row 1 column 2
# my $worksheet = $workbook->worksheet('Sheet1');
# my $cell = $worksheet->get_cell(0,1);
#
# # Print the cell value when not blank
# if ( defined $cell and $cell->value() ne "") {
#     my $value = $cell->value();
#     print "cell value is $value \n";
# }

1
