#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'Encoding::FixLatin' );
}

diag( "Testing Encoding::FixLatin $Encoding::FixLatin::VERSION, Perl $], $^X" );
