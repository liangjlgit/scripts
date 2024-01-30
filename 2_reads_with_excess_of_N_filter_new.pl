#!perl -w
use warnings;
use strict;

#N_num is 10
open( FASTQ1,  "<$ARGV[0]" ) or die "can't open file $ARGV[0]";
open( FASTQ2,  "<$ARGV[1]" ) or die "can't open file $ARGV[1]";
open( OUTPUT1, ">$ARGV[2]" ) or die "can't create file $ARGV[2]";
open( OUTPUT2, ">$ARGV[3]" ) or die "can't create file $ARGV[3]";
my $N_num = $ARGV[4];

my $total      = 0;
my $reads1     = "";
my $reads2     = "";
my $out_line_1 = "";
my $out_line_2 = "";
my $clean      = 0;
while (1) {
	my $line11 = <FASTQ1>;
	my $line12 = <FASTQ1>;
	my $line13 = <FASTQ1>;
	my $line14 = <FASTQ1>;
	
	my $line21 = <FASTQ2>;
	my $line22 = <FASTQ2>;
	my $line23 = <FASTQ2>;
	my $line24 = <FASTQ2>;
	
	if(! defined($line12) || ! defined($line22)){
		last;
	}
	
	$line12 =~ s/\s+$//ig;
	$line22 =~ s/\s+$//ig;
	
	my $line12_rm_N = $line12;
	my $line22_rm_N = $line22;
	
	$line12_rm_N =~ s/N|n//ig;
	$line22_rm_N =~ s/N|n//ig;
	
	my $total_N_num = length($line12)-length($line12_rm_N)+length($line22)-length($line22_rm_N);
	if ( $total_N_num <= $N_num ) {
		$reads1 = $line11.$line12."\n".$line13.$line14;
		$reads2 = $line21.$line22."\n".$line23.$line24;
		$out_line_1 .= $reads1;
		$out_line_2 .= $reads2;
		$clean++;
	}
	if ( $clean % 100000 == 0 ) {    ### 减少输出次数，降低 io
		print OUTPUT1 $out_line_1;
		print OUTPUT2 $out_line_2;
		$out_line_1 = "";
		$out_line_2 = "";
	}
	$total++;
	$reads1 = "";
	$reads2 = "";

}
if ( $clean % 100000 != 0 ) {
	print OUTPUT1 $out_line_1;
	print OUTPUT2 $out_line_2;
}
print "total number of reads is $total.\n"
  . "number of reads with number of N less than $N_num"
  . " is $clean.\n";
close OUTPUT1;
close OUTPUT2;
close FASTQ1;
close FASTQ2;

