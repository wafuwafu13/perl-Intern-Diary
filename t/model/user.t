package t::Intern::Diary::Model::User;

use strict;
use warnings;
use utf8;
use lib 't/lib';

use Test::Intern::Diary;

use Test::More;

use parent 'Test::Class';

use Intern::Diary::Util;


sub _use : Test(startup => 1) {
    my ($self) = @_;
    use_ok 'Intern::Diary::Model::User';
}

sub _accessor : Test(3) {
    my $now = Intern::Diary::Util::now;
    my $user = Intern::Diary::Model::User->new(
        user_id => 1,
        name    => 'user_name',
        created => DateTime::Format::MySQL->format_datetime($now),
    );
    is $user->user_id, 1;
    is $user->name, 'user_name';
    is $user->created, $now;
}

Test::Class->runtests;

1;