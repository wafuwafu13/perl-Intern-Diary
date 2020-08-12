use User;

my $user1 = User->new(name => 'John');

# Diary クラスのインスタンスが返る
my $diary = $user1->add_diary(
    name   => 'John の日記です',
);

print $diary->name; # John の日記です

# Entry クラスのインスタンスが返る
my $entry1 = $diary->add_entry(
    title => '日記だよ',
    body  => 'これが日記の本文だよ',
);
my $entry2 = $diary->add_entry(
    title => 'これも日記だよ',
    body  => 'やっぱり日記の本文だよ',
);

my $recent_entries = $diary->get_recent_entries;
print $recent_entries->[0]->{body}; # やっぱり日記の本文だよ
