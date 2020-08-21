package t::Intern::Diary::Model::Diary;

use strict;
use warnings;
use utf8;
use lib 't/lib';

use Test::Intern::Diary;
use Intern::Diary::Model::Diary;

use Test::More;

use parent 'Test::Class';

use Intern::Diary::Util;


sub _use : Test(startup => 1) {
    my ($self) = @_;
    use_ok 'Intern::Diary::Model::Diary';
}

sub _accessor : Test(4) {
    my $now = Intern::Diary::Util::now;
    my $diary = Intern::Diary::Model::Diary->new(
        diary_id => 1,
        user => 'user_name',
        name    => 'diary_name',
        created => DateTime::Format::MySQL->format_datetime($now),
    );
    is $diary->diary_id, 1;
    is $diary->user, 'user_name';
    is $diary->name, 'diary_name';
    is $diary->created, $now;
}

Test::Class->runtests;

1;
