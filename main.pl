#!/usr/bin/perl
use strict;
use warnings;
use Fly;
use Allele;
use Gene;
use Chromosome;

# Flies are immediately sexual mature
# Flies can live a maximum of Fly::MAX_LIFE generations

use constant {
    MAX_GENERATIONS => 5,
    POPULATION_PERCENTAGE_THAT_MATES => 0.8,
};

my $red_eye_traitX = Allele->new("eye color", "W", "red", Chromosome::X, Allele::DOMINANT);
my $white_eye_traitX = Allele->new("eye color", "w", "white", Chromosome::X, Allele::RECESSIVE);

my $eye_gene_homozygous_dominant = Gene->new("Eye color", $red_eye_traitX, $red_eye_traitX);
my $eye_gene_homozygous_recessive = Gene->new("Eye color", $white_eye_traitX, $white_eye_traitX);
my $eye_gene_heterozygous = Gene->new("Eye color", $red_eye_traitX, $white_eye_traitX);
my $eye_gene_hemizygous_dominant = Gene->new("Eye color", $red_eye_traitX);
my $eye_gene_hemizygous_recessive = Gene->new("Eye color", $white_eye_traitX);

$eye_gene_homozygous_dominant->printInfo;
$eye_gene_homozygous_recessive->printInfo;
$eye_gene_heterozygous->printInfo;
$eye_gene_hemizygous_dominant->printInfo;
$eye_gene_hemizygous_recessive->printInfo;

my $fly1 = Fly->new(genes=>[ $eye_gene_homozygous_dominant ]);
my $fly2 = Fly->new(genes=>[ $eye_gene_hemizygous_dominant ]);

$fly1->printInfo;
$fly2->printInfo;

if ($fly1->compatible($fly2)) {
    print "Mated 1 & 2\n";
    my $fly3 = Fly->new(parent1 => $fly1, parent2 => $fly2);
    $fly3->printInfo;
}
$fly1->age;
$fly2->age;
if ($fly1->compatible($fly2)) {
    print "Mated 1 & 2\n";
    my $fly3 = Fly->new(parent1 => $fly1, parent2 => $fly2);
    $fly3->printInfo;
}

$fly1->printInfo;


# Generate N number of flies -> percentage of Genes given on command line input
# for 1 -> MAX_GENERATIONS
# while $matings < PERCENTAGE_OF_POPULATION
    # START NEW GENERATION
        # choose two random flies
            # must be compatible
            # -> mating produces M number of flies in matrix percentages
        # go through all flies and $fly->age
        # keep track of genotype/phenotype percentages for this generation
        # keep track of flies alive, flies born

#------------------------------------------------------------------------------------
# TYPES of Zygosity:
# Homozygous (same) -> XX WW (red) dominant, XX ww (white) recessive
# Heterozygous (different) -> XX Ww (red)
# Hemizygous (one missing) -> XY W- (red) dominant, XY w- (white) recessive