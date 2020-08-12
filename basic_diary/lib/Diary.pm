package Diary;
use strict;
use warnings;
use Entry;

# name渡ってきてる
sub new {
    my ($class, %args) = @_;
    return bless \%args, $class;
}

sub name {
    my $class = shift;
    my $name = $class->{name};
    return "$name\n";
}

sub add_entry {
    my ($class, %args) = @_;
    Entry->new(%args);
}

sub get_recent_entries {
    my $class = shift;
    Entry->get;
}

1;
