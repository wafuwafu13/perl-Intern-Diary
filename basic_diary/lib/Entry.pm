package Entry;
use strict;
use warnings;
use feature qw(state);

sub new {
    my ($class, %args) = @_;
    return bless \%args, $class;
}

1;