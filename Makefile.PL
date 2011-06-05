use inc::Module::Install;

name q(W3C-Validator-Server);
all_from q(lib/W3C/Validator/Server.pm);

requires q(Plack) => 0.9979;

bugtracker q(http://rt.cpan.org/NoAuth/Bugs.html?Dist=W3C-Validator-Server);
homepage q(http://search.cpan.org/dist/W3C-Validator-Server);
repository q(git://github.com///github.com/);

# install_script glob('bin/*');
auto_install;
WriteAll;
