#!/usr/bin/perl

use strict;
use warnings;
use Plack::Builder;
use Plack::App::File;
use Plack::App::CGIBin;

my $htdocs = $ENV{'W3C_HTDOCS'} || 'htdocs';
my $cgi_bin = $ENV{'W3C_CGI_BIN'} || 'cgi-bin';

sub BUILD_APP {
    builder {
        mount '/' => builder {
            enable 'SSI';
            Plack::App::File->new(root => $htdocs)->to_app;
        };
        mount '/cgi-bin' => (
            Plack::App::CGIBin->new(script => $cgi_bin)->to_app
        );
    };
}

if(caller) {
    return BUILD_APP();
}
else {
    return (require W3C::Validator::Server)->run(BUILD_APP(), @ARGV);
}
