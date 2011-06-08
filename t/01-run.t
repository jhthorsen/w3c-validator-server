use warnings;
use strict;
use Test::More;

plan skip_all => 'cannot find w3c-validator-server.psgi' unless(-e 'bin/w3c-validator-server.psgi');
plan tests => 3;

my $psgi_script = 'bin/w3c-validator-server.psgi';
my $shell_script = 'bin/w3c-validator-install.sh';

ok(-x $shell_script, "$shell_script is executable");
ok(-x $psgi_script, "$psgi_script is executable");
ok(eval qq(require "$psgi_script"), "$psgi_script is compilable") or diag $@;
