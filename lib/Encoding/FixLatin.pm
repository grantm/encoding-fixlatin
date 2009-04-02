package Encoding::FixLatin;

use warnings;
use strict;

require 5.008;

our $VERSION = '0.01';

use Exporter qw(import);

our @EXPORT_OK = qw(fix_latin);


sub fix_latin {
    my($input) = @_;

    return unless defined($input);
    return $input;
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

