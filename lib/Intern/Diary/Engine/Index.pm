package Intern::Diary::Engine::Index;

use strict;
use warnings;
use utf8;

use Intern::Diary::Service::User;
use Intern::Diary::Service::Diary;

sub default {
    my ($class, $c) = @_;

    my $diaries = Intern::Diary::Service::Diary->find_diaries_by_user($c->dbh, {
        user => $c->user,
    });

    $c->html('index.html', {
        diaries => $diaries,
    });
}

1;
__END__
