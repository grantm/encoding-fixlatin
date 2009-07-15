#!perl -T

use Test::More tests => 7;

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

is(fix_latin("M\x{101}ori", bytes_only => 1) => "M\xC4\x81ori",
    'UTF-8 string converted to bytes');
