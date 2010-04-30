#!perl -T

use Test::More tests => 18;

BEGIN {
    use_ok( 'Encoding::FixLatin', 'fix_latin' );
}

ok(__PACKAGE__->can('fix_latin'), 'fix_latin() function was imported on demand');

is(fix_latin(undef) => undef, 'undefined input handled correctly');
is(fix_latin('')    => '',    'empty string handled correctly');

is(fix_latin('abc') => 'abc', 'printable ASCII string handled correctly');
is(fix_latin("a\nb") => "a\nb", 'embedded newlines cause no problem');

is(fix_latin("\007\011\012") => "\007\011\012",
    'ASCII control characters passed through');

is(fix_latin("\xC2\xA0") => "\x{A0}",
    'UTF-8 NBSP passed through');

is(fix_latin("\xA0") => "\x{A0}",
    'Latin-1 NBSP converted to UTF-8');

is(fix_latin("\xA0\xC2\xA0\xA0") => "\x{A0}\x{A0}\x{A0}",
    'Mixed UTF-8 and Latin-1 NBSPs passed/converted');

is(fix_latin("Caf\xC3\xA9") => "Caf\x{E9}",
    'UTF-8 accented character passed through');

is(fix_latin("Caf\xE9") => "Caf\x{E9}",
    'Latin-1 accented character converted');

is(fix_latin("P\xC3\xA3n Caf\xE9") => "P\x{E3}n Caf\x{E9}",
    'Mixed UTF-8 and Latin-1 accented characters passed/converted');

is(fix_latin("\xE2\x82\xAC") => "\x{20AC}",
    'UTF-8 Euro symbol passed through');

is(fix_latin("\x80") => "\x{20AC}",
    'Win-Latin-1 Euro symbol converted');

is(fix_latin("\x81") => "\x{81}",
    'Latin-1 control character converted');

is(fix_latin("M\x{101}ori") => "M\x{101}ori",
    'UTF-8 string passed through unscathed');

is(fix_latin("\xE0\x83\x9A") => "\x{DA}",
    'Over-long UTF-8 sequence looks OK to Perl');

