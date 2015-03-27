#!/usr/bin/perl
# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

my string__hash_ref $s_hash;
$s_hash = {
    titans     => 'ccm',
    redhawks   => 'msu',
    redraiders => 'ttu',
    bears      => 'bu'
};
my string $s = 'titans';
print $s_hash->{$s};