package Diary;
use strict;
use warnings;
use Entry;
use Data::Dumper;
use feature qw(state);

state %entries;

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
    stock_entries($class->{name}, %args);
    Entry->new(%args);
}

sub stock_entries {
    my $diary_name = shift;
    my %args = @_;
    push @{$entries{$diary_name}}, \%args;
}

sub get_recent_entries {
    my $class = shift;
    my $diary_name = $class->{name};
    @{$entries{$diary_name}} = reverse @{$entries{$diary_name}};
    return %entries{$diary_name};
}

1;
