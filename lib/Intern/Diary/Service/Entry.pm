package Intern::Diary::Service::Entry;

use strict;
use warnings;
use utf8;

use Carp qw(croak);

use Intern::Diary::Util;

sub add_entry {
    my ($class, $db, $args) = @_;

    my $diary_id = $args->{diary_id} // croak 'diary_id required';
    my $title = $args->{title} // croak 'title required';
    my $body = $args->{body} // croak 'body required';

    $db->query(q[
        INSERT INTO entry (diary_id, title, body, created, updated)
          VALUES (?)
    ], [ $diary_id, $title, $body, Intern::Diary::Util::now, Intern::Diary::Util::now ]);
}

sub delete_entry {
    my ($class, $db, $args) = @_;

    my $diary_id = $args->{diary_id} // croak 'diary_id required';
    my $entry_id = $args->{entry_id} // croak 'diary_id required';

    $db->query(q[
        DELETE FROM entry
          WHERE 
            diary_id = ? AND entry_id = ?
    ], $diary_id, $entry_id);
}

1;