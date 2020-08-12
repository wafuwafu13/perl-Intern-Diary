use strict;
use warnings;

use Test::More;

use_ok 'User';

ok( defined &User::new );
ok( defined &User::add_diary );

my $user = User->new(
    name => 'John',
);

is $user->{name}, 'John';

done_testing();
