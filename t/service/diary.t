package t::Intern::Diary::Service::Diary;

use strict;
use warnings;
use utf8;
use lib 't/lib';

use parent qw(Test::Class);
use Test::More;
use Test::Deep;
use Test::Exception;

use Test::Intern::Diary;
use Test::Intern::Diary::Mechanize;

use String::Random qw(random_regex);

use Intern::Diary::Context;
use Test::Intern::Diary::Factory;

use Intern::Diary::Service::Diary;
use Intern::Diary::Model::Diary;

sub require : Test(startup => 1) {
    my ($self) = @_;
    require_ok 'Intern::Diary::Service::Diary';
}

sub add_diary : Test(3) {
    my ($self) = @_;

    my $c = Intern::Diary::Context->new;

    subtest 'userわたさないとき失敗する' => sub {
        my $name = random_regex('test_name_\w{15}');
        dies_ok {
            my $Diary = Intern::Diary::Service::Diary->add_diary($c->dbh, {
                name => $name
            });
        };
    };

    subtest 'nameわたさないとき失敗する' => sub {
        my $user = create_user;
        dies_ok {
            my $Diary = Intern::Diary::Service::Diary->add_diary($c->dbh, {
                user_name => $user->name
            });
        };
    };

    subtest 'diary作成できる' => sub {
        my $user = create_user;
        my $name = random_regex('test_name_\w{15}');

        my $diary = Intern::Diary::Service::Diary->add_diary($c->dbh, {
            user_name => $user->name,
            name => $name,
        });

        my $dbh = $c->dbh;
        my $diary = $dbh->select_row(q[
            SELECT * FROM diary
              WHERE
                name = ?
        ],  $name);

        ok $diary, '日記できている';
        is $diary->{user}, $user->name, 'userが一致する';
        is $diary->{name}, $name, 'nameが一致する';
    };
}

Test::Class->runtests;

1;
