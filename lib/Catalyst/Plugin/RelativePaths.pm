package Catalyst::Plugin::RelativePaths;

use warnings;
use strict;

=head1 NAME

Catalyst::Plugin::RelativePaths - Make $c->uri_for and $c->req->uri_with return relative URIs

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

=head1 SYNOPSIS

Make $c->uri_for and $c->req->uri_with return relative, instead of absolute URIs.

This is useful in situations where you're for example, redirecting to a lighttpd
from a firewall rule, instead of a real proxy, and you want your links and redirects
to still work correctly.

Also, mtfnpy.

    package MyApp;
    ...
    use Catalyst qw/RelativePaths/;
    ...

=cut

use base qw/Class::Accessor::Fast Class::Data::Inheritable/;
use Class::C3;

sub uri_for {
	my $c = shift;

	$c->next::method(@_)->rel($c->req->uri);
}

{
	package Catalyst::Request::RelativePaths;
	use base 'Catalyst::Request';

	sub uri_with {
		my $req = shift;

		$req->next::method(@_)->rel($req->uri);
	}
}

sub prepare {
	my $class = shift;

	my $c = $class->next::method(@_);

	$c->request_class('Catalyst::Request::RelativePaths');

	return $c
}

=head1 AUTHOR

Rafael Kitover, C<< <rkitover at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-catalyst-plugin-relativepaths at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Catalyst-Plugin-RelativePaths>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Catalyst::Plugin::RelativePaths

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Catalyst-Plugin-RelativePaths>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Catalyst-Plugin-RelativePaths>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Catalyst-Plugin-RelativePaths>

=item * Search CPAN

L<http://search.cpan.org/dist/Catalyst-Plugin-RelativePaths>

=back

=head1 ACKNOWLEDGEMENTS

From #catalyst:

Thanks to vipul for pointing out that this hack can be used to get
around troublesome networking issues.

Thanks to kd for explaining how this is possible, and reviewing
my code.

=head1 COPYRIGHT & LICENSE

Copyright (c) 2008 Rafael Kitover

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1; # End of Catalyst::Plugin::RelativePaths
