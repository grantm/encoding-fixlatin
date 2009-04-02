package Encoding::FixLatin;

use warnings;
use strict;

require 5.008;

our $VERSION = '0.01';

use Exporter qw(import);

our @EXPORT_OK = qw(fix_latin);


my $byte_map;

my $ascii_char = '[\x00-\x7F]';
my $cont_byte  = '[\x80-\xBF]';

my $utf8_2     = '[\xC0-\xDF]' . $cont_byte;
my $utf8_3     = '[\xE0-\xEF]' . $cont_byte . '{2}';
my $utf8_4     = '[\xF0-\xF7]' . $cont_byte . '{3}';
my $utf8_5     = '[\xF8-\xFB]' . $cont_byte . '{4}';

my $nibble_good_chars = qr{^($ascii_char+|$utf8_2|$utf8_3|$utf8_4|$utf8_5)(.*)$}s;

sub fix_latin {
    my($input) = @_;

    return unless defined($input);
    _init_byte_map() unless $byte_map;

    my $output = '';
    my $char   = '';
    my $rest   = '';
    while(length($input) > 0) {
        if(($char, $rest) = $input =~ $nibble_good_chars) {
            $output .= $char;
        }
        else {
            ($char, $rest) = $input =~ /^(.)(.*)$/s;
            $output .= $byte_map->{$char};
        }
        $input = $rest;
    }
    utf8::decode($output);
    return $output;
}


sub _init_byte_map {
    foreach my $i (0x80..0xFF) {
        my $utf_char = chr($i);
        utf8::encode($utf_char);
        $byte_map->{pack('C', $i)} = $utf_char;
    }
    _add_cp1252_mappings();
}


sub _add_cp1252_mappings {
    # From http://unicode.org/Public/MAPPINGS/VENDORS/MICSFT/WINDOWS/CP1252.TXT
    my %ms_map = (
        "\x80" => "\xE2\x82\xAC",  # EURO SIGN
        "\x82" => "\xE2\x80\x9A",  # SINGLE LOW-9 QUOTATION MARK
        "\x83" => "\xC6\x92",      # LATIN SMALL LETTER F WITH HOOK
        "\x84" => "\xE2\x80\x9E",  # DOUBLE LOW-9 QUOTATION MARK
        "\x85" => "\xE2\x80\xA6",  # HORIZONTAL ELLIPSIS
        "\x86" => "\xE2\x80\xA0",  # DAGGER
        "\x87" => "\xE2\x80\xA1",  # DOUBLE DAGGER
        "\x88" => "\xCB\x86",      # MODIFIER LETTER CIRCUMFLEX ACCENT
        "\x89" => "\xE2\x80\xB0",  # PER MILLE SIGN
        "\x8A" => "\xC5\xA0",      # LATIN CAPITAL LETTER S WITH CARON
        "\x8B" => "\xE2\x80\xB9",  # SINGLE LEFT-POINTING ANGLE QUOTATION MARK
        "\x8C" => "\xC5\x92",      # LATIN CAPITAL LIGATURE OE
        "\x8E" => "\xC5\xBD",      # LATIN CAPITAL LETTER Z WITH CARON
        "\x91" => "\xE2\x80\x98",  # LEFT SINGLE QUOTATION MARK
        "\x92" => "\xE2\x80\x99",  # RIGHT SINGLE QUOTATION MARK
        "\x93" => "\xE2\x80\x9C",  # LEFT DOUBLE QUOTATION MARK
        "\x94" => "\xE2\x80\x9D",  # RIGHT DOUBLE QUOTATION MARK
        "\x95" => "\xE2\x80\xA2",  # BULLET
        "\x96" => "\xE2\x80\x93",  # EN DASH
        "\x97" => "\xE2\x80\x94",  # EM DASH
        "\x98" => "\xCB\x9C",      # SMALL TILDE
        "\x99" => "\xE2\x84\xA2",  # TRADE MARK SIGN
        "\x9A" => "\xC5\xA1",      # LATIN SMALL LETTER S WITH CARON
        "\x9B" => "\xE2\x80\xBA",  # SINGLE RIGHT-POINTING ANGLE QUOTATION MARK
        "\x9C" => "\xC5\x93",      # LATIN SMALL LIGATURE OE
        "\x9E" => "\xC5\xBE",      # LATIN SMALL LETTER Z WITH CARON
        "\x9F" => "\xC5\xB8",      # LATIN CAPITAL LETTER Y WITH DIAERESIS
    );
    while(my($k, $v) = each %ms_map) {
        $byte_map->{$k} = $v;
    }
}


1;

__END__

=head1 NAME

Encoding::FixLatin - takes mixed encoding input and produces UTF-8 output

=head1 SYNOPSIS

    use Encoding::FixLatin qw(fix_latin);

    my $utf8_string = fix_latin($mixed_encoding_string);

=head1 DESCRIPTION

Most encoding conversion tools take input in one encoding and produce output
in another encoding.  This module takes input which may contain characters
in more than one encoding and makes a best effort to produce UTF-8 output.

The following rules are used:

=over 4

=item *

ASCII characters (single bytes in the range 0x00 - 0x7F) are passed through
unchanged.

=item *

Well-formed UTF-8 multi-byte characters are also passed through unchanged.

=item *

Bytes in the range 0xA0 - 0xFF are assumed to be Latin-1 characters (ISO8859-1
encoded) and are converted to UTF-8.

=item *

Bytes in the range 0x80 - 0x9F are assumed to be Win-Latin-1 characters (CP1252 encoded) and are converted to UTF-8.

=back

=head1 EXPORTS

Nothing is exported by default.  The only public function is C<fix_latin> which
will be exported on request (as per SYNOPSIS).

=head1 FUNCTIONS

=head2 fix_latin( string )

Decodes the supplied 'string' and returns a UTF-8 version of the string.

=head1 BUGS

Please report any bugs or feature requests to C<bug-encoding-fixlatin at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Encoding-FixLatin>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.


=head1 SUPPORT

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Encoding-FixLatin>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Encoding-FixLatin>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Encoding-FixLatin>

=item * Search CPAN

L<http://search.cpan.org/dist/Encoding-FixLatin/>

=back


=head1 AUTHOR

Grant McLean, C<< <grantm at cpan.org> >>


=head1 COPYRIGHT & LICENSE

Copyright 2009 Grant McLean

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.


=cut

