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


    my ($x0, $y0) = @$o0;
    my @o = ($o1, $o2);
    my @r = ($r1, $r2);
    my (@X, @Y, @R, @B);
    for my $i (0..1) {
        my ($xi, $yi) = @{$o[$i]};
        my $ri = $r[$i];

        $X[$i] = $xi - $x0;
        $Y[$i] = $yi - $y0;
        $R[$i] = $r0 - $ri;
        $B[$i] = 0.5 * (   $xi * $xi - $x0 * $x0
                         + $yi * $yi - $y0 * $y0
                         - $ri * $ri + $r0 * $r0 );
    }

    my $det = $X[0] * $Y[1] - $X[1] * $Y[0];
    return unless $det;
    my $idet = 1 / $det;

    my $xr = $idet * ($R[0] * $Y[1] - $R[1] * $Y[0]);
    my $xb = $idet * ($B[0] * $Y[1] - $B[1] * $Y[0]);

    my $yr = $idet * ($X[0] * $R[1] - $X[1] * $R[0]);
    my $yb = $idet * ($X[0] * $B[1] - $X[1] * $B[0]);

    my $xb0 = $xb - $x0;
    my $yb0 = $yb - $y0;

    my $a = $xr * $xr + $yr * $yr - 1;
    return unless $a; # degenerated case
    my $inv_a = 1 / $a;
    my $b = $inv_a * ($xb0 * $xr + $yb0 * $yr - $r0);
    my $c = $inv_a * ($xb0 * $xb0 + $yb0 * $yb0 - $r0 * $r0);

    my $discriminant = $b * $b - $c;
    return unless $discriminant >= 0;
    my $sqrt_discriminant = sqrt($discriminant);

    my $r = -$b - $sqrt_discriminant;
    if ($r < 0) {
        $r = -$b + $sqrt_discriminant;
        return if $r < 0;
    }

    my $x = $xr * $r + $xb;
    my $y = $yr * $r + $yb;

    

    wantarray ? (V($x, $y), $r) : V($x, $y);
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
