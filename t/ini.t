use strict;
use Test::More tests => 18;
use Data::Dumper;
use FindBin '$RealBin';
use File::Spec;

use_ok("Config::Simple");

my $ini_file = File::Spec->catfile($RealBin, 'project.ini');

my $cfg = new Config::Simple();
ok($cfg);
ok($cfg->read($ini_file));
is($cfg->param('Project\2.Name'), 'MPFCU');
is(scalar $cfg->param('Project\1.Count'), 9);
is(scalar $cfg->block(), 5);
my $vars = $cfg->vars();
is($vars->{'Project\2.Name'}, 'MPFCU');
ok($cfg->param(-name=>'Project\100.Name',  -value =>'Config::Simple'));
ok($cfg->param(-name=>'Project\100.Names', -values=>['First Name', 'Second name']));
ok($cfg->param('Project\100.NL', "Hello \nWorld"));
ok($cfg->param('Project\1.Count', 9));

my @names = $cfg->param('Project\100.Names');
is(scalar(@names), 2);

# testing get_block():
ok( ref($cfg->param(-block=>'Project')) eq 'HASH' );
#die Dumper($cfg->param(-block=>'Project'));
ok( $cfg->param(-block=>'Project')->{Count} == 3);

$cfg->param(-block=>'Project', -value=>{Count=>3, set_block=>['working', 'really'], Index=>1, 'Multiple Columns'=>20});
ok($cfg->param('Project.set_block')->[0] eq 'working');

my $names = $cfg->param('Project\100.Names');
is(ref($names), 'ARRAY');
ok($cfg->write());

# now testing the new syntax:
my $data = Config::Simple->parse_ini_file($ini_file);
is(ref($data), 'HASH');


