#!/usr/bin/perl
use strict;
use warnings;
use Fly;
use Allele;
use Gene;
use Chromosome;

use constant MAX_GENERATIONS=300;

my $red_eye_trait = Allele->new("eye color", "W",  "red", Chromosome::X, Allele::DOMINANT);
$red_eye_trait->printInfo;

my $white_eye_trait = Allele->new("eye color", "w", "white", Chromosome::X, Allele::RECESSIVE);
$white_eye_trait->printInfo;

my $eye_trait = Gene->new("X", $red_eye_trait, $white_eye_trait);
print "Eye trait: ". $eye_trait->genotype . "\t";
print "genes: " . scalar @{$eye_trait->alleles}. "\t";
print "phenotype: " .$eye_trait->phenotype->code . " [". $eye_trait->phenotype->phenotype ."]\n\n";

my $fly1 = Fly->new();
my $fly2 = Fly->new();

$fly1->printInfo;
$fly2->printInfo;

if ($fly1->compatible($fly2)) {
    my $fly3 = Fly->new(parent1 => $fly1, parent2 => $fly2);
    $fly3->printInfo;
}


# for 1 -> MAX_GENERATIONS
    # mate -> all combinations
    # keep track of phenotype percentages for this generation


# TYPES of Zygosity:
    # Homozygous (same) -> XX WW (red), XX ww (white)
    # Heterozygous (different) -> XX Ww (red)
    # Hemizygous (one missing) -> XY W- (red), XY w- (white)