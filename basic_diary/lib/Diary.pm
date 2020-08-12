package Diary;
use strict;
use warnings;
use Entry;

sub new {
    my ($class, %args) = @_;
    return bless \%args, $class;
}

sub name {
    my $class = shift;
    return $class->{name};
}

sub add_entry {
    my ($class, %args) = @_;
    Entry->new(%args);
}

sub get_recent_entries {
    my $class = shift;
    Entry->get_entries;
}

1;
