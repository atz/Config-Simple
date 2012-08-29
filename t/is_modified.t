use Test::More tests => 2;
use FindBin '$RealBin';
use File::Spec;

require_ok("Config::Simple");

my $cfg_file = File::Spec->catfile($RealBin, 'is_modified.cfg');
my $cfg = new Config::Simple(filename=>$cfg_file)
       or die Config::Simple->error;
ok($cfg);
$cfg->autosave(1);
$cfg->param('newValue', 'Just a test');

