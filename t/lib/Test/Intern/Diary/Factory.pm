package Test::Intern::Diary::Factory;

use strict;
use warnings;
use utf8;

use String::Random qw(random_regex);
use Exporter::Lite;

our @EXPORT = qw(
    create_user
    create_entry
    create_diary
);

use Intern::Diary::Util;
use Intern::Diary::Context;
use Intern::Diary::Service::User;
use Intern::Diary::Service::Entry;
use Intern::Diary::Service::Diary;

sub create_user {
    my %args = @_;
    my $name = $args{name} // random_regex('test_user_\w{15}');
    my $created = $args{created} // Intern::Diary::Util::now;

    my $c = Intern::Diary::Context->new;
    my $dbh = $c->dbh;
    $dbh->query(q[
        INSERT INTO user (name, created)
          VALUES (?)
    ], [ $name, $created ]);

    return Intern::Diary::Service::User->find_user_by_name($dbh, {
        name => $name
    });
}
