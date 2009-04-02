#!perl -T

use Test::More tests => 4;

BEGIN {
    use_ok( 'Encoding::FixLatin', 'fix_latin' );
}

ok(__PACKAGE__->can('fix_latin'), 'fix_latin() function was imported on demand');

is(fix_latin(undef), undef, 'undefined input handled correctly');
is(fix_latin(''), '', 'empty string handled correctly');

