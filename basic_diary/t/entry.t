use strict;
use warnings;
use User;
use Entry;
use Test::More;

use_ok 'Entry';

ok( defined &Entry::new, "newメソッドが定義されている" );

my $user = User->new(name => 'John');

my $diary = $user->add_diary(
    name => "John's diary",
);

my $secret_diary = $user->add_diary(
    name => "John's secret diary"
);

my $entry1 = $diary->add_entry(
    title => 'diary title 1',
    body  => 'diary sentence 1',
);
my $entry2 = $diary->add_entry(
    title => 'diary title 2',
    body  => 'diary sentence 2',
);
my $entry3 = $secret_diary->add_entry(
    title => 'secret diary title',
    body => 'secret diary sentence',
);

my $recent_entries = $diary->get_recent_entries;
is $recent_entries->[0]->{title}, 'diary title 2', '正しい記事のタイトルを取得できる';
is $recent_entries->[0]->{body}, 'diary sentence 2', '正しい記事の本文を取得できる';
is $recent_entries->[1]->{title}, 'diary title 1', '正しい記事のタイトルを取得できる';
is $recent_entries->[1]->{body}, 'diary sentence 1', '正しい記事の本文を取得できる';
is scalar @$recent_entries, 2, '記事は2つである';

my $recent_secret_entries = $secret_diary->get_recent_entries;
is $recent_secret_entries->[0]->{title}, 'secret diary title', '異なる日記の正しい記事のタイトルを取得できる';
is $recent_secret_entries->[0]->{body}, 'secret diary sentence', '異なる日記の正しい記事の本文を取得できる';

done_testing();
