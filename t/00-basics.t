#!perl -T

use Test::More tests => 4;

BEGIN {
    use_ok( 'Encoding::FixLatin' );
}

ok(!main->can('fix_latin'), 'fix_latin() function was not imported');

is(Encoding::FixLatin::fix_latin(undef), undef, 'undefined input handled correctly');
is(Encoding::FixLatin::fix_latin(''), '', 'empty string handled correctly');

