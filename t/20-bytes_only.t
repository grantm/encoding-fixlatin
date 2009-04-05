#!perl -T

use Test::More 'no_plan';# tests => 16;

BEGIN {
    use_ok( 'Encoding::FixLatin', 'fix_latin' );
}

is(length(fix_latin("a b")), 3,
    "string length for simple ascii input looks OK");

is(length(fix_latin("a\xC2\xA0b")), 3,
    "string length for utf8 input looks OK");

is(length(fix_latin("a\xA0b")), 3,
    "string length for latin-1 input looks OK");

is(length(fix_latin("a\xC2\xA0b", bytes_only => 1)), 4,
    "string length for utf8 input looks OK");

is(length(fix_latin("a\xA0b", bytes_only => 1)), 4,
    "string length for utf8 input looks OK");

