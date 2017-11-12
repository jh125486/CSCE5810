package Allele;
use strict;
use warnings FATAL => 'all';
use constant DOMINANT => 1;
use constant RECESSIVE => 0;

sub new {
    my $class = shift;
    my $self = {
        _code       => shift,
        _phenotype  => shift,
        _dominant   => shift,
    };
    bless $self, $class;
    return $self;
}

sub code {
    my $self = shift;
    return $self->{_code};
}

sub phenotype {
    my $self = shift;
    return $self->{_phenotype};
}

sub dominant {
    my $self = shift;
    return $self->{_dominant};
}

sub printInfo {
    my $self = shift;
    print $self->phenotype . " (" . $self->code . ") ";
    print "[" . ($self->dominant ? "Dominant" : "Recessive") . "]\n";
}
1;