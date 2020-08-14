package Intern::Diary::Model::Diary;

use strict;
use warnings;
use utf8;

use Class::Accessor::Lite (
    ro => [qw(
        user
        name
    )],
    new => 1,
);

1;
