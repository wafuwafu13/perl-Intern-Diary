use strict;
use warnings;

use Test::More;

use_ok 'User';

ok( defined &User::new, "newメソッドが定義されている" );
ok( defined &User::add_diary, "add_diaryメソッドが定義されている" );

my $user = User->new(
    name => 'John',
);

is $user->{name}, 'John', "newメソッドが正しく動作する";

done_testing();
