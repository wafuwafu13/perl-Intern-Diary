use strict;
use warnings;
use User;
use Test::More;

use_ok 'Diary';

ok( defined &Diary::new );
ok( defined &Diary::name );
ok( defined &Diary::add_entry );
ok( defined &Diary::get_recent_entries );

my $user = User->new(
    name => 'John',
);

my $diary = $user->add_diary(
    name => "John's diary",
);

is $diary->{name}, "John's diary";

done_testing();
