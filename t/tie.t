use strict;
use warnings;
use Test::More;
use FindBin '$RealBin';
use File::Spec;

use_ok("Config::Simple", '-strict');

my ($obj, $file, %Config);
ok($file = File::Spec->catfile($RealBin, 'project.ini'), "finding project.ini");
ok($obj = tie(%Config, 'Config::Simple', $file), "tie hash for $file");
#ok( exists $Config{'Project\1.Count'}, 'exists $Config{"Project\1.Count"}' );    # wtf: this FAILS under make test and succeeds on perl t/tie.t

# open(FOO, ">err.dump"); print FOO tied(%Config)->dump; close FOO;

is($Config{'Project\0.Name'}, 'Default', 'config: Project\0.Name');
is(scalar(keys %Config), 24, "Right number of keys in \%Config");
delete $Config{'Project\1.Count'};
ok(!exists($Config{'Project\1.Count'}), 'config: Project\1.Name');

done_testing;
