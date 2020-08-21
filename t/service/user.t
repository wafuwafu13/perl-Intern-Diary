package t::Intern::Diary::Service::User;

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

use Intern::Diary::Service::User;
use Intern::Diary::Model::User;

sub require : Test(startup => 1) {
    my ($self) = @_;
    require_ok 'Intern::Diary::Service::User';
}

sub find_user_by_name : Test(2) {
    my ($self) = @_;

    my $c = Intern::Diary::Context->new;

    subtest 'nameないとき失敗する' => sub {
        dies_ok {
            my $user = Intern::Diary::Service::User->find_user_by_name($c->dbh, {
            });
        };
    };

    subtest 'user見つかる' => sub {
        my $created_user = create_user;

        my $user = Intern::Diary::Service::User->find_user_by_name($c->dbh, {
            name => $created_user->name,
        });

        ok $user, 'userが引ける';
        isa_ok $user, 'Intern::Diary::Model::User', 'blessされている';
        is $user->name, $created_user->name, 'nameが一致する';
    };
}

sub create : Test(2) {
    my ($self) = @_;

    my $c = Intern::Diary::Context->new;

    subtest 'ユーザー名わたさないとき失敗する' => sub {
        dies_ok {
            Intern::Diary::Service::User->create($c->dbh, {
            });
        };
    };

    subtest 'ユーザー作成できる' => sub {
        my $name = random_regex('test_user_\w{15}');
        Intern::Diary::Service::User->create($c->dbh, {
            name => $name,
        });

        my $dbh = $c->dbh;
        my $user = $dbh->select_row(q[
            SELECT * FROM user
              WHERE
                name = ?
        ],  $name);

        ok $user, 'ユーザーできている';
        is $user->{name}, $name, 'nameが一致する';
    };
}

Test::Class->runtests;

1;
