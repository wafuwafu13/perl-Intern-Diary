use strict;
use warnings;
use User;
use Entry;
use Test::More;

use_ok 'Entry';

ok( defined &Entry::new );
ok( defined &Entry::name );
ok( defined &Entry::get );
ok( defined &Entry::stock_entry );

my $user = User->new(name => 'John');

my $diary = $user->add_diary(
    name => "John's diary",
);

my $entry1 = $diary->add_entry(
    title => 'diary title 1',
    body  => 'diary sentence 1',
);
my $entry2 = $diary->add_entry(
    title => 'diary title 2',
    body  => 'diary sentence 2',
);

my $recent_entries = $diary->get_recent_entries;
is $recent_entries->[0]->{title}, 'diary title 2';
is $recent_entries->[0]->{body}, 'diary sentence 2';
is $recent_entries->[1]->{title}, 'diary title 1';
is $recent_entries->[1]->{body}, 'diary sentence 1';
is $recent_entries->[2], undef;

done_testing();
