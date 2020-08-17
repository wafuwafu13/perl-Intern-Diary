#!/usr/bin/env perl
use strict;
use warnings;
use utf8;

use Encode qw(encode_utf8 decode_utf8);
use Pod::Usage;

use FindBin;
use lib "$FindBin::Bin/../lib";

use DBIx::Sunny;


use Intern::Diary::Config;
use Intern::Diary::Service::User;
use Intern::Diary::Service::Diary;
use Intern::Diary::Service::Entry;

BEGIN { $ENV{INTERN_DIARY_ENV} = 'local' };

my %HANDLERS = (
    add_diary    => \&add_diary,
    list_diaries   => \&list_diaries,
    add_entry    => \&add_entry,
    delete_entry => \&delete_entry,
);

my $name    = shift @ARGV;
my $command = shift @ARGV;

my $db      = do {
    my $config = config->param('db')->{intern_diary};
    DBIx::Sunny->connect(map { $config->{$_} } qw(dsn user password));
};

my $user = Intern::Diary::Service::User->find_user_by_name($db, +{ name => $name });
unless ($user) {
    $user = Intern::Diary::Service::User->create($db, +{ name => $name });
}

my $handler = $HANDLERS{ $command } or pod2usage;
$handler->($user, @ARGV);

exit 0;

sub add_diary {
    my ($user, $name) = @_;

    die 'name required' unless defined $name;

    my $diary = Intern::Diary::Service::Diary->add_diary($db, +{
        user => $user,
        name => $name,
    });

    print 'Create diary';
}

sub list_diaries {
    my ($user) = @_;

    my $diaries = Intern::Diary::Service::Diary->find_diaries_by_user($db, +{
        user => $user
    });

    foreach my $diary (@$diaries) {
        print $diary->name . "\n";
    }
}

sub add_entry {
    my ($user, $diary_id, $title, $body) = @_;

    die 'diary_id required' unless defined $diary_id;
    die 'title required' unless defined $title;
    die 'body required' unless defined $body;

    my $entry = Intern::Diary::Service::Entry->add_entry($db, +{
        diary_id => $diary_id,
        title => $title,
        body => $body,
    });

    print 'Add entry';
}

sub delete_entry {
    my ($user, $diary_id, $entry_id) = @_;
    
    die 'diary_id required' unless defined $diary_id;
    die 'entry_id required' unless defined $entry_id;

    my $entry = Intern::Diary::Service::Entry->delete_entry($db, +{
        diary_id => $diary_id,
        entry_id => $entry_id,
    });

    print 'Delete entry';
}