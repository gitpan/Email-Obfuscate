# $Revision: 1.11 $
# $Id: Obfuscate.pm,v 1.11 2003/12/09 10:51:25 afoxson Exp $

# Email::Obfuscate - Obfuscates email addresses                                 # Copyright (c) 2003 Adam J. Foxson. All rights reserved.

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

package Email::Obfuscate;

use strict;
use constant DEBUG => 0;
use Exporter;
use vars qw(@ISA @EXPORT_OK $VERSION);

local $^W = 1;

@ISA = qw(Exporter);
@EXPORT_OK = qw(obfuscate_email_address);
($VERSION) = '$Revision: 1.11 $' =~ /\s+(\d+\.\d+)\s+/;

sub obfuscate_email_address {
	my $e = shift;
	my @obfuscators = (
		sub {my $e = shift; $e =~ s/@/ AT /; $e =~ s/\./ DOT /g; $e},
		sub {my $e = shift; $e =~ s/@/[at]/; $e =~ s/\./[dot]/g; $e},
		sub {my $e = shift; $e =~ s/@/\@NOSPAM./; $e},
		sub {my $e = shift; $e =~ s/@/.NOSPAM@/; $e},
		sub {my $e = shift; $e = reverse $e; $e},
		sub {my $e = shift; $e =~ s/@/ @ /; $e =~ s/\./ . /; $e},
		sub {my $e = shift; $e =~ s/@/@@/; $e =~ s/\./../g; $e},
		sub {my $e = shift; $e =~ s/(.)/$1 /g; $e},
	);
	my $rand = int(rand($#obfuscators + 1));

	if (DEBUG) {
		for my $num (0 .. $#obfuscators) {
			warn "DEBUG: ", $obfuscators[$num]->($e), "\n";
		}
	}

	return $obfuscators[$rand]->($e);
}

1;
