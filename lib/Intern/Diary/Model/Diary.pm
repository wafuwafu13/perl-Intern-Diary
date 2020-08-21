package Intern::Diary::Model::Diary;

use strict;
use warnings;
use utf8;

use Class::Accessor::Lite (
    rw => [qw(
        user
        name
        diary_id
        created
    )],
    new => 1,
);

1;
