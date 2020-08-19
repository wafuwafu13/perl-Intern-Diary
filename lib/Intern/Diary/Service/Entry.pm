package Intern::Diary::Service::Entry;

use strict;
use warnings;
use utf8;

use Carp qw(croak);
use SQL::NamedPlaceholder;

use Intern::Diary::Util;
use Intern::Diary::Model::Entry;

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

sub find_entries_by_diary {
    my ($class, $db, $args) = @_;

    my $diary_id = $args->{diary_id} // croak 'diary_id required';

    my ($sql, $bind) = SQL::NamedPlaceholder::bind_named(q[
        SELECT * FROM entry
        WHERE diary_id = :diary_id
    ], {
        diary_id => $diary_id
    });

    my $rows = $db->select_all($sql, @$bind);
   
    return [ map {
        Intern::Diary::Model::Entry->new($_)
    } @$rows ];
}

sub find_entry_by_id {
    my ($class, $db, $args) = @_;

    my $diary_id = $args->{diary_id} // croak 'diary_id required';
    my $entry_id = $args->{entry_id} // croak 'entry_id required';

    my ($sql, $bind) = SQL::NamedPlaceholder::bind_named(q[
        SELECT * FROM entry
        WHERE diary_id = :diary_id AND entry_id = :entry_id
    ], {
        diary_id => $diary_id,
        entry_id => $entry_id,
    });

    my $entry = $db->select_row($sql, @$bind);
   
    return  Intern::Diary::Model::Entry->new($entry);
}

sub edit_entry {
  my ($class, $db, $args) = @_;

  my $diary_id = $args->{diary_id} // croak 'diary_id required';
  my $entry_id = $args->{entry_id} // croak 'entry_id required';
  my $title = $args->{title} // croak 'title required';
  my $body = $args->{body} // croak 'body required';

  $db->query(q[
        UPDATE entry
          SET 
            title = ?, body = ? 
          WHERE
            diary_id = ? AND entry_id = ?
    ], $title, $body, $diary_id, $entry_id);
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