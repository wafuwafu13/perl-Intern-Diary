package Intern::Diary::Engine::Diary;

use strict;
use warnings;
use utf8;

use Intern::Diary::Service::Diary;

sub add_get {
    my ($class, $c) = @_;
    
    $c->html('diary/add.html');
}

sub add_post {
    my ($class, $c) = @_;

    my $name = $c->req->parameters->{name};

    Intern::Diary::Service::Diary->add_diary($c->dbh, {
        user_name  => 'wafuwafu',
        name  => $name,
    });

    $c->res->redirect('/');
}

1;