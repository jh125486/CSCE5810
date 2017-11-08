#!/usr/bin/perl
use strict;
use warnings;
use Fly;
use Allele;
use Gene;
use Chromosome;

use constant MAX_GENERATIONS => 300;

my $red_eye_traitX = Allele->new("eye color", "W", "red", Chromosome::X, Allele::DOMINANT);
my $white_eye_traitX = Allele->new("eye color", "w", "white", Chromosome::X, Allele::RECESSIVE);

my $eye_gene_homozygous_dominant = Gene->new("Eye color", $red_eye_traitX, $red_eye_traitX);
my $eye_gene_homozygous_recessive = Gene->new("Eye color", $red_eye_traitX, $red_eye_traitX);
my $eye_gene_heterozygous = Gene->new("Eye color", $red_eye_traitX, $white_eye_traitX);
my $eye_gene_hemizygous = Gene->new("Eye color", $white_eye_traitX);

$eye_gene_homozygous_dominant->printInfo;
$eye_gene_heterozygous->printInfo;
$eye_gene_hemizygous->printInfo;
$eye_gene_homozygous_recessive->printInfo;

my $fly1 = Fly->new(genes=>[ $eye_gene_homozygous_dominant ]);
my $fly2 = Fly->new(genes=>[ $eye_gene_heterozygous ]);

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