package Fly;
use strict;
use warnings FATAL => 'all';
srand(time);


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
    $self->{_attributes} = $args{attributes};
    $self->{_male} = int rand(2); # XXX set sex outside of constructor
    if (!defined $self->{_parent1}) {
        $self->{_generation} = 1;
    }
    else {
        my $g1 = $self->{_parent1}->generation;
        my $g2 = $self->{_parent2}->generation;
        $self->{_generation} = ($g1, $g2)[$g1 > $g2] + 1;
    }

    bless $self, $class;

    return $self;
}

# generation is one more than the lowest generation parent
sub generation {
    my $self = shift;
    return $self->{_generation};
}

sub attributes {
    my $self = shift;
    return $self->{_attributes};
}

sub compatible {
    my ($self, $other) = @_;
    return ($self->{_male} + $other->{_male}) == 1;
}

sub sex {
    my $self = shift;
    return ($self->{_male} ? "M" : "F");
}

sub printInfo {
    my $self = shift;
    print "Generation: ". $self->generation . "\n";
    print "Sex: " . $self->sex . "\n";
#    print "Phenotype: " . $self->attributes . "\n";
    print "\n";
}


1;

# must randomly mate M + F
# New offspring automatically get assigned sex and genetic crossing during construction