package Entry;
use strict;
use warnings;
use feature qw(state);

sub new {
    my ($class, %args) = @_;
    stock_entry(%args);
    return bless \%args, $class;
}

sub name {
    my $class = shift;
    return $class->{title};
}

sub get {
    my $class = shift;
    return bless [stock_entry()], $class;
}

sub stock_entry {
    state @entries;
    if (@_) {
        my %args = @_;
        push @entries, \%args;
    } else {
        return reverse @entries;
    }
}

1;