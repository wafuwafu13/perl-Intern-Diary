package Intern::Diary::Service::User;

use strict;
use warnings;
use utf8;

use Carp qw(croak);

use Intern::Diary::Util;
use Intern::Diary::Model::User;

sub find_user_by_name {
    my ($class, $db, $args) = @_;

    my $name = $args->{name} // croak 'name required';

    my $row = $db->select_row(q[
        SELECT * FROM user
          WHERE name = ?
    ], $name) or return;
    return Intern::Diary::Model::User->new($row);
}

sub create {
    my ($class, $db, $args) = @_;

    my $name = $args->{name} // croak 'name required';

    $db->query(q[
        INSERT INTO user (name, created)
          VALUES (?)
    ], [ $name, Intern::Diary::Util::now ]);

    return $class->find_user_by_name($db, {
        name => $name,
    });
}

1;