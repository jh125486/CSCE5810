package Gene;
use strict;
use warnings FATAL => 'all';
use Allele;
use Data::Dumper;

# figure out dominant recessive gene -> expressed phenotype
# each chromosome gets one of the gene is it's the same type of Chromosome.

sub new {
    my $class = shift;
    my $chromosome = shift;
    my @alleles = @_;

    my @codes;
    foreach my $allele (@alleles) {push @codes, $allele->code};

    my $phenotype = $alleles[-1];
    foreach my $allele (@alleles) {
        if ($allele->dominant) {
            $phenotype = $allele;
        }
    }

    my $self = {
        _chromosome => $chromosome,
        _genotype => join('', sort(@codes)),
        _phenotype => $phenotype,
    };
    $self->{_alleles} = \@alleles;

    bless $self, $class;
    return $self;
}

sub alleles {
    my $self = shift;
    return $self->{_alleles}
}

sub genotype {
    my $self = shift;
    return $self->{_genotype};
}

sub chromosome {
    my $self = shift;
    return $self->{_chromosome};
}

sub phenotype {
    my $self = shift;
   return $self->{_phenotype};
}

1;