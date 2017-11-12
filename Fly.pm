package Fly;
use strict;
use warnings FATAL => 'all';
srand(time);

use constant {
    MAX_LIFE => 3,
    MAX_EGGS => 500,
    MIN_EGGS => 50,
};

my $id = 1;

sub mate {
    my Fly($male, $female) = @_;

    my $generation = ( $male->generation, $female->generation )
      [ $male->generation > $female->generation ] + 1;

    my @larvae;
    for (my $c=0; $c <= rand( MAX_EGGS - MIN_EGGS ) + MIN_EGGS; $c++) {
        my $gender_male =  int rand(2); # 50/50 chance male/female
        my $larva = Fly->new($generation, $gender_male);

        # do genetic crossing from parent1 and parent2
        $larva->{_autosomes} = [@{$female->{_autosomes}}[int rand(2)], @{$male->{_autosomes}}[int rand(2)]];
        if ($gender_male) {
            $larva->{_allosomes} = [@{$female->{_allosomes}}[int rand(2)], @{$male->{_allosomes}}[1]];
        } else {
            $larva->{_allosomes} = [@{$female->{_allosomes}}[int rand(2)], @{$male->{_allosomes}}[0]];
        }

        push @larvae, $larva;
    }
    $male->{_matings}++;
    $female->{_matings}++;
    return @larvae;
}

sub new {
    my ( $class, $generation, $male, %chromosomes ) = @_;
    my $self = {
        _generation => $generation,
        _male       => $male,
        _matings => 0,
    };
    $self->{_autosomes} = $chromosomes{autosomes} || [];
    $self->{_allosomes} = $chromosomes{allosomes} || [];

    $self->{_life} = int rand(MAX_LIFE) + 1;
    $self->{_id}   = $id++;

    bless $self, $class;

    return $self;
}

sub id {
    my $self = shift;
    return $self->{_id};
}

sub alive {
    my $self = shift;
    return $self->{_life} > 0;
}

sub age {
    my $self = shift;
    if ( $self->{_life} > 0 ) { $self->{_life}--; }
}

# generation is one more than the lowest generation parent
sub generation {
    my $self = shift;
    return $self->{_generation};
}

sub autosomes {
    my $self = shift;
    return $self->{_autosomes};
}

sub allosomes {
    my $self = shift;
    return $self->{_allosomes};
}

sub compatible {
    my Fly( $self, $other ) = @_;
    return $self->alive && $other->alive;
}

sub sex {
    my $self = shift;
    return ( $self->{_male} ? "M" : "F" );
}

sub phenotype {
    my $self = shift;
    my @autosomes = @{$self->autosomes};
    my @allosomes = @{$self->allosomes};
    my $phenotype = "";

    if ($autosomes[0]->dominant || ! defined $allosomes[1]) {
        $phenotype .= $autosomes[0]->code;
    } else {
        $phenotype .= $autosomes[1]->code;
    }
    if ($allosomes[0]->dominant || ! defined $allosomes[1])  {
        $phenotype .= $allosomes[0]->code;
    } else {
        $phenotype .= $allosomes[1]->code;
    }
    return $phenotype;
}

sub printInfo {
    my $self = shift;
    print "Fly#" . $self->{_id} . "\tGeneration: " . $self->generation . "\tLife left: " . $self->{_life} . "\t";
    print "Sex: " . $self->sex . "\tMatings: ". $self->{_matings}. "\n";
    print "Phenotype: " . $self->phenotype . "\n";
}

1;
