package W3C::Validator::Server;

=head1 NAME

W3C::Validator::Server - http://validator.w3c.org

=head1 VERSION

0.10

=head1 DESCRIPTION

=head1 SYNOPSIS

    plackup lib/W3C/Validator/Server.pm

=head1 COPYRIGHT & LICENSE

=head1 AUTHOR

Jan Henning Thorsen - C<< jhthorsen at cpan.org >>

=cut

use strict;
use warnings;
use Plack::Builder;
use Plack::App::CGIBin;

our $VERSION = '0.10';

my $htdocs = 'htdocs';
my $cgi_bin = 'cgi-bin';

builder {
    mount '/' => builder {
        enable 'SSI';
        Plack::App::File->new(root => $htdocs)->to_app;
    };
    mount '/cgi-bin' => (
        Plack::App::CGIBin->new(script => $cgi_bin)->to_app
    );
};
