package W3C::Validator::Server;

=head1 NAME

W3C::Validator::Server - Run http://validator.w3c.org as a local instance

=head1 VERSION

0.10

=head1 DESCRIPTION

This application is useful if you want to verify your HTML either offline
or markup that is protected on an intranet. This server should provide
the same sort of validation as L<http://validator.w3c.org>.

=head1 SYNOPSIS

    $ w3c-validator-server.psgi
    $ plackup /usr/bin/w3c-validator-server.psgi
    $ starman path/to/w3c-validator-server.psgi
    $ ./bin/w3c-validator-server.psgi

=cut

use strict;
use warnings;
use base 'Plack::Runner';

our $VERSION = '0.10';

=head1 METHODS

=head2 version_cb

See L<Plack::Runner/version_cb>.

=cut

sub version_cb {
    sub { print "W3C::Validator::Server version $VERSION\n" };
}

=head1 COPYRIGHT & LICENSE

=head1 AUTHOR

Jan Henning Thorsen - C<< jhthorsen at cpan.org >>

=cut

'W3C::Validator::Server';
