use strict;
use Test::More tests => 8;
use FindBin '$RealBin';
use File::Spec;
require_ok("Config::Simple");

my $ini_file = File::Spec->catfile($RealBin, 'project.ini');
ok(Config::Simple->import_from($ini_file, 'CFG'));

{
    no warnings;
    is($CFG::PROJECT_COUNT, 3);
    is($CFG::PROJECT_2_NAME, 'MPFCU');
    is(ref($CFG::PROJECT_100_NAMES), 'ARRAY');
    is($CFG::PROJECT_100_NAMES->[0], 'First Name');
}

# testing import_into():
Config::Simple->import_from($ini_file, \my %Config);
is($Config{'Project.Count'}, 3);
is($Config{'Project\100.Names'}->[0], 'First Name');

