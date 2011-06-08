#!/usr/bin/perl

use strict;
use warnings;
use Plack::Builder;
use Plack::App::File;
use Plack::App::CGIBin;

my $base = -e 'Makefile.PL' ? './' : "$ENV{HOME}/.w3c-validator-server";
my $htdocs = "$base/root/htdocs";
my $cgi_bin = "$base/root/cgi-bin";

$ENV{'W3C_VALIDATOR_CFG'} ||= "$base/config/validator.conf";

sub BUILD_APP {
    builder {
        mount '/' => builder {
            enable 'SSI';
            Plack::App::File->new(root => $htdocs)->to_app;
        };
        mount '/check' => (
            Plack::App::WrapCGI->new(script => "$cgi_bin/check")->to_app
        );
    };
}

if(caller) {
    return BUILD_APP();
}
else {
    return (require W3C::Validator::Server)->run(BUILD_APP(), @ARGV);
}
