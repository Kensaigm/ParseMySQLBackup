#!/usr/bin/perl

use strict;
use warnings;

my @queue;
my $header = undef;
my ($hRecord, $table);
my $ofh = undef;

die "Supply MySQL Backup file to process!" unless ($ARGV[0]);

my $filename = "$ARGV[0]";

open (my $fh, '<:encoding(UTF-8)', $filename)
    or die "Could not open file '$filename' $!";

while (my $line = <$fh>){
   my $last_line = queue($line);

   if ($line =~ m/^--\sTable\sstructure\sfor\stable\s/){
     $header = $hRecord unless (defined $header);
     # print ("$line");
     (undef, $table) = split(/`/, $line);
     print ($table . "\r\n");

     new_table($table);
     # print {$ofh} $last_line;
     # print {$ofh} $line;
   }

   if (!defined $header){
      $hRecord = $hRecord . $line;
   }

   print {$ofh} $line unless (!defined $ofh);
}

close ($ofh);

sub new_table {
    close ($ofh) unless (!defined $ofh);
    my $filename = shift;;
    open ($ofh, '>:encoding(UTF-8)', "$filename.sql")
      or die "Could not create new file '$filename.sql' $!";
    print {$ofh} $header;
}

sub queue {
    my $new = shift;
    while (scalar(@queue) >= 5) {
        shift (@queue);
    }
    push @queue, $new;
    return $queue[(scalar(@queue)-2)];
}
