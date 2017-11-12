#!/usr/bin/perl
use strict;
use warnings;
use Fly;
use Allele;

use constant {
    F0_POPULATION   => 20,
    MAX_GENERATIONS => 3,
};

# Genes for eyes and wings
my $red_eyes    = Allele->new( "W", "red",       Allele::DOMINANT );
my $white_eyes  = Allele->new( "w", "white",     Allele::RECESSIVE );
my $long_wings  = Allele->new( "V", "long",      Allele::DOMINANT );
my $short_wings = Allele->new( "v", "vestigial", Allele::RECESSIVE );

my (@population, @males, @females, $alive, $dead);

# create initial population, 50% chance of male or female
for ( my $c = 0 ; $c < F0_POPULATION ; $c++ ) {
    int rand(2) ? push( @males,   Fly->new( 0, 1 ) ) : push( @females, Fly->new( 0, 0 ) );
}

print "-- Initial population: " . F0_POPULATION . " flies [M/F: " . scalar(@males) . "/" . scalar(@females) ."] --\n";

print "Enter percentage of female flies with mutant white eyes (phenotype) [50% chance of recessive carrier]: ";
my $white_eye_females = ( <STDIN> / 100 ) * scalar(@females);

print "Enter percentage of male flies with mutant white eyes (phenotype): ";
my $white_eye_males = ( <STDIN> / 100 ) * scalar(@males);

print "Enter percentage of flies with mutant vestigial wings (phenotype) [50% chance of recessive carrier]: ";
my $short_wing_flies = ( <STDIN> / 100 ) * F0_POPULATION;
print "Each mating produces between " . Fly::MAX_EGGS . " and " . Fly::MIN_EGGS . "larvae\n";
print "Larvae hatch during the same generation and are sexual mature the next generation.\n";
print "Each egg has 50% chance of becoming male or female.\n";
print "Flies can live a maximum of " . Fly::MAX_LIFE . " generations.\n";
print "Observed phenotypes include dead flies\n";
print "Enter percentage of population that mates during a generation: ";
my $mating_percentage = ( <STDIN> / 100 );

for ( my $c = 0 ; $c < $white_eye_females ; $c++ ) {
    $females[$c]->{_allosomes} = [ $white_eyes, $white_eyes ];
}
for ( my $c = $white_eye_females ; $c < scalar(@females) ; $c++ ) {

    # 50% chance of being a recessive carrier
    $females[$c]->{_allosomes} =
      [ $red_eyes, int rand(2) ? $red_eyes : $white_eyes ];
}

for ( my $c = 0 ; $c < $white_eye_males ; $c++ ) {
    $males[$c]->{_allosomes} = [$white_eyes];
}
for ( my $c = $white_eye_males ; $c < scalar(@males) ; $c++ ) {
    $males[$c]->{_allosomes} = [$red_eyes];
}

my @flies = sort { $a->id <=> $b->id } ( @males, @females );
for ( my $c = 0 ; $c < $short_wing_flies ; $c++ ) {
    $flies[$c]->{_autosomes} = [ $short_wings, $short_wings ];
}
for ( my $c = $short_wing_flies ; $c < scalar(@flies) ; $c++ ) {
    $flies[$c]->{_autosomes} =
      [ $long_wings, int rand(2) ? $long_wings : $short_wings ];
}

my $generation = 0;
for ( ; $generation < MAX_GENERATIONS ; $generation++ ) {
    observePopulation();
    my $matings = matingInfo();
    observePhenotypes();

    for ( my $c = $matings ; $c > 0 ; $c-- ) {
        my Fly $male = @males[ int rand( scalar(@males) ) ];
        my Fly $female = @females[ int rand( scalar(@females) ) ];

        # guard clause against dead flies
        if ( !$male->compatible($female) ) { next }

        my @larvae = $male->mate($female);
        foreach my $fly (@larvae) { $fly->{_male} ? push( @males, $fly ) : push( @females, $fly ) }
    }

    for my $fly (@population) { $fly->age }
}

# observe last generation
observePopulation();
observePhenotypes();

# helper functions --------------------------------------------
sub observePopulation {
    @population = ( @males, @females );
    ( $alive, $dead ) = ( 0, 0 );
    for my $fly (@population) { $fly->alive ? $alive++ : $dead++ }

    print "-" x 80 . "\n";
    print "F" . $generation . " population: " . scalar(@population) . "\t";
    print "[M/F: " . scalar(@males) . "/" . scalar(@females) . "]\t";
    print "[alive/dead: " . $alive . "/" . $dead . "]\n";
}

sub matingInfo {
    my $matings = sprintf "%.0f", ( $mating_percentage / 2 ) * $alive;
    print "F" . $generation . " matings: " . $matings . "\n";
    return $matings;
}

sub observePhenotypes {
    print "Observed phenotypes:\n";
    my ( %male_traits, %female_traits );

    foreach my $male   (@males)   { $male_traits{ $male->phenotype }++ }
    foreach my $female (@females) { $female_traits{ $female->phenotype }++ }

    my %set;
    @set{ ( keys %male_traits, keys %female_traits ) } = ();
    my @traits = sort keys %set;

    print "\t  Males: ";
    foreach my $trait (@traits) {
        print "[" . $trait . ": " . (exists $male_traits{$trait} ? $male_traits{$trait} : "0") . "]\t";
    }
    print "\n";

    print "\tFemales: ";
    foreach my $trait (@traits) {
        print "[" . $trait . ": " . (exists $female_traits{$trait} ? $female_traits{$trait} : "0") . "]\t";
    }
    print "\n";
}

# Notes:
# 3 TYPES of Zygosity:
# Homozygous => same
#   Dominant:  XX WW (red)
#   Recessive: XX ww (white)
# Heterozygous => different
#              XX Ww (red)
# Hemizygous => missing
#   Dominant:  XY W- (red)
#   Recessive: XY w- (white)
