package t::Intern::Diary::Model::Entry;

use strict;
use warnings;
use utf8;
use lib 't/lib';

use Test::More;

use parent 'Test::Class';

use Intern::Diary::Util;

use Test::Intern::Diary;
use Intern::Diary::Model::Entry;

sub _use : Test(startup => 1) {
    my ($self) = @_;
    use_ok 'Intern::Diary::Model::Entry';
}

sub _accessor : Test(6) {
    my $now = Intern::Diary::Util::now;
    my $entry = Intern::Diary::Model::Entry->new(
        entry_id => 1,
        diary_id => 1,
        title => 'entry_title',
        body    => 'entry_body',
        created => DateTime::Format::MySQL->format_datetime($now),
        updated => DateTime::Format::MySQL->format_datetime($now),
    );
    is $entry->entry_id, 1;
    is $entry->diary_id, 1;
    is $entry->title, 'entry_title';
    is $entry->body, 'entry_body';
    is $entry->created, $now;
    is $entry->updated, $now;
}

Test::Class->runtests;

1;
