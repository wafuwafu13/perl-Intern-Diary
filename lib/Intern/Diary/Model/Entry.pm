package Intern::Diary::Model::Entry;

use strict;
use warnings;
use utf8;

use Class::Accessor::Lite (
    rw => [qw(
        title
        body
        diary_id
        entry_id
    )],
    new => 1,
);

1;
