use strict;
use warnings;
use User;
use Test::More;

use_ok 'Diary';

ok( defined &Diary::new, "newメソッドが定義されている" );
ok( defined &Diary::name, "nameメソッドが定義されている" );
ok( defined &Diary::add_entry, "add_entryメソッドが定義されている" );
ok( defined &Diary::stock_entries, "stock_entriesメソッドが定義されている" );
ok( defined &Diary::get_recent_entries, "get_recent_entriesメソッドが定義されている" );

my $user = User->new(
    name => 'John',
);

my $diary = $user->add_diary(
    name => "John's diary",
);

is $diary->{name}, "John's diary", "newメソッドが正しく動作する";

done_testing();
