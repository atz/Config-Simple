use strict;
use warnings;
use FindBin ('$RealBin');
use Test::More tests => 13;
use File::Spec;

use_ok('Config::Simple');

my %files   = (
    'guess_syntax.cfg' => 'simple',
    'bug.cfg'          => 'ini',
    'project.ini'      => 'ini',
    'simple.cfg'       => 'simple',
    'simplified.ini'   => 'ini'
);

while (my ($file, $syntax) = each %files ) {
    my $full_path = File::Spec->catfile($RealBin, $file);
    ok(my $config = Config::Simple->new( $full_path ), "read(): $full_path" );
    is($config->syntax, $syntax, "guess_syntax(): $file  => '$syntax'");
}

my $config = Config::Simple->new( File::Spec->catfile($RealBin, 'simplified.ini') );
is($config->syntax, 'ini', "->syntax");
is($config->{_SUB_SYNTAX}, 'simple-ini', "->{_SUB_SYNTAX}");

