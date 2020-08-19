package Intern::Diary::Engine::Entry;

use strict;
use warnings;
use utf8;

use Intern::Diary::Service::Entry;

sub default {
    my ($class, $c) = @_;

    my $diary_id = $c->req->path_parameters->{id};

    my $entries = Intern::Diary::Service::Entry->find_entries_by_diary($c->dbh, {
        diary_id => $diary_id
    });

    $c->html('entry/index.html', {
        diary_id => $diary_id,
        entries => $entries,
    });
}

sub add_get {
    my ($class, $c) = @_;

    my $diary_id = $c->req->path_parameters->{id};

    $c->html('entry/add.html', {
        diary_id => $diary_id,
    });
}

sub add_post {
    my ($class, $c) = @_;

    my $diary_id = $c->req->path_parameters->{id};
    my $title = $c->req->parameters->{title};
    my $body = $c->req->parameters->{body};

    Intern::Diary::Service::Entry->add_entry($c->dbh, {
        diary_id => $diary_id,
        title => $title,
        body => $body,
    });

    $c->res->redirect('/' . $diary_id);
}

sub delete {
    my ($class, $c) = @_;

    my $diary_id = $c->req->path_parameters->{diary_id};
    my $entry_id = $c->req->path_parameters->{entry_id};

    Intern::Diary::Service::Entry->delete_entry($c->dbh, {
        diary_id => $diary_id,
        entry_id => $entry_id,
    });

    $c->res->redirect('/' . $diary_id);
}

1;
