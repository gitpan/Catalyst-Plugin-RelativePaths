#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'Catalyst::Plugin::RelativePaths' );
}

diag( "Testing Catalyst::Plugin::RelativePaths $Catalyst::Plugin::RelativePaths::VERSION, Perl $], $^X" );
