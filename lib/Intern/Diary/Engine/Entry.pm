package Intern::Diary::Engine::Entry;

use strict;
use warnings;
use utf8;

use Intern::Diary::Service::Entry;

sub default {
    my ($class, $c) = @_;

    my $diary_id = $c->req->path_parameters->{id};

    $c->html('entry/index.html', {
        diary_id => $diary_id,
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

1;
