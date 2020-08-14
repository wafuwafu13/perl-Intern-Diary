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
    my $entry = Entry->new(%args);
    stock_entries($class->{name}, $entry);
}

sub stock_entries {
    my ($diary_name, $entry) = @_;
    push @{$entries{$diary_name}}, $entry;
}

sub get_recent_entries {
    my $class = shift;
    my $diary_name = $class->{name};
    my @result_entries = reverse @{$entries{$diary_name}};
    return \@result_entries;
}

1;
