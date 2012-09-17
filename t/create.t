use strict;
use warnings;
use Test::More tests => 12;
use FindBin '$RealBin';
use File::Spec;
use Data::Dumper;

use_ok("Config::Simple", '-strict');

my $file = File::Spec->catfile($RealBin, 'new.cfg');
my $cfg;
ok($cfg = new Config::Simple(syntax=>'ini'),
         "new Config::Simple(syntax=>'ini')");

my %vals = (
    "mysql.dsn"   => "DBI:mysql:db;host=handalak.com",
    "mysql.user"  => "sherzodr",
    "mysql.pass"  => 'marley01',
    "site.title"  => 'sherzodR "The Geek"',
    "debug.state" => 0,
    "debug.delim" => "",
    "debug.other" => undef
);

foreach (keys %vals) {
    $cfg->param($_, $vals{$_});
}
ok($cfg->write($file), "write($file)");
ok(-e $file, "file was written");

#
# There was a bug report, according to which if value of a key evaluates
# to false, (such as "" or 0), Config::Simple wouldn't store them in a file.
#
# Zero seems OK, but empty string/undef is giving errors.
#

ok($cfg = Config::Simple->new($file), "Config::Simple->new($file)");

foreach (reverse sort keys %vals) {
    is(scalar $cfg->param($_), $vals{$_}, "config: $_"); #
#   or print "FAILED PARAM: " . scalar(eval{$cfg->param($_)}) . "\n";
}

unlink $file or die "Cannot delete $file";

