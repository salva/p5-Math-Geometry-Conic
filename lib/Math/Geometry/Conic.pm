package Math::Geometry::Conic;

our $VERSION = '0.01';

use 5.010;
use strict;
use warnings;

require Exporter;
use Math::Vector::Real;


our @ISA = qw(Exporter);
our @EXPORT_OK = qw(point_equidistant_to_three_circunferences);

sub _det {
    my ($x, $y, $z) = @_;
    my ($x0, $x1, $x2) = @$x;
    my ($y0, $y1, $y2) = @$y;
    my ($z0, $z1, $z2) = @$z;

    return (   $x0 * ($y1 * $z2 - $y2 * $z1)
             + $x1 * ($y2 * $z0 - $y0 * $z2)
             + $x2 * ($y0 * $z1 - $y1 * $z0) );
}

sub point_equidistant_to_three_circunferences {
    my ($o0, $r0, $o1, $r1, $o2, $r2) = @_;

    my @o = ($o0, $o1, $o2);
    my @r = ($r0, $r1, $r2);

    my (@X, @Y, @R, @B);
    for my $i (0..2) {
        my $j = ($i + 1) % 3;

        my ($xi, $yi) = @{$o[$i]};
        my $ri = $r[$i];
        my ($xj, $yj) = @{$o[$j]};
        my $rj = $r[$j];

        $X[$i] = $xi - $xj;
        $Y[$i] = $yi - $yj;
        $R[$i] = $ri - $rj;
        $B[$i] = -0.5 * (   $xi * $xi - $xj * $xj
                          + $yi * $yi - $yj * $yj
                          - $ri * $ri + $rj * $rj );
    }

    my $d = _det(\@X, \@Y, \@R);
    return unless $d;
    my $k = 1 / $d;
    my $r = $k * _det(\@X, \@Y, \@B);
    return unless $r >= 0;

    my $x = $k * _det(\@B, \@Y, \@R);
    my $y = $k * _det(\@X, \@B, \@R);
    my $o = V($x, $y);
    wantarray ? ($o, $r) : $o;
}


1;
__END__

=head1 NAME

Math::Geometry::Conic - Perl extension for blah blah blah

=head1 SYNOPSIS

  use Math::Geometry::Conic;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for Math::Geometry::Conic, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.

=head2 EXPORT

None by default.



=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

Salvador Fandiño, E<lt>salva@E<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2014 by Salvador Fandiño

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.18.2 or,
at your option, any later version of Perl 5 you may have available.


=cut
