package User;
use strict;
use warnings;
use Diary;

sub new {
    my ($class, %args) = @_;
    return bless \%args, $class;
}

sub add_diary {
    my ($class, %args) = @_;
    Diary->new(%args);
}

1;