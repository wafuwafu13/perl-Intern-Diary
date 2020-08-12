package Entry;
use strict;
use warnings;
use feature qw(state);

sub new {
    my ($class, %args) = @_;
    manage_entries(%args);
    return bless \%args, $class;
}

sub name {
    my $class = shift;
    return $class->{title};
}

sub get_entries {
    my $class = shift;
    return bless [manage_entries()], $class;
}

sub manage_entries {
    state @entries;
    if (@_) {
        my %args = @_;
        push @entries, \%args;
    } else {
        return_entries(@entries);
    }
}

sub return_entries {
    my @entries = @_;
    return reverse @entries;
}

1;