#!/usr/bin/perl -w

use strict;
use Test;
use Email::Obfuscate qw(obfuscate_email_address);

BEGIN { plan tests => 500 }

my @emails = qw(
	foo@bar.com
	baz@spang.wibble.com
	spat.foo@a.b.c.net
	a1a@b.org
	dryl@xyz.info
);

my $c = qr/^.+AT.+DOT.+$/;
my $d = qr/^.+\[at\].+\[dot\].+$/;
my $e = qr/^.+\@NOSPAM.+$/;
my $f = qr/^.+NOSPAM@.+$/;
my $g = qr/^.+\..+@.+$/;
my $h = qr/^.+\s@\s.+\s\.\s.+$/;
my $i = qr/^.+@@.+\.\..+$/;

for (1..100) {
	for my $email (@emails) {
		ok(obfuscate_email_address('foo@bar.com') =~ m!$c|$d|$e|$f|$g|$h|$i!);
	}
}
