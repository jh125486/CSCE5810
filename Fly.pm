package Fly;
use strict;
use warnings FATAL => 'all';
srand(time);

use constant MAX_LIFE => 3;

my $id = 0;

sub mate {
    my ($male, $female) = @_;


    # do genetic crossing on all attributes from parent1 and parent2

    # return 2-d array of 4 flies [[0,1],[2,3]]
    # first array is females, second is males
}

sub new {
    my ($class, %args) = @_;
    my $self = {};
    $self->{_parent1} = $args{parent1};
    $self->{_parent2} = $args{parent2};
    $self->{_genes} = $args{genes};

    # New offspring automatically get assigned sex and genetic crossing during construction
    $self->{_male} = int rand(2); # XXX set sex outside of constructor

    if (!defined $self->{_parent1}) {
        $self->{_generation} = 1;
    }
    else {
        my $g1 = $self->{_parent1}->generation;
        my $g2 = $self->{_parent2}->generation;
        $self->{_generation} = ($g1, $g2)[$g1 > $g2] + 1;
    }

    $self->{_life} = int rand(MAX_LIFE) + 1;
    $self->{_id} = $id++;

    bless $self, $class;

    return $self;
}

sub alive {
    my $self = shift;
    return $self->{_life} > 0;
}

sub age {
    my $self = shift;
    $self->{_life}--;
}

# generation is one more than the lowest generation parent
sub generation {
    my $self = shift;
    return $self->{_generation};
}

sub genes {
    my $self = shift;
    return $self->{_genes};
}

sub compatible {
    my ($self, $other) = @_;
    return (($self->{_male} + $other->{_male}) == 1) && $self->alive && $other->alive;
}

sub sex {
    my $self = shift;
    return ($self->{_male} ? "M" : "F");
}

sub printInfo {
    my $self = shift;
    print "Fly#".$self->{_id}."\tGeneration: ". $self->generation . "\tLife left: " . $self->{_life} . "\t";
    print "Sex: " . $self->sex . "\n";

    #    print "Phenotype: " . $self->genes . "\n";
    print "\n";
}


1;
