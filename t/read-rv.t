use strict;
use warnings;
use Test::More tests => 3;
require_ok("Config::Simple");

my $file = 'dummy-file.cfg';
ok(Config::Simple->new($file) ? 0 : 1);
ok(Config::Simple->new()->read($file) ? 0 : 1);

