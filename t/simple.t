use strict;
use Test::More tests => 9;
use FindBin '$RealBin';
use File::Spec;
require_ok("Config::Simple");

my $ini_file = File::Spec->catfile($RealBin, 'simple.cfg');

my $cfg;
ok($cfg = new Config::Simple());
ok($cfg->read($ini_file));
is($cfg->param('FromEmail'), 'test@handalak.com');
my $vars = $cfg->vars();
is($vars->{'MinImgWidth'}, 10);
ok($cfg->param(-name=>'ProjectName', -value =>'Config::Simple'));
ok($cfg->param(-name=>'ProjectNames', -values=>['First Name', 'Second name']));
ok(($cfg->param('DBN') =~ m/DBI:/), q|$cfg->param('DBN')|);
ok($cfg->save);

