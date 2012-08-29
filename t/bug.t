use strict;
use warnings;
use Test::More tests => 14; 
use Data::Dumper;
use FindBin '$RealBin';
use File::Spec;

use_ok("Config::Simple", qw(-strict));

my $ini_file = File::Spec->catfile($RealBin, 'bug.cfg');

my($cfg, $vars);
ok($cfg = Config::Simple->new(), '$cfg = Config::Simple->new');
ok($cfg->read($ini_file),        '->read') or die Config::Simple->error;
ok($vars = $cfg->vars(),         '$vars = $cfg->vars');

is(ref($vars), 'HASH', "returns HASHref");
is(scalar @{$vars->{'Default.Inner_Color'}}, 3);
is(scalar @{$vars->{'Default.Outer_Color'}}, 3);
is($vars->{'Default.Outer_Color'}->[1], 0);
is($vars->{'Default.Outer_Color'}->[2], 0.1);

#warn $vars->{'WIN32.My_Music'}, "\n";
is($vars->{'WIN32.My_Documents'}, "C:\\DOCUMENTS AND SETTINGS\\SHERZOD RUZMETOV\\MY DOCUMENTS\\");
is($vars->{'WIN32.My_Music'}, "C:\\DOCUMENTS AND SETTINGS\\SHERZOD RUZMETOV\\MY DOCUMENTS\\MY MUSIC\\");
is($vars->{'WIN32.My_Pictures'}, "C:\\DOCUMENTS AND SETTINGS\\SHERZOD RUZMETOV\\MY DOCUMENTS\\MY PICTURES\\");

$cfg->param('WIN32.My_Money', $vars->{'WIN32.My_Documents'} . "MY MONEY\\");

is($cfg->param('WIN32.My_Money'), "C:\\DOCUMENTS AND SETTINGS\\SHERZOD RUZMETOV\\MY DOCUMENTS\\MY MONEY\\");
ok($cfg->write); 

