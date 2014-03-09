#!/usr/bin/perl

use strict;
use warnings;
use Math::Geometry::Conic;

use Test::More;

*_det = \&Math::Geometry::Conic::_det;

is(_det([1,0,0], [0,1,0], [0,0,1]), 1);
is(_det([2,0,0], [0,2,0], [0,0,2]), 8);

is(_det([1,1,1], [0,1,1], [0,0,1]), 1);

for my $i (0..100) {
    my @x = map { rand(2) - 1 } 0..2;
    my @col = map { [map { rand(2) -1 } 0..2] } 0..2;
    my @b = (0, 0, 0);
    for my $i (0..2) {
        for my $j (0..2) {
            $b[$i] += $col[$j][$i] * $x[$j];
        }
    }
    my $det = _det(@col);
    next unless $det * $det > 0.001;

    my @o = map {
        my @col1 = @col;
        $col1[$_] = \@b;
        _det(@col1) / $det } 0..2;

    my $e2 = 0;
    $e2 += ($x[$_] - $o[$_]) ** 2 for 0..2;
    if ($e2 < 0.01) {
        ok(1);
    }
    else {
        ok(0);
        diag "x: @x\no: @o\nc0: @{$col[0]}\nc1: @{$col[1]}\nc2: @{$col[2]}\nb: @b\n";
    }

}

done_testing();
