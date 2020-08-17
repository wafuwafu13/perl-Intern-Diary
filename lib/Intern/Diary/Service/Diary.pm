package Intern::Diary::Service::Diary;

use strict;
use warnings;
use utf8;

use Carp qw(croak);
use SQL::NamedPlaceholder;

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

sub find_diaries_by_user {
    my ($class, $db, $args) = @_;

    my $user = $args->{user} // croak 'user required';

    my ($sql, $bind) = SQL::NamedPlaceholder::bind_named(q[
        SELECT * FROM diary
        WHERE user = :name
    ], {
        name => $user->name
    });

    my $rows = $db->select_all($sql, @$bind);
   
    return [ map {
        Intern::Diary::Model::Diary->new($_);
    } @$rows ]
}

1;