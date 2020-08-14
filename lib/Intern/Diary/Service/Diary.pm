package Intern::Diary::Service::Diary;

use strict;
use warnings;
use utf8;

use Carp qw(croak);

use Intern::Diary::Util;
use Intern::Diary::Model::Diary;

sub add_diary {
    my ($class, $db, $args) = @_;

    my $user = $args->{user}->{name} // croak 'user required';
    my $name = $args->{name} // croak 'name required';

    $db->query(q[
        INSERT INTO diary (user, name, created)
          VALUES (?)
    ], [ $user, $name, Intern::Diary::Util::now ]);
}

1;